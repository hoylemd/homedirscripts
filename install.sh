mv ~/.vimrc vimrc.old
mv ~/.bashrc bashrc.old
mv ~/.gitconfig gitconfig.old
rm ~/.vimrc
rm ~/.bashrc
rm ~/.gitconfig
ln .vimrc ~/.vimrc
ln .bashrc ~/.bashrc
ln .gitconfig ~/.gitconfig
