# Necessary Homebrew installations
echo "Neovim: Installing necessary packages with Homebrew"
brew install --HEAD luajit
brew install --HEAD neovim
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install ctags-exuberant
brew install fzf
# To install useful key bindings and fuzzy completion:
$(brew --prefix)/opt/fzf/install
brew install ripgrep
brew install --HEAD universal-ctags/universal-ctags/universal-ctags
brew install the_silver_searcher
brew install fd
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

# Create symbolic links of files
echo "Neovim: Linking file init.vim"
if [ ! -d ~/.config/nvim ]; then
  mkdir -p ~/.config/nvim;
fi
ln -sf "$PWD/init.vim" ~/.config/nvim/init.vim
echo "Neovim: Installing plugins"
nvim --headless +PlugInstall +qall

