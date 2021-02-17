fzf-down() {
    fzf --height 50% "$@" --border
}

_gb() {
    fzf-git-log init
    git branch -a --color=always | command grep -v '/HEAD\s' \
        | fzf-down --ansi --multi --preview-window right:70% \
            --bind 'ctrl-g:execute-silent(fzf-git-log toggle-graph)+refresh-preview' \
            --preview 'fzf-git-log run $(sed s/^..// <<< {} | cut -d" " -f1)' \
        | sed 's/^..//' | cut -d' ' -f1 \
        | sed 's#^remotes/##'
}

_gf() {
    git -c color.status=always status --short \
        | fzf-down -m --ansi --nth 2..,.. \
            --preview '(git diff --color=always -- {-1} | sed 1,4d; cat {-1}) | head -500' \
        | cut -c4- | sed 's/.* -> //'
}

gh() {
    fzf-git-log init
    fzf-git-log run "$@" \
        | fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
            --bind 'ctrl-g:execute-silent(fzf-git-log toggle-graph)+reload(fzf-git-log run)' \
            --preview 'grep -o "[a-f0-9]\{7,\}" <<< {} | xargs git show --color=always | head -500' \
        | command grep -o "[a-f0-9]\{7,\}"
}

_gh() {
    gh
}

_gg() {
    RG="rg --column --line-number --no-heading --color=always --smart-case "
    fzf --ansi --disabled \
        --bind "change:reload:$RG {q} || true" \
        --preview 'fzf-find-preview $(cut -d ':' -f1 <<< {})' \
        --preview-window hidden \
        | command cut -d ':' -f1
}

_gr() {
    fzf-git-log init
    git remote -v | awk '{print $1 "\t" $2}' | uniq \
        | fzf-down --tac --preview 'fzf-git-log run {1} | head -200' \
            --bind 'ctrl-g:execute-silent(fzf-git-log toggle-graph)+refresh-preview' \
        | command cut -d$'\t' -f1
}

_gs() {
    git stash list \
        | fzf-down --ansi --no-sort --reverse --multi --bind 'ctrl-s:toggle-sort' \
            --preview 'cut -d ":" -f1 <<< {} | xargs git stash show --color=always | head -500' \
        | command cut -d ':' -f1
}

_gt() {
    git tag --sort -version:refname \
        | fzf-down --multi --preview-window right:70% \
            --preview 'git show --color=always {} | head -500'
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
bind-helper b f g h r s t
unset -f bind-helper
