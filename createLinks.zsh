#! /usr/bin/env zsh

################################################################################
# Links files in this diretory to their proper places in $HOME
################################################################################

################################################################################
# Script setup
################################################################################

SRC_DIR="${HOME}/Dropbox/DevelopmentTools/Cygwin"
DEST_DIR="${HOME}"

removeAndLink() {
    local src=${SRC_DIR}/$1
    local dest=${DEST_DIR}/$1

    echo "rm -rf "$dest" >& /dev/null"
    rm -rf "$dest" >& /dev/null

    echo "ln -s "$src" "$dest""
    ln -s "$src" "$dest"
}

################################################################################
# Create the list of items to link
################################################################################

items=()

# Shell files
echo "Shell files"
#items+=.zshrc
#items+=.zshenv
items+=.tcshrc
items+=.prompt.tcsh
items+=.bash_profile
items+=.bashrc
items+=.dircolors
items+=.inputrc
items+=.minttyrc
items+=.profile
#items+=.ackrc
#items+=.hushlogin
items+=.startxwinrc

# Vim files
#echo "Vim files"
items+=.vimrc
items+=.vsvimrc
#items+=.vimrc.before
#items+=.vimrc.after
#items+=.gvimrc.before
#items+=.gvimrc.after

# Vim Janus directory
#echo "Vim .janus directory"
#items+=.janus

# Oh My ZSH custom directory
#echo "Oh My ZSH custom directory"
#if [[ -d ${DEST_DIR}/.oh-my-zsh ]]; then
#    items+=.oh-my-zsh/custom
#else
#    echo "    Not linking to .oh-my-zsh/custom"
#fi

# Git files
echo "Git files"
items+=.gitconfig

# bin directory
echo "bin directory"
items+=bin

# virtualenvwrapper files
#echo "virtualenvwrapper files"
#if [[ -d ${DEST_DIR}/dev/virtualenvs ]]; then
#    items+=dev/virtualenvs/postactivate
#else
#    echo "    Not linking to /dev/virtualenvs"
#fi

################################################################################
# Do the linking
################################################################################

for item in $items
do
    removeAndLink $item
done

