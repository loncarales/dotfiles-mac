# Use Homebrew on Intel or Apple Silicon without persisting PATH in fish_variables.
for prefix in /opt/homebrew /usr/local
    if test -x "$prefix/bin/brew"
        set -gx HOMEBREW_PREFIX $prefix
        fish_add_path --global --path "$prefix/bin" "$prefix/sbin"
        break
    end
end
fish_add_path --global --path "$HOME/.local/bin"
fish_add_path --global --path --append "$HOME/.krew/bin"
set -gx EDITOR nvim

# Independent shells get separate kubeconfigs; child shells inherit the same one.
if not set -q KCONFDIR; or test -z "$KCONFDIR"
    mkdir -p /tmp/kubes; or return 1
    set -l kube_dir (mktemp -d /tmp/kubes/XXXXXXXXXX); or return 1
    set -gx KCONFDIR "$kube_dir"
end
if not test -f "$KCONFDIR/me"
    printf '%s\n' $fish_pid >"$KCONFDIR/me"; or return 1
end
touch "$KCONFDIR/kubeconfig"; or return 1
set -gx KUBECONFIG "$KCONFDIR/kubeconfig"

# Local paths and settings are deliberately outside version control.
if test -f "$__fish_config_dir/local.fish"
    source "$__fish_config_dir/local.fish"
end
