local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.window_decorations = "NONE"
config.enable_tab_bar = false
config.underline_thickness = 2

config.font = wezterm.font_with_fallback({
  "DejaVuSansM Nerd Font",
  "IPAGothic",
  "Font Awesome 7 Free",
  "Font Awesome 7 Brands",
  "Noto Color Emoji",
})
config.font_size = 10.0
config.freetype_load_flags = "NO_HINTING|NO_AUTOHINT"

config.line_height = 1.15

config.window_padding = {
  left = 2,
  right = 2,
  top = 2,
  bottom = 2,
}

config.default_cursor_style = "BlinkingBlock"
config.cursor_blink_rate = 800

config.colors = {
  foreground = "#c0c5ce",
  background = "#1b2b34",

  cursor_bg = "#c0c5ce",
  cursor_fg = "#1b2b34",

  ansi = {
    "#1b2b34",
    "#ec5f67",
    "#99c794",
    "#fac863",
    "#6699cc",
    "#c594c5",
    "#5fb3b3",
    "#c0c5ce",
  },
  brights = {
    "#65737e",
    "#ec5f67",
    "#99c794",
    "#fac863",
    "#6699cc",
    "#c594c5",
    "#5fb3b3",
    "#ffffff",
  },

  indexed = {
    [68] = "#6699cc",
    [73] = "#5fb3b3",
    [114] = "#99c794",
    [137] = "#ab7967",
    [145] = "#a7adba",
    [176] = "#c594c5",
    [203] = "#ec5f67",
    [209] = "#f99157",
    [221] = "#fac863",
    [235] = "#1b2b34",
    [237] = "#343d46",
    [240] = "#4f5b66",
    [243] = "#65737e",
    [251] = "#c0c5ce",
    [252] = "#cdd3de",
    [253] = "#d8dee9",
  },
}

config.keys = {
  { key = "+", mods = "CTRL", action = wezterm.action.IncreaseFontSize },
  { key = "=", mods = "CTRL", action = wezterm.action.ResetFontSize },
  { key = ";", mods = "CTRL", action = wezterm.action.Nop },
  { key = "'", mods = "CTRL", action = wezterm.action.PasteFrom("Clipboard") },
}

return config
