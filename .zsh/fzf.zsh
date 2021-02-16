is_in_git_repo() {
    git rev-parse HEAD >/dev/null 2>&1
}

fzf-down() {
    fzf --height 50% "$@" --border
}

_gb() {
    is_in_git_repo || return
    fzf-git-log init
    git branch -a --color=always | command grep -v '/HEAD\s' \
        | fzf-down --ansi --multi --preview-window right:70% \
            --bind 'ctrl-g:execute-silent(fzf-git-log toggle-graph)+refresh-preview' \
            --preview 'fzf-git-log run $(sed s/^..// <<< {} | cut -d" " -f1)' \
        | sed 's/^..//' | cut -d' ' -f1 \
        | sed 's#^remotes/##'
}

_gf() {
    is_in_git_repo || return
    git -c color.status=always status --short \
        | fzf-down -m --ansi --nth 2..,.. \
            --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' \
        | cut -c4- | sed 's/.* -> //'
}

_gh() {
    is_in_git_repo || return
    fzf-git-log init
    fzf-git-log run \
        | fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
            --bind 'ctrl-g:execute-silent(fzf-git-log toggle-graph)+reload(fzf-git-log run)' \
            --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -'$LINES \
        | command grep -o "[a-f0-9]\{7,\}"
}

_gg() {
    RG="rg --column --line-number --no-heading --color=always --smart-case "
    fzf --bind "change:reload:$RG {q} || true" --ansi --disabled \
        | command cut -d ':' -f1
}

_gr() {
    is_in_git_repo || return
    fzf-git-log init
    git remote -v | awk '{print $1 "\t" $2}' | uniq \
        | fzf-down --tac --preview 'fzf-git-log run {1} | head -200' \
            --bind 'ctrl-g:execute-silent(fzf-git-log toggle-graph)+refresh-preview' \
        | command cut -d$'\t' -f1
}

_gt() {
    is_in_git_repo || return
    git tag --sort -version:refname \
        | fzf-down --multi --preview-window right:70% \
            --preview 'git show --color=always {} | head -'$LINES
}

join-lines() {
    local item
    while read item; do
        echo -n "${(q)item} "
    done
}

bind-helper() {
    local c
    for c in $@; do
        eval "fzf-g$c-widget() { local result=\$(_g$c | join-lines); zle reset-prompt; LBUFFER+=\$result }"
        eval "zle -N fzf-g$c-widget"
        eval "bindkey '^g^$c' fzf-g$c-widget"
    done
}
bind-helper b f g h r t
unset -f bind-helper
