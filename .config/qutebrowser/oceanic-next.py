from qutebrowser.config.config import ConfigContainer
from qutebrowser.config.configfiles import ConfigAPI

config: ConfigAPI = config  # type: ignore[reportPossiblyUnbound]
c: ConfigContainer = c  # type: ignore[reportPossiblyUnbound]

base00 = "#1b2b34"
base01 = "#343d46"
base02 = "#4f5b66"
base03 = "#65737e"
base04 = "#a7adba"
base05 = "#c0c5ce"
base06 = "#cdd3de"
base07 = "#d8dee9"
base08 = "#ec5f67"
base09 = "#f99157"
base0A = "#fac863"
base0B = "#99c794"
base0C = "#5fb3b3"
base0D = "#6699cc"
base0E = "#c594c5"
base0F = "#ab7967"

c.colors.completion.category.bg = base00
c.colors.completion.category.border.bottom = base00
c.colors.completion.category.border.top = base00
c.colors.completion.category.fg = base0A
c.colors.completion.even.bg = base00
c.colors.completion.fg = base05
c.colors.completion.item.selected.bg = base02
c.colors.completion.item.selected.border.bottom = base02
c.colors.completion.item.selected.border.top = base02
c.colors.completion.item.selected.fg = base05
c.colors.completion.item.selected.match.fg = base0B
c.colors.completion.match.fg = base0B
c.colors.completion.odd.bg = base01
c.colors.completion.scrollbar.bg = base00
c.colors.completion.scrollbar.fg = base05

c.colors.contextmenu.disabled.bg = base01
c.colors.contextmenu.disabled.fg = base04
c.colors.contextmenu.menu.bg = base00
c.colors.contextmenu.menu.fg = base05
c.colors.contextmenu.selected.bg = base02
c.colors.contextmenu.selected.fg = base05

c.colors.downloads.bar.bg = base00
c.colors.downloads.error.fg = base08
c.colors.downloads.start.bg = base0D
c.colors.downloads.start.fg = base00
c.colors.downloads.stop.bg = base0C
c.colors.downloads.stop.fg = base00

c.colors.hints.bg = base0A
c.colors.hints.fg = base00
c.colors.hints.match.fg = base05

c.colors.keyhint.bg = base00
c.colors.keyhint.fg = base05
c.colors.keyhint.suffix.fg = base05

c.colors.messages.error.bg = base08
c.colors.messages.error.border = base08
c.colors.messages.error.fg = base00
c.colors.messages.info.bg = base00
c.colors.messages.info.border = base00
c.colors.messages.info.fg = base05
c.colors.messages.warning.bg = base0E
c.colors.messages.warning.border = base0E
c.colors.messages.warning.fg = base00

c.colors.prompts.bg = base00
c.colors.prompts.border = base00
c.colors.prompts.fg = base05
c.colors.prompts.selected.bg = base02
c.colors.prompts.selected.fg = base05

c.colors.statusbar.caret.bg = base0E
c.colors.statusbar.caret.fg = base00
c.colors.statusbar.caret.selection.bg = base0D
c.colors.statusbar.caret.selection.fg = base00
c.colors.statusbar.command.bg = base00
c.colors.statusbar.command.fg = base05
c.colors.statusbar.command.private.bg = base00
c.colors.statusbar.command.private.fg = base05
c.colors.statusbar.insert.bg = base0D
c.colors.statusbar.insert.fg = base00
c.colors.statusbar.normal.bg = base00
c.colors.statusbar.normal.fg = base0B
c.colors.statusbar.passthrough.bg = base0C
c.colors.statusbar.passthrough.fg = base00
c.colors.statusbar.private.bg = base01
c.colors.statusbar.private.fg = base00
c.colors.statusbar.progress.bg = base0D
c.colors.statusbar.url.error.fg = base08
c.colors.statusbar.url.fg = base06
c.colors.statusbar.url.hover.fg = base07
c.colors.statusbar.url.success.http.fg = base06
c.colors.statusbar.url.success.https.fg = base06
c.colors.statusbar.url.warn.fg = base0E

c.colors.tabs.bar.bg = base00
c.colors.tabs.even.bg = base00
c.colors.tabs.even.fg = base05
c.colors.tabs.indicator.error = base08
c.colors.tabs.indicator.start = base0D
c.colors.tabs.indicator.stop = base0C
c.colors.tabs.odd.bg = base01
c.colors.tabs.odd.fg = base05
c.colors.tabs.pinned.even.bg = base0C
c.colors.tabs.pinned.even.fg = base01
c.colors.tabs.pinned.odd.bg = base0B
c.colors.tabs.pinned.odd.fg = base01
c.colors.tabs.pinned.selected.even.bg = base02
c.colors.tabs.pinned.selected.even.fg = base05
c.colors.tabs.pinned.selected.odd.bg = base02
c.colors.tabs.pinned.selected.odd.fg = base05
c.colors.tabs.selected.even.bg = base07
c.colors.tabs.selected.even.fg = base02
c.colors.tabs.selected.odd.bg = base07
c.colors.tabs.selected.odd.fg = base02
