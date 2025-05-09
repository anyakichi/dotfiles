#!/usr/bin/env python3

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this
# file, You can obtain one at http://mozilla.org/MPL/2.0/.

import asyncio
import re

import i3ipc.aio as i3ipc

layout = {
    "layout": "splith",
    "nodes": [
        {
            "layout": "tabbed",
            #"width": 67,
            #"nodes": [
            #    {
                    "swallows": {"app_id": r"qutebrowser"},
                    "marks": ["b"]
            #    }
            #]
        },
        {
            "layout": "tabbed",
            "width": '846 px',
            "nodes": [
                {
                    "swallows": {"app_id": r"foot"},
                    "marks": ["t"]
                }
            ]
        }
    ]
}

def iter_leaves(subtree):
    for node in subtree["nodes"]:
        node["parent"] = subtree
        if node.get("swallows"):
            yield node
        if node.get("nodes") is not None:
            yield from iter_leaves(node)
leaves = list(iter_leaves(layout))

def try_match(con):
    for leaf in leaves:
        if leaf.get("con"):
            continue

        for key, pattern in leaf["swallows"].items():
            if (value := getattr(con, key, None)) is None:
                break
            if re.search(pattern, value) is None:
                break
        else:
            leaf["con"] = con

def check_all_leaves_matched():
    for leaf in leaves:
        if leaf.get("con") is None:
            return False
    return True

async def main():
    sway = await i3ipc.Connection().connect()

    # Subscribe to events first to make sure we don't miss anything
    def on_window(self, event):
        try_match(event.container)
        if check_all_leaves_matched():
            sway.main_quit()
    sway.on("window", on_window)

    for con in await sway.get_tree():
        try_match(con)

    if not check_all_leaves_matched():
        # Wait until all windows have appeared
        await sway.main()

    # This really shouldn't be necessary, but we get a warning otherwise
    # (this could be a bug in i3ipc)
    sway.off(on_window)

    await asyncio.sleep(1)
    for leaf in leaves:
        await leaf["con"].command("move scratchpad")

    async def apply_layout(subtree):
        applied_split = False
        for node in subtree["nodes"]:
            if con := node.get("con"):
                await con.command("move workspace 1")
                await con.command("floating disable")
                if not applied_split:
                    await con.command("split h")
                    await con.command(f"layout {subtree['layout']}")
                    applied_split = True
                await con.command("focus")
            elif node.get("nodes") is not None:
                await apply_layout(node)
        if con := subtree["nodes"][0].get("con"):
            await con.command("focus parent")
    await apply_layout(layout)

    for leaf in leaves:
        con = leaf["con"]
        await con.command("focus")
        await con.command(f"resize set {leaf.get('width', 0)} \
                {leaf.get('height', 0)}")
        for mark in leaf.get('marks', []):
            await con.command(f"mark --add {mark}")
        while leaf := leaf.get("parent"):
            await sway.command("focus parent")
            await sway.command(f"resize set {leaf.get('width', 0)} \
                    {leaf.get('height', 0)}")

    await leaves[0]["con"].command("focus")
    await sway.command("splith")
    await sway.command("layout tabbed")

asyncio.run(main())
