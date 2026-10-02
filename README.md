# Mac dotfiles

Personal Mac setup managed with yadm: Fish, Fisher, Tide, mise, eza, Ghostty and Zellij.

## Restore a Mac

Install Apple's command-line tools and [Homebrew](https://brew.sh), then open a terminal where `brew` is on PATH.

```sh
brew install yadm
yadm clone git@github.com:loncarales/dotfiles-mac.git
brew bundle install --file="$HOME/.Brewfile" --no-upgrade
```

Set up GitHub SSH access before cloning, or use the repository's HTTPS URL. On an existing Mac, back up conflicting files before cloning; do not force an overwrite.

The Brewfile covers requested CLI packages, GUI apps, fonts and taps. It is an install list, not a version lock. Homebrew resolves dependencies. Uncertain older packages remain until reviewed; see [CLEANUP.md](CLEANUP.md).

Restore Fisher plugins and saved prompt settings:

```sh
fisher_file="$(mktemp)"
curl -fsSL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish -o "$fisher_file" &&
  fish -c 'source $argv[1]; and fisher update; and source ~/.config/fish/tide-settings.fish' "$fisher_file"
rm "$fisher_file"
```

`fish_plugins` is the plugin list. Plugin code is downloaded by Fisher and is not tracked. The saved Tide settings are applied once, so later `tide configure` changes remain yours. To restore the saved appearance again, source `~/.config/fish/tide-settings.fish` in Fish and reopen the shell.

Install the versions already specified in mise:

```sh
mise install
```

Run this from your home directory. It restores the global tools in `~/.config/mise/config.toml`; project-specific versions belong in each project. Fish activates mise in interactive sessions. For scripts, use `mise exec -- <command>`.

Set Fish as the login shell. Run these commands from the default macOS shell:

```sh
fish_path="$(command -v fish)"
grep -qxF "$fish_path" /etc/shells || printf '%s\n' "$fish_path" | sudo tee -a /etc/shells
chsh -s "$fish_path"
```

Reopen Ghostty. Its config lives at `~/Library/Application Support/com.mitchellh.ghostty/config.ghostty`; Zellij uses `~/.config/zellij/config.kdl`.

## Local settings

Copy `~/.config/fish/local.fish.example` to `~/.config/fish/local.fish` only if the local file does not already exist. Add machine paths, build flags and account-specific settings there. It is ignored by yadm. Credentials, shell history, plugin downloads and `fish_variables` are not tracked.

Independent Fish processes get separate temporary kubeconfigs under `/tmp/kubes`. Child shells inherit the parent's `KCONFDIR`. Existing kubeconfig contents are preserved. Nothing imports or merges your main kubeconfig automatically.

The optional `~/.local/bin/system-info.fish` banner retains this Intel Mac's disk and temperature probes. Enable it from `local.fish` after checking disk IDs and available sensors on another Mac.

Homebrew installs mise itself; mise manages its configured runtimes and Kubernetes tools. Homebrew runtimes required by other formulae should remain installed.

## Maintain

```sh
brew bundle check --file="$HOME/.Brewfile" --no-upgrade
python3 ~/.config/yadm/check-dotfiles.py
yadm diff
yadm add <specific-files>
yadm commit
```

Add new Homebrew tools/apps to `~/.Brewfile` when installing them. Use explicit paths with yadm; do not add the entire home directory. Add personal Fish functions to the `.gitignore` allowlist before tracking them.

Keep snapshots separate from the maintained Brewfile:

```sh
brew bundle dump --file="$HOME/Brewfile.snapshot"
```

Review the snapshot before tracking or sharing it. Do not overwrite the maintained Brewfile with a dump. Package removal is a separate review; this setup does not run `brew bundle cleanup --force`.
