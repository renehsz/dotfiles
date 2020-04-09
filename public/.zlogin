
if [[ -z $DISPLAY ]]; then
    if [[ $(tty) = /dev/tty1 ]]; then
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
        exec sway
    elif [[ $(tty) = /dev/tty2 ]]; then
        EDITOR=emacs \
        VISUAL=emacs \
        exec startx
    elif [[ $(tty) = /dev/tty3 ]]; then
        exec wio
    fi
fi

