# Fisher
if not functions -q fisher
    set -q XDG_CONFIG_HOME; or set XDG_CONFIG_HOME ~/.config
    curl https://git.io/fisher --create-dirs -sLo $XDG_CONFIG_HOME/fish/functions/fisher.fish
    fish -c fisher
end

# Starship
starship init fish | source

# asdf 
source (brew --prefix asdf)/asdf.fish

##################
## asdf plugins ##
##################
# Direnv
eval (direnv hook fish)

# kubectl krew
set -gx PATH $PATH $HOME/.krew/bin

# Java - JAVA_HOME
source ~/.asdf/plugins/java/set-java-home.fish

# Iterm integration
source ~/.iterm2_shell_integration.fish

# Aliases for exa
alias ls='exa --group-directories-first --git --icons --color=auto'
alias ll='ls -lhiFgHS'
alias la='ls -alhiFgHS'

# Aliases for tmux
alias t="tmux"
alias ta="t a -t"
alias tls="t ls"
alias tn="t new -t"
