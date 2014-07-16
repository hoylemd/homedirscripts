# script installer/updater
# params: source, destination
install () {

    #remove the old version if ti exists
    if [ -e $2 ]; then
        rm $2
    fi

    ln -f $1 $2

    return 0
}

for script in .vimrc .bashrc .tmux.conf .gitconfig .git-completion.bash .git-prompt.sh
do
	install $script ~/$script
done
