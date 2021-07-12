for profile in ~/.profile.d/*.sh; do
    test -r "$profile" && . "$profile"
done
unset profile
