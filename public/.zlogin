
if systemctl -q is-active graphical.target && [[ -z $DISPLAY ]]; then
    case $XDG_VTNR in
        1)
            EDITOR=nvim \
            VISUAL=$EDITOR \
            exec startx ~/.xinitrc awesome
            ;;
        2)
            exec wio
            ;;
        3)
            EDITOR=emacsclient -a emacs \
            VISUAL=$EDITOR \
            exec startx ~/.xinitrc emacs
            ;;
        2)
            SDL_VIDEODRIVER=wayland \
            QT_QPA_PLATFORMTHEME=qt5ct \
            QT_QPA_PLATFORM=wayland-egl \
            QT_WAYLAND_FORCE_DPI=physical \
            QT_WAYLAND_DISABLE_WINDOWDECORATION=1 \
            QT_AUTO_SCREEN_SCALE_FACTOR=1 \
            CLUTTER_BACKEND=wayland \
            ECORE_EVAS_ENGINE=wayland_egl \
            ELM_ENGINE=wayland_egl \
            MOZ_ENABLE_WAYLAND=1 \
            EDITOR=nvim \
            VISUAL=$EDITOR \
            exec sway
            ;;
    esac
fi

