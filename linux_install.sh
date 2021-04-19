
# Necessary installations
echo "Neovim: Installing appimage"
curl -L https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage > ~/nvim.appimage
mkdir ~/.vim/colors
brew install --HEAD luajit
# brew install --HEAD neovim # currently broken
brew install ctags-exuberant
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Create symbolic links of files
echo "Neovim: Linking file init.vim"
if [ ! -d ~/.config/nvim ]; then
  mkdir -p ~/.config/nvim;
fi
ln -sf "$PWD/init.vim" ~/.config/nvim/init.vim
echo "Neovim: Installing plugins"
~/nvim.appimage --headless +PlugInstall +qall
cp ~/.vim/plugged/gruvbox/colors/gruvbox.vim ~/.vim/colors/
~/nvim.appimage --headless +PlugInstall +qall
echo "Note: You must manually create an alias for running application ~/nvim.appimage"
echo "E.g. add following line to ~/.bashrc: 'alias vim=~/nvim.appimage'"
