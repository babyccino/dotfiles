find ./group/* | while read -r file; do
  echo "installing $file"
  brew install $(cat $file)
done

brew install --cask nikitabobko/tap/aerospace

# jankyborders
brew tap FelixKratz/formulae
brew install borders

brew install --cask zed@preview

brew install --cask docker

brew install --cask ghostty

brew tap FelixKratz/formulae
brew install sketchybar

# font
brew install --cask font-hack-nerd-font
