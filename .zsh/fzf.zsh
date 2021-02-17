fzf-down() {
    fzf --height 50% "$@" --border
}

_gb() {
    local view
    view="fzf-git-log run \$(sed s/^..// <<< {} | cut -d' ' -f1)"

    fzf-git-log init
    git branch -a --color=always | command grep -v '/HEAD\s' \
        | fzf-down --ansi --multi --preview-window right:70% \
            --bind 'ctrl-g:execute-silent(fzf-git-log toggle-graph)+refresh-preview' \
            --bind "ctrl-t:execute:fzf-view $view" \
            --preview "$view | head -500" \
        | sed 's/^..//' | cut -d' ' -f1 \
        | sed 's#^remotes/##'
}

_gf() {
    local view
    view="git -c core.pager='less -+F -KMc' diff --color=always -- {-1} | sed 1,4d"

    git -c color.status=always status --short --no-branch \
        | fzf-down -m --ansi --nth 2..,.. \
            --bind "ctrl-t:execute:fzf-view $view" \
            --preview "$view | head -500" \
        | cut -c4- | sed 's/.* -> //'
}

gh() {
    local view
    view="git -c core.pager='less -+F -KMc' show --color=always \$(grep -o '[a-f0-9]\{7,\}' <<< {})"

    fzf-git-log init
    fzf-git-log run "$@" \
        | fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
            --bind 'ctrl-g:execute-silent(fzf-git-log toggle-graph)+reload(fzf-git-log run)' \
            --bind "ctrl-t:execute:fzf-view $view" \
            --preview "$view | head -500" \
        | command grep -o "[a-f0-9]\{7,\}"
}

alias _gh=gh

_gg() {
    local rg view
    view="fzf-view-file \$(cut -d ':' -f1 <<< {})"
    rg="rg --column --line-number --no-heading --color=always --smart-case "

    fzf --ansi --disabled \
        --bind "change:reload:$rg {q} || true" \
        --bind "ctrl-t:execute:fzf-view $view" \
        --preview "$view | head -500" \
        --preview-window hidden \
        | command cut -d ':' -f1
}

_gr() {
    local view
    view="fzf-git-log run {1}"

    fzf-git-log init
    git remote -v | awk '{print $1 "\t" $2}' | uniq \
        | fzf-down --tac \
            --bind 'ctrl-g:execute-silent(fzf-git-log toggle-graph)+refresh-preview' \
            --bind "ctrl-t:execute:fzf-view $view" \
            --preview "$view | head -500" \
        | command cut -d$'\t' -f1
}

_gs() {
    local view
    view="git -c core.pager='less -+F -KMc' stash show -p --stat --color=always \$(cut -d: -f1 <<< {})"

    git stash list \
        | fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
            --bind "ctrl-t:execute:fzf-view $view" \
            --preview "$view | head -500" \
        | command cut -d ':' -f1
}

_gt() {
    local view
    view="git -c core.pager='less -+F -KMc' show --color=always {}"

    git tag --sort -version:refname \
        | fzf-down --multi --preview-window right:70% \
            --bind "ctrl-t:execute:fzf-view $view" \
            --preview "$view | head -500"
}

join-lines() {
    local item
    while read -r item; do
        printf '%q ' "$item"
    done
}

bind-helper() {
    local c
    for c in "$@"; do
        eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
        eval "zle -N fzf-g$c-widget"
        eval "bindkey '^g^$c' fzf-g$c-widget"
    done
}
bind-helper b f g h r s t
unset -f bind-helper
