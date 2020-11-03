# Fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Starship
starship init fish | source

# Direnv
eval (direnv hook fish)

# asdf 
source (brew --prefix asdf)/asdf.fish

# krew
set -gx PATH $PATH $HOME/.krew/bin

# Iterm integration
source ~/.iterm2_shell_integration.fish

# Aliases for exa
alias ls='exa --group-directories-first --git --icons --color=auto'
alias ll='ls -lhiFgHS'
alias la='ls -alhiFgHS'
