. ~/.config/sh/shrc

local profile
for profile in $XDG_CONFIG_HOME/zsh/zshrc.d/*.zsh; do
    . "$profile"
done
