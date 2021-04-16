killall gnome-keyring-daemon && gpg --decrypt pass_no_newline.gpg | gnome-keyring-daemon --unlock -r -d --components=secrets && pgrep goa-daemon | xargs kill -9
