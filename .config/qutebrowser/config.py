import subprocess

from qutebrowser.config.config import ConfigContainer
from qutebrowser.config.configfiles import ConfigAPI

config: ConfigAPI = config  # type: ignore[reportPossiblyUnbound]
c: ConfigContainer = c  # type: ignore[reportPossiblyUnbound]


config.load_autoconfig()
config.source("hook.py")

#
# Command mode
#
config.bind("<Ctrl-w>", "rl-backward-kill-word", mode="command")

config.bind("<Ctrl+n>", "completion-item-focus --history next", mode="command")
config.bind("<Ctrl+p>", "completion-item-focus --history prev", mode="command")


#
# Normal mode
#

# Tab management
config.bind("t", "cmd-set-text -s :open -t")
config.bind("T", "cmd-set-text :open -t {url:pretty}")
config.bind("a", "tab-prev")
config.bind("s", "tab-next")
config.bind("<Ctrl-p>", "tab-prev")
config.bind("<Ctrl-n>", "tab-next")
config.bind("<Ctrl-l>", "tab-move +")
config.bind("<Ctrl-h>", "tab-move -")
config.bind("<Ctrl-Shift-l>", "tab-move ;; tab-move -")
config.bind("<Ctrl-Shift-h>", "tab-move")
config.bind("<Ctrl-m>", "back ;; forward -t")
config.bind(
    "<Ctrl-t>",
    'config-cycle tabs.padding -t {"bottom":\\ 2,"left":\\ 1,"right":\\ 1,"top":\\ 2} {"bottom":\\ 4,"left":\\ 2,"right":\\ 2,"top":\\ 4}'
    " ;; config-cycle -t tabs.pinned.shrink true false"
    " ;; config-cycle -t tabs.position top left"
    ' ;; config-cycle -t tabs.title.format_pinned "" "{audio}{current_title}"',
)
config.bind("<Ctrl-s>", "cmd-set-text -s :tab-select")
config.bind("<Ctrl-/>", "cmd-set-text -s :tab-select")
for i in range(1, 10):
    config.bind(f"<Ctrl-{i}>", f"tab-focus {i}")

config.bind("O", "cmd-set-text :open {url:pretty}")
config.bind("gU", "cmd-run-with-count 99 navigate up")

config.bind("<Ctrl-Shift-n>", "open -w")
config.bind("<Ctrl-Shift-p>", "open -p")

config.bind("x", "forward")
config.bind("z", "back")
config.bind("<Alt-Right>", "forward")
config.bind("<Alt-Left>", "back")

config.bind("<Ctrl-Shift-r>", "restart")
config.bind("<Ctrl-Shift-c>", "config-source")

# workaround for double close
config.bind("d", "cmd-later 50 tab-close")

config.bind("<Ctrl-q>", "mode-enter passthrough")
config.unbind("<Ctrl-v>")
config.unbind("<Ctrl-w>")

#
# Insert mode
#

config.bind("<Alt-Right>", "forward", mode="insert")
config.bind("<Alt-Left>", "back", mode="insert")

config.bind("<Ctrl-o>", "edit-text", mode="insert")

# Emacs key binding
config.bind("<Ctrl-f>", "fake-key <Right>", mode="insert")
config.bind("<Ctrl-b>", "fake-key <Left>", mode="insert")
config.bind("<Ctrl-a>", "fake-key <Home>", mode="insert")
config.bind("<Ctrl-e>", "fake-key <End>", mode="insert")
config.bind("<Ctrl-n>", "fake-key <Down>", mode="insert")
config.bind("<Ctrl-p>", "fake-key <Up>", mode="insert")
config.bind("<Alt-f>", "fake-key <Ctrl-Right>", mode="insert")
config.bind("<Alt-b>", "fake-key <Ctrl-Left>", mode="insert")
config.bind("<Ctrl-d>", "fake-key <Delete>", mode="insert")
config.bind("<Ctrl-h>", "fake-key <Backspace>", mode="insert")
config.bind("<Alt-d>", "fake-key <Ctrl-Delete>", mode="insert")
config.bind("<Ctrl-w>", "fake-key <Ctrl-backspace>", mode="insert")
config.bind("<Ctrl-u>", "fake-key <Home><Ctrl-k>", mode="insert")

# pass
qute_pass = "qute-pass -d 'fuzzel --dmenu' --username-target secret --username-pattern 'username: (.+)'"
config.bind("<ctrl-,><ctrl-,>", f"spawn --userscript {qute_pass}", mode="insert")
config.bind("<ctrl-,><ctrl-.>", f"spawn --userscript {qute_pass} .", mode="insert")
config.bind(
    "<ctrl-,>u", f"spawn --userscript {qute_pass} --username-only", mode="insert"
)
config.bind(
    "<ctrl-,>p", f"spawn --userscript {qute_pass} --password-only", mode="insert"
)
config.bind("<ctrl-,>o", f"spawn --userscript {qute_pass} --otp-only", mode="insert")

config.bind("<ctrl-,>X", f"spawn --userscript translate -t ja --text")


#
# Settings
#

c.aliases = {}

c.auto_save.session = True
c.content.default_encoding = "utf-8"
for x in ["amazon.co.jp", "chatgpt.com", "github.com"]:
    config.set("content.javascript.clipboard", "access-paste", x)
c.content.pdfjs = True
c.editor.command = ["browser-edit", "-c", "normal {line}G{column0}l", "{file}"]
c.input.insert_mode.auto_load = True

c.completion.web_history.max_items = 10000

# Search engines
c.url.searchengines["DEFAULT"] = "https://www.google.com/search?q={}&hl=en"
c.url.searchengines["g"] = "https://www.google.com/search?q={}&hl=en"
c.url.searchengines["ge"] = "https://www.google.com/search?q={}&hl=en"
c.url.searchengines["gj"] = "https://www.google.com/search?q={}&hl=ja"

c.tabs.min_width = 80
c.tabs.padding = {"bottom": 4, "left": 2, "right": 2, "top": 4}
c.tabs.pinned.shrink = False
c.tabs.position = "left"
c.tabs.select_on_remove = "prev"
c.tabs.show = "always"
c.tabs.title.format = "{audio}{current_title}"
c.tabs.title.format_pinned = c.tabs.title.format
c.tabs.width = 30

c.window.hide_decoration = True

c.fonts.default_family = "monospace"
c.fonts.default_size = "10.5pt"
c.fonts.web.family.standard = "sans-serif"

pac_proxy = config.configdir / "proxy.pac"
if pac_proxy.exists():
    c.qt.args.append(f"proxy-pac-url=file://{pac_proxy}")


#
# Theme
#
def is_dark_mode():
    try:
        result = subprocess.run(
            ["gsettings", "get", "org.gnome.desktop.interface", "color-scheme"],
            capture_output=True,
            text=True,
            timeout=3,
        )
        return "prefer-dark" in result.stdout
    except Exception:
        return False


if is_dark_mode():
    config.source("oceanic-next.py")
else:
    config.source("oceanic-next-light.py")
