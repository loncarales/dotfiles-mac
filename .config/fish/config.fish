if status is-interactive
    if command -q mise
        mise activate fish | source
    end

    if command -q kubectl
        command kubectl completion fish | source
    end
    if command -q kubecolor
        function kubectl --wraps kubectl
            command kubecolor $argv
        end
        function k --wraps kubectl
            command kubecolor $argv
        end
    end

    if command -q atuin
        atuin init fish | source
    end
    if command -q fzf
        fzf --fish | source
    end
    if test -f "$HOME/.orbstack/shell/init2.fish"
        source "$HOME/.orbstack/shell/init2.fish"
    end
end
