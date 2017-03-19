let map = (shortcuts, command, custom=false) => {
    vimfx.set(`${custom ? 'custom.' : ''}mode.normal.${command}`, shortcuts)
}

function unmap(command) {
    map("", command)
}

[
    "reload_all",
    "reload_all_force",
    "stop_all",
    "stop",
    "find_highlight_all",
].map(unmap);

map('<force><escape> <force><C-[>', 'esc')

map('<C-f>', 'scroll_page_down')
map('<C-b>', 'scroll_page_up')
map('<C-d>', 'scroll_half_page_down')
map('<C-u>', 'scroll_half_page_up')

map('<C-p> a', 'tab_select_previous')
map('<C-n> s', 'tab_select_next')
map('d', 'tab_close')
map('u', 'tab_restore')

map('H z', 'history_back')
map('L x', 'history_forward')
