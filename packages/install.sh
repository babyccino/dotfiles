cat ./group/base | xargs brew install
cat ./group/cask | xargs brew install --cask

brew tap FelixKratz/formulae
brew install sketchybar

go install mvdan.cc/gofumpt@latest
