# Software review

The October 2026 inventory contained 399 Homebrew formulae and 96 cask records. Of those formulae, 182 were marked explicitly requested. The Brewfile preserves requested packages and Homebrew's normalized cask names, adds the directly used libpq and desired Zellij install, and leaves dependency resolution to Homebrew.

No packages were removed or upgraded. A full installed-state snapshot and the original configs are saved locally under `~/.local/share/dotfiles-backups/`; these backups are not tracked.

## Review before removing

| Candidates | What to establish first |
| --- | --- |
| ack | Replaced by ripgrep (`rg`) in daily use; check scripts for `ack` before uninstalling. |
| Starship and Homebrew Zsh | Fish/Tide replaced the old prompt; check other shells before uninstalling. |
| nodenv / node-build | Confirm all Node projects work through mise. |
| Python 3.9, 3.10, 3.11, 3.12; PHP 8.1; Java 11 | Check project requirements and installed dependents; age alone is not a removal criterion. |
| Bass plugin | The maintained Fish config no longer needs it; check personal usage before removing from Fisher. |
| z plugin / zoxide | Choose the navigation tool you use; current Fisher setup uses z. |
| htop / bottom / btop; dust / dua / diskus | Keep the tools you actually use. |
| OrbStack / Colima / Docker tooling / other VM tools | Check containers, volumes and VMs before removing any runtime or its data. |
| Alfred / Raycast; window managers; extra browsers and terminals | Review desktop app preferences manually. |
| Legacy taps and renamed cask records | Confirm package provenance and canonical names; do not assume each old record represents a separate app. |

Use `brew uses --installed <formula>` before considering a formula's removal. Then review project and manual usage as Homebrew cannot detect those.

## Zellij

The current `/usr/local/bin/zellij` is a manually installed 0.42.2 binary. It remains untouched. The Brewfile includes Zellij for a fresh Mac, so the current machine's Brewfile check will report it missing from Homebrew.

When deliberately migrating this Mac to Homebrew Zellij, back up and move the manual binary out of Homebrew's link path first, then install and validate the chosen version. Do not force Homebrew to overwrite it during routine restoration.

## Restore boundaries

This repository captures the current terminal setup and Homebrew-managed software. Applications installed outside Homebrew, app preferences beyond the configs tracked here, credentials, private work configuration and application data still need their own backups. The local paths and AWS MFA settings are intentionally excluded from Git.
