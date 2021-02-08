
# Necessary Homebrew installations
echo "Neovim: Installing necessary packages with Homebrew"
brew install --HEAD luajit
brew install --HEAD neovim
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font
brew install ctags-exuberant

# Create symbolic links of files
echo "Neovim: Linking file init.vim"
ln -sf "$PWD/init.vim" ~/.config/nvim/init.vim
echo "Neovim: Installing plugins"
nvim --headless +PlugInstall +qall

