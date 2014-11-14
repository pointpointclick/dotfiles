#!/bin/sh

SH_FILES=".gitconfig .zshrc"
BACKUP="backups/`date +'%Y%m%d-%H%M%S'`"
SHDIR=$PWD

# OH MY ZSH
if [ ! -d ~/.oh-my-zsh ]; then
    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
fi

# CREATE DOT FILES FROM LIST ABOVE
for FILE in $SH_FILES; do
    if [ -e "$HOME/$FILE" -o -L "$HOME/$FILE" ]; then
        if [ -L "$HOME/$FILE" ]; then
            echo "not backing up ~/$FILE, it is a symlink -> `readlink $HOME/$FILE`"
            rm "$HOME/$FILE"
        else
            echo "backing up ~/$FILE"
            mkdir -p $BACKUP
            mv "$HOME/$FILE" "$BACKUP/$FILE"
        fi
    fi
    echo "installing $FILE"
    ln -s "$SHDIR/$FILE" "$HOME/$FILE"
done
