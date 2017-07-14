setterm -blength 0 #set length of terminal bell to 0 - turn it off
#append bin folder
PATH=$HOME/bin:$PATH
PATH=$HOME/.local/bin:$PATH
#append texlive path
TEXLIVEDIR=/usr/local/texlive/2014/bin/x86_64-linux
if [[ -d $TEXLIVEDIR ]] ; then
    PATH=$PATH:$TEXLIVEDIR
fi
#run xorg
startx
