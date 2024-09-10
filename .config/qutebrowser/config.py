c = c
config = config

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
config.bind("a", "tab-prev")
config.bind("s", "tab-next")
config.bind("<Ctrl-p>", "tab-prev")
config.bind("<Ctrl-n>", "tab-next")
config.bind("tt", "cmd-set-text -s :open -t")
config.bind("tT", "cmd-set-text :open -t {url:pretty}")
config.bind("td", "tab-close")
config.bind("t'", "tab-focus")
config.bind("tl", "tab-move +")
config.bind("th", "tab-move -")
config.bind("tL", "tab-move ;; tab-move -")
config.bind("tH", "tab-move")
config.bind("tu", "undo")
config.bind("tU", "undo -w")
config.bind("tm", "back ;; forward -t")
config.bind("<Ctrl-t>", "config-cycle -t tabs.position top left")
config.bind("<Ctrl-s>", "cmd-set-text -s :tab-select")
config.bind("t/", "cmd-set-text -s :tab-select")
config.bind("<Ctrl-w>", "nop")

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
qute_pass = "qute-pass -d 'wofi --dmenu' --username-target secret --username-pattern 'username: (.+)'"
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
c.content.pdfjs = True
c.editor.command = [
    "tmux",
    "new-window",
    "trap 'tmux wait-for -S qutebrowser-{file}' 0 && nvim -c 'normal {line}G{column0}l' {file}",
    ";",
    "wait-for",
    "qutebrowser-{file}",
]
c.input.insert_mode.auto_load = True

c.completion.web_history.max_items = 10000

# Search engines
c.url.searchengines["DEFAULT"] = "https://www.google.com/search?q={}&hl=en"
c.url.searchengines["g"] = "https://www.google.com/search?q={}&hl=en"
c.url.searchengines["ge"] = "https://www.google.com/search?q={}&hl=en"
c.url.searchengines["gj"] = "https://www.google.com/search?q={}&hl=ja"

c.tabs.min_width = 100
c.tabs.padding = {"bottom": 1, "left": 1, "right": 1, "top": 1}
c.tabs.pinned.shrink = False
c.tabs.position = "top"
c.tabs.select_on_remove = "prev"
c.tabs.show = "always"
c.tabs.title.format_pinned = c.tabs.title.format
c.tabs.width = 100

c.window.hide_decoration = True

c.fonts.web.family.standard = "sans-serif"


# base16-qutebrowser (https://github.com/theova/base16-qutebrowser)
# Base16 qutebrowser template by theova
# OceanicNext scheme by https://github.com/voronianski/oceanic-next-color-scheme

base00 = "#1B2B34"
base01 = "#343D46"
base02 = "#4F5B66"
base03 = "#65737E"
base04 = "#A7ADBA"
base05 = "#C0C5CE"
base06 = "#CDD3DE"
base07 = "#D8DEE9"
base08 = "#EC5f67"
base09 = "#F99157"
base0A = "#FAC863"
base0B = "#99C794"
base0C = "#5FB3B3"
base0D = "#6699CC"
base0E = "#C594C5"
base0F = "#AB7967"

# set qutebrowser colors

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
c.colors.completion.fg = base05

# Background color of the completion widget for odd rows.
c.colors.completion.odd.bg = base01

# Background color of the completion widget for even rows.
c.colors.completion.even.bg = base00

# Foreground color of completion widget category headers.
c.colors.completion.category.fg = base0A

# Background color of the completion widget category headers.
c.colors.completion.category.bg = base00

# Top border color of the completion widget category headers.
c.colors.completion.category.border.top = base00

# Bottom border color of the completion widget category headers.
c.colors.completion.category.border.bottom = base00

# Foreground color of the selected completion item.
c.colors.completion.item.selected.fg = base05

# Background color of the selected completion item.
c.colors.completion.item.selected.bg = base02

# Top border color of the selected completion item.
c.colors.completion.item.selected.border.top = base02

# Bottom border color of the selected completion item.
c.colors.completion.item.selected.border.bottom = base02

# Foreground color of the matched text in the selected completion item.
c.colors.completion.item.selected.match.fg = base0B

# Foreground color of the matched text in the completion.
c.colors.completion.match.fg = base0B

# Color of the scrollbar handle in the completion view.
c.colors.completion.scrollbar.fg = base05

# Color of the scrollbar in the completion view.
c.colors.completion.scrollbar.bg = base00

# Background color of disabled items in the context menu.
c.colors.contextmenu.disabled.bg = base01

# Foreground color of disabled items in the context menu.
c.colors.contextmenu.disabled.fg = base04

# Background color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.bg = base00

# Foreground color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.fg = base05

# Background color of the context menu’s selected item. If set to null, the Qt default is used.
c.colors.contextmenu.selected.bg = base02

# Foreground color of the context menu’s selected item. If set to null, the Qt default is used.
c.colors.contextmenu.selected.fg = base05

# Background color for the download bar.
c.colors.downloads.bar.bg = base00

# Color gradient start for download text.
c.colors.downloads.start.fg = base00

