# Fresh Mac OS

## Install brew

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"`

## Install yadm

`brew install yadm`

## Install ZSH

`brew install zsh`
 
## Install the starship binary

`brew install starship`

## Install Oh-my zsh

`sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"`

## Install zsh plugins

```bash
[zsh-completions](https://github.com/zsh-users/zsh-completions)
[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-autosuggestions)
```

### Install asdf

```bash
brew install coreutils curl git
brew install asdf
```

### Install fortune, cowsay, lolcat

`brew install fortune cowsay lolcat`

### Install exa

`brew install exa`

### Install fonts

```bash
brew tap homebrew/cask-fonts
brew install font-hack-nerd-font
brew install font-fira-code-nerd-font
```

### Install Iterm2

`brew install iterm2`

### Install tmux

`brew install tmux`

#### Install Tmux Plugin Manager

`git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm`

### Clone your existing repo using yadm

`yadm clone git@github.com:loncarales/dotfiles-mac.git`
