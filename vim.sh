plug_file="$HOME/.vim/autoload/plug.vim"
if [ ! -f $plug_file ];then
  curl -Lo $plug_file --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi