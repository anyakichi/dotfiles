from qutebrowser.config.config import ConfigContainer
from qutebrowser.config.configfiles import ConfigAPI

config: ConfigAPI = config  # type: ignore[reportPossiblyUnbound]
c: ConfigContainer = c  # type: ignore[reportPossiblyUnbound]

config.source("oceanic-next.py")

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

c.colors.tabs.bar.bg = base07
c.colors.tabs.even.bg = base07
c.colors.tabs.even.fg = base01
c.colors.tabs.odd.bg = base06
c.colors.tabs.odd.fg = base01
c.colors.tabs.pinned.selected.even.bg = base03
c.colors.tabs.pinned.selected.even.fg = base07
c.colors.tabs.pinned.selected.odd.bg = base03
c.colors.tabs.pinned.selected.odd.fg = base07
c.colors.tabs.selected.even.bg = base03
c.colors.tabs.selected.even.fg = base07
c.colors.tabs.selected.odd.bg = base03
c.colors.tabs.selected.odd.fg = base07
