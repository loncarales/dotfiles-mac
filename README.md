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

### Install figlet, osx-cpu-temp, smartmontools, lolcat

`brew install figlet osx-cpu-temp smartmontools lolcat`

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

## Terminal output

```bash
   __  __                           _       _
  |  \/  | __ _  ___      _ __ ___ (_)_ __ (_)
  | |\/| |/ _` |/ __|____| '_ ` _ \| | '_ \| |
  | |  | | (_| | (_|_____| | | | | | | | | | |
  |_|  |_|\__,_|\___|    |_| |_| |_|_|_| |_|_|

System Information
* OS Version.: macOS 14.3.1 23D60 Darwin 23.3.0
* Processor..: Intel(R) Core(TM) i7-8700B CPU @ 3.20GHz 6 Cores
* Memory.....: 32 GB 2667 MHz DDR4
* Disk Temp..:  53.0°C
* CPU Temp...:  61.2°C
* GPU Temp...:  0.0°C

HDD Usage: 416 GB out of 500 G
[|||||||||||||||||||||||||||||||||||||||||---------]

:~ took 6s
on Mac OS λ
```
