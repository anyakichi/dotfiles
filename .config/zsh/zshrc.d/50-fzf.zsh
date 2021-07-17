__fzf-ghq()
{
    setopt localoptions pipefail

    command ghq list | fzf -q "$1" --no-multi -0 -1
}

__fzf-pass()
{
    setopt localoptions pipefail

    (cd "${PASSWORD_STORE_DIR:-~/.password-store}" &&
        command find . -name '*.gpg' 2>/dev/null \
            | command sed -e 's#^\./##' -e 's/.gpg$//' \
            | fzf --no-multi -0 --expect=ctrl-o)
}

fcd()
{
    local dir

    res=("${(@f)"$(fzf-utils::_file "$1" d)"}")

    if [[ ${#res} -ge 3 ]]; then
        cd "${res[3]}" || return
    fi
}

fghq()
{
    local dir
    dir="$(__fzf-ghq "$1")" && cd "$(command ghq root)/${dir}" || return
}

fpass()
{
    pass "$(__fzf-pass)"
}
