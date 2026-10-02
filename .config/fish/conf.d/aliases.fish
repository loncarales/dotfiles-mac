# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."

# Shortcuts
alias d="cd ~/Documents"
alias dl="cd ~/Downloads"
alias dt="cd ~/Desktop"
alias p="cd ~/Projects"
alias g="git"

# Safe and verbose file ops
alias mv="mv -v"
alias rm="rm -i -v"
alias cp="cp -v"

# Hosts file
function hosts
    sudo $EDITOR /etc/hosts
end

# Disk space
alias diskspace_report="df -P -kHl"

# Podman aliases
alias containers_status='watch -n 2 "podman ps --format \"table {{.ID}}\t {{.Image}}\t {{.Status}}\""'
alias containers_statistics='podman stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"'

# eza aliases
alias l="eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first"
alias ll="eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -l --git -h"
alias la="eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a"
alias lla="eza --color=always --color-scale=all --color-scale-mode=gradient --icons=always --group-directories-first -a -l --git -h"
alias ls="eza --all --long --group --group-directories-first --icons --header --time-style long-iso"

# IP
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"

alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

# Trash cleanup
alias cleanup="find . -type f -name '*.DS_Store' -ls -delete"
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl; sqlite3 ~/Library/Preferences/com.apple.LaunchServices.QuarantineEventsV* 'delete from LSQuarantineEvent'"

# Finder tweaks
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Desktop icons
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Lock screen
alias afk="osascript -e 'tell app \"System Events\" to key code 12 using {control down, command down}'"

# Reload fish config
alias reload="source ~/.config/fish/config.fish"

# Process monitors
alias pscpu="ps aux | sort -nr -k 3 | head -n 6"
alias pscpu10="ps aux | sort -nr -k 3 | head -n 11"

# Disk usage
function dusize
    for file in *
        set size (du -sk $file | cut -f1)
        set name $file
        for unit in k M G T P E Z Y
            if test $size -lt 1024
                echo "-$size$unit\t$name"
                break
            end
            set size (math "$size / 1024")
        end
    end
end
