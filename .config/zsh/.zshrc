local profile
for profile in ~/.config/sh/shrc.d/*.sh; do
    . "$profile"
done

for profile in $XDG_CONFIG_HOME/zsh/zshrc.d/*.zsh; do
    . "$profile"
done