# Color gradient start for download backgrounds.
c.colors.downloads.start.bg = base0D

# Color gradient end for download text.
c.colors.downloads.stop.fg = base00

# Color gradient stop for download backgrounds.
c.colors.downloads.stop.bg = base0C

# Foreground color for downloads with errors.
c.colors.downloads.error.fg = base08

# Font color for hints.
c.colors.hints.fg = base00

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
c.colors.hints.bg = base0A

# Font color for the matched part of hints.
c.colors.hints.match.fg = base05

# Text color for the keyhint widget.
c.colors.keyhint.fg = base05

# Highlight color for keys to complete the current keychain.
c.colors.keyhint.suffix.fg = base05

# Background color of the keyhint widget.
c.colors.keyhint.bg = base00

# Foreground color of an error message.
c.colors.messages.error.fg = base00

# Background color of an error message.
c.colors.messages.error.bg = base08

# Border color of an error message.
c.colors.messages.error.border = base08

# Foreground color of a warning message.
c.colors.messages.warning.fg = base00

# Background color of a warning message.
c.colors.messages.warning.bg = base0E

# Border color of a warning message.
c.colors.messages.warning.border = base0E

# Foreground color of an info message.
c.colors.messages.info.fg = base05

# Background color of an info message.
c.colors.messages.info.bg = base00

# Border color of an info message.
c.colors.messages.info.border = base00

# Foreground color for prompts.
c.colors.prompts.fg = base05

# Border used around UI elements in prompts.
c.colors.prompts.border = base00

# Background color for prompts.
c.colors.prompts.bg = base00

# Background color for the selected item in filename prompts.
c.colors.prompts.selected.bg = base02

# Foreground color of the statusbar.
c.colors.statusbar.normal.fg = base0B

# Background color of the statusbar.
c.colors.statusbar.normal.bg = base00

# Foreground color of the statusbar in insert mode.
c.colors.statusbar.insert.fg = base00

# Background color of the statusbar in insert mode.
c.colors.statusbar.insert.bg = base0D

# Foreground color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.fg = base00

# Background color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.bg = base0C

# Foreground color of the statusbar in private browsing mode.
c.colors.statusbar.private.fg = base00

# Background color of the statusbar in private browsing mode.
c.colors.statusbar.private.bg = base01

# Foreground color of the statusbar in command mode.
c.colors.statusbar.command.fg = base05

# Background color of the statusbar in command mode.
c.colors.statusbar.command.bg = base00

# Foreground color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.fg = base05

# Background color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.bg = base00

# Foreground color of the statusbar in caret mode.
c.colors.statusbar.caret.fg = base00

# Background color of the statusbar in caret mode.
c.colors.statusbar.caret.bg = base0E

# Foreground color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.fg = base00

# Background color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.bg = base0D

# Background color of the progress bar.
c.colors.statusbar.progress.bg = base0D

# Default foreground color of the URL in the statusbar.
c.colors.statusbar.url.fg = base05

# Foreground color of the URL in the statusbar on error.
c.colors.statusbar.url.error.fg = base08

# Foreground color of the URL in the statusbar for hovered links.
c.colors.statusbar.url.hover.fg = base05

# Foreground color of the URL in the statusbar on successful load
# (http).
c.colors.statusbar.url.success.http.fg = base0C

# Foreground color of the URL in the statusbar on successful load
# (https).
c.colors.statusbar.url.success.https.fg = base0B

# Foreground color of the URL in the statusbar when there's a warning.
c.colors.statusbar.url.warn.fg = base0E

# Background color of the tab bar.
c.colors.tabs.bar.bg = base00

# Color gradient start for the tab indicator.
c.colors.tabs.indicator.start = base0D

# Color gradient end for the tab indicator.
c.colors.tabs.indicator.stop = base0C

# Color for the tab indicator on errors.
c.colors.tabs.indicator.error = base08

# Foreground color of unselected odd tabs.
c.colors.tabs.odd.fg = base05

# Background color of unselected odd tabs.
c.colors.tabs.odd.bg = base01

# Foreground color of unselected even tabs.
c.colors.tabs.even.fg = base05

# Background color of unselected even tabs.
c.colors.tabs.even.bg = base00

# Background color of pinned unselected even tabs.
c.colors.tabs.pinned.even.bg = base00

# Foreground color of pinned unselected even tabs.
c.colors.tabs.pinned.even.fg = base0B

# Background color of pinned unselected odd tabs.
c.colors.tabs.pinned.odd.bg = base01

# Foreground color of pinned unselected odd tabs.
c.colors.tabs.pinned.odd.fg = base0B

# Background color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.bg = base0B

# Foreground color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.fg = base02

# Background color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.bg = base0B

# Foreground color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.fg = base02

# Foreground color of selected odd tabs.
c.colors.tabs.selected.odd.fg = base02

# Background color of selected odd tabs.
c.colors.tabs.selected.odd.bg = base07

# Foreground color of selected even tabs.
c.colors.tabs.selected.even.fg = base02

# Background color of selected even tabs.
c.colors.tabs.selected.even.bg = base07
