_gb() {
    fzf-git branch "$@"
}

_gf() {
    fzf-git file "$@"
}

gh() {
    fzf-git hash "$@"
}

alias _gh=gh

_gg() {
    local rg view
    view="bat --plain --color=always --pager='less -KMRc' \
            \$(cut -d ':' -f1 <<< {})"
    rg="rg --column --line-number --no-heading --color=always --smart-case "

    fzf --ansi --disabled \
        --bind "change:reload:$rg {q} || true" \
        --bind "ctrl-t:execute:tview $view" \
        --preview "$view | head -500" \
        --preview-window hidden |
        command cut -d ':' -f1
}

_gp() {
    fzf-ps run
}

_gr() {
    fzf-git remote "$@"
}

_gs() {
    fzf-git stash "$@"
}

_gt() {
    fzf-git tag "$@"
}

join-lines() {
    local item
    while read -r item; do
        printf '%q ' "$item"
    done
}

fzf-s-widget() {
    local result=$(fzf-tmux-pane run --border)
    zle reset-prompt
    tmux switch-client -t "${result}"
}
zle -N fzf-s-widget

bind-helper() {
    local c
    for c in "$@"; do
        eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
        eval "zle -N fzf-g$c-widget"
        eval "bindkey '^g^$c' fzf-g$c-widget"
    done
}
bind-helper b f g h p r s t
unset -f bind-helper

bindkey '^s' fzf-s-widget
