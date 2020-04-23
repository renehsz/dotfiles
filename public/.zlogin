
if systemctl -q is-active graphical.target && [[ -z $DISPLAY ]]; then
    case $XDG_VTNR in
        1)
            SDL_VIDEODRIVER=wayland \
            QT_QPA_PLATFORMTHEME=qt5ct \
            QT_QPA_PLATFORM=wayland-egl \
            QT_WAYLAND_FORCE_DPI=physical \
            QT_WAYLAND_DISABLE_WINDOWDECORATION=1 \
            QT_AUTO_SCREEN_SCALE_FACTOR=1 \
            CLUTTER_BACKEND=wayland \
            ECORE_EVAS_ENGINE=wayland_egl \
            ELM_ENGINE=wayland_egl \
            _JAVA_AWT_WM_NONREPARENTING=1 \
            _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Djdk.gtk.version=3 -Dsun.java2d.opengl=true" \
            MOZ_ENABLE_WAYLAND=1 \
            EDITOR=nvim \
            VISUAL=$EDITOR \
            exec sway
            ;;
        2)
            exec wio
            ;;
        3)
            EDITOR=emacsclient -a emacs \
            VISUAL=$EDITOR \
            exec startx ~/.xinitrc emacs
            ;;
        4)
            EDITOR=nvim \
            VISUAL=$EDITOR \
            exec startx ~/.xinitrc i3
            ;;
    esac
fi

