# Fresh Mac OS

## Install brew

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`

## Install yadm

`brew install yadm`

## Install Fish

`brew install fish`
 
## Install the starship binary

`brew install starship`

## Install fisher plugins

```bash
danhper/fish-ssh-agent
edc/bass
evanlucas/fish-kubectl-completions
jethrokuan/z
```

### Install asdf

```bash
brew install coreutils curl git
brew install asdf
```

### Install fortune, cowsay, lolcat 

`brew install fortune cowsay, lolcat`

### Install fonts

```bash
brew tap homebrew/cask-fonts
brew cask install font-hack-nerd-font
brew cask install font-fira-code-nerd-font
```

### Install Iterm2

`brew cask install iterm2`

### Install tmux

`brew cask install tmux`

#### Install Tmux Plugin Manager

`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

### Clone your existing repo using yadm

`yadm clone git@github.com:loncarales/dotfiles-mac.git`
