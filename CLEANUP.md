# Software review

The October 2026 inventory contained 399 Homebrew formulae and 96 cask records. Of those formulae, 182 were marked explicitly requested. The Brewfile preserves requested packages and Homebrew's normalized cask names, adds the directly used libpq and desired Zellij install, and leaves dependency resolution to Homebrew.

The initial capture removed or upgraded no packages. Subsequent approved removals are recorded below. A full installed-state snapshot and the original configs are saved locally under `~/.local/share/dotfiles-backups/`; these backups are not tracked.

## Package decisions

Review one package at a time: **keep**, **delete**, or **unsure**. Delete decisions queue removal; nothing is uninstalled until the batch removal list is approved. Keep app data and configuration. Update the Brewfile only after a removal succeeds.

### Batch 1

Completed: all five packages were uninstalled from the user’s terminal and their absence was verified with Homebrew. Their Brewfile entries have been removed. macOS `/bin/zsh` remains available; configuration and app data were not targeted.

| Package | Decision | Reason / findings | Removal status |
| --- | --- | --- | --- |
| ack | Delete | User uses ripgrep (`rg`). No installed Homebrew dependents or references in the checked Fish startup files and personal `.local/bin` scripts; project usage has not been audited. | Removed; Brewfile updated |
| starship | Delete | Fish uses Tide. No installed Homebrew dependents or Starship references in checked shell startup files and Fish functions. | Removed; Brewfile updated |
| nodenv | Delete | mise manages Node 24.21.0. Default nodenv versions directory is absent; no installed Homebrew dependents or nodenv references in checked shell startup files and Fish functions. Project usage has not been audited. | Removed; Brewfile updated |
| node-build | Delete | Only installed Homebrew dependent is nodenv, already queued for removal. No references in checked shell configs or mise settings; Homebrew mise does not depend on it. | Removed; Brewfile updated |
| zsh (Homebrew) | Delete | Account login shell is Fish. No installed Homebrew dependents or explicit Homebrew Zsh references in checked shell/terminal configs and personal scripts. macOS /bin/zsh remains available. Homebrew Zsh is listed in /etc/shells; projects were not audited. | Removed; Brewfile updated |

### Batch 2

Completed: all five packages were uninstalled from the user’s terminal and their absence was verified with Homebrew. Their Brewfile entries have been removed. dua-cli, btop and mise remain installed. Colima was stopped and Docker used the OrbStack context before removal. No global mise tools were added; project-specific versions remain a project decision.

| Package | Decision | Reason / findings | Removal status |
| --- | --- | --- | --- |
| azure-cli | Delete | Use project-specific mise configuration when needed; do not add a global replacement. | Removed; Brewfile updated |
| argocd | Delete | Homebrew name for Argo CD CLI. Use project-specific mise configuration when needed. | Removed; Brewfile updated |
| colima | Delete | Replaced by OrbStack. No Homebrew service is started. Preserve ~/.colima and its SSH config include. | Removed; Brewfile updated |
| diskus | Delete | Prefer already-installed dua-cli. | Removed; Brewfile updated |
| htop | Delete | Prefer already-installed btop. | Removed; Brewfile updated |

## Review before removing

| Candidates | What to establish first |
| --- | --- |
| Python 3.9, 3.10, 3.11, 3.12; PHP 8.1; Java 11 | Check project requirements and installed dependents; age alone is not a removal criterion. |
| Bass plugin | The maintained Fish config no longer needs it; check personal usage before removing from Fisher. |
| z plugin / zoxide | Choose the navigation tool you use; current Fisher setup uses z. |
| bottom / btop; dust / dua | btop and dua are preferred; htop and diskus were removed. Review the remaining alternatives. |
| OrbStack / Docker tooling / other VM tools | OrbStack is preferred and Colima was removed. Check containers, volumes and VMs before removing any remaining runtime or its data. |
| Alfred / Raycast; window managers; extra browsers and terminals | Review desktop app preferences manually. |
| Legacy taps and renamed cask records | Confirm package provenance and canonical names; do not assume each old record represents a separate app. |

Use `brew uses --installed <formula>` before considering a formula's removal. Then review project and manual usage as Homebrew cannot detect those.

## Zellij

The current `/usr/local/bin/zellij` is a manually installed 0.42.2 binary. It remains untouched. The Brewfile includes Zellij for a fresh Mac, so the current machine's Brewfile check will report it missing from Homebrew.

When deliberately migrating this Mac to Homebrew Zellij, back up and move the manual binary out of Homebrew's link path first, then install and validate the chosen version. Do not force Homebrew to overwrite it during routine restoration.

## Restore boundaries

This repository captures the current terminal setup and Homebrew-managed software. Applications installed outside Homebrew, app preferences beyond the configs tracked here, credentials, private work configuration and application data still need their own backups. The local paths and AWS MFA settings are intentionally excluded from Git.
