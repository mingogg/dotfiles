if [ -f ~/.local/bin/bash-functions ]; then
  source ~/.local/bin/bash-functions
fi

if [ -f ~/.config/theme/current/colors/bashColors.sh ]; then
    source ~/.config/theme/current/colors/bashColors.sh
fi

# Aliases to open files, directories & workspaces
alias of=openFile
alias od=openDirectory
alias ow=~/dev/scripts/ws_launcher.sh
alias reboot=safeBraveReboot
alias poweroff=safeBravePoweroff

PS1="\n[\[${RESET}\]\u@\h \[${FG}\]\w\[${RESET}\]\$(parse_git_info)\[${RESET}\]]\n\[${PRIMARY}\] 󰣇 \[${RESET}\] "

export PATH="$PATH:$HOME/.npm-global/bin"
export PATH="$HOME/.local/bin:$PATH"
