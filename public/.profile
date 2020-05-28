
if [[ -z $EDITOR ]]; then
    # Preferred editor for local and remote sessions
    if [ -n $SSH_CONNECTION ]; then
        export EDITOR='vi'
    else
        export EDITOR="emacsclient"
    fi
fi
if [[ -z $VISUAL ]]; then
    export VISUAL="$EDITOR"
fi

# General flags
export MAKEFLAGS="-j$(nproc)"
export LESSHISTFILE="$HOME/.config/less_history"

# Set some paths
export GOPATH="$HOME/go"
export PATH="$HOME/.local/bin:$GOPATH/bin:$HOME/.emacs.d/bin:$PATH"

# Perl crap
export PATH="$HOME/.local/perl5/bin${PATH:+:${PATH}}"
export PERL5LIB="$HOME/.local/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"
export PERL_LOCAL_LIB_ROOT="$HOME/.local/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"
export PERL_MB_OPT="--install_base \"$HOME/.local/perl5\""
export PERL_MM_OPT="INSTALL_BASE=$HOME/.local/perl5"

# Make Java GUIs not look absolutely terrible
export _JAVA_AWT_WM_NONREPARENTING=1
export _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=on -Dswing.aatext=true -Dswing.defaultlaf=com.sun.java.swing.plaf.gtk.GTKLookAndFeel -Djdk.gtk.version=3 -Dsun.java2d.opengl=true"

# Make astah run
alias astah="astah-uml"
alias astah-uml='PATH="/usr/lib/jvm/java-8-openjdk/jre/bin/:$PATH" astah-uml'
# Make BlueJ run
alias bluej="_JAVA_OPTIONS= bluej"
# Make x48 run
alias x48="x48 -connFont fixed -largeFont fixed -smallFont fixed -mediumFont fixed"
# Run maxima without annoying startup message
alias maxima="maxima -q"

# Set up Emscripten path
export EMSDK="/home/renehsz/.local/emsdk"
export EM_CACHE="/home/renehsz/.local/emsdk/upstream/emscripten/cache"

# Set up texlive manager
alias tlmgr="/usr/share/texmf-dist/scripts/texlive/tlmgr.pl --usermode"

# This should probably detect the current network somehow
# We should probably detect the network
export DISTCC_HOSTS="192.168.0.30/80 localhost/4"
# Transient compilation stuff should go into the tmpfs instead of my precious home directory.
export DISTCC_DIR=/tmp/distcc
[ ! -d $DISTCC_DIR ] && mkdir $DISTCC_DIR

