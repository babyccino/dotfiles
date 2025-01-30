find ./group/* | while read -r file; do
  echo "installing $file"
  brew install $(cat $file)
done

# aerospace
brew install --cask nikitabobko/tap/aerospace

# jankyborders
brew tap FelixKratz/formulae
brew install borders

# docker
brew install --cask docker

# ghostty
brew install --cask ghostty
