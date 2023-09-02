HISTFILE=~/.zsh_history
HISTSIZE=1000
SAVEHIST=1000
setopt autocd extendedglob nomatch
unsetopt beep notify

autoload -U colors && colors	# Load colors
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "

setopt autocd		# Automatically cd into typed directory.

stty stop undef		# Disable ctrl-s to freeze terminal.

setopt interactive_comments

#Aliases
alias -g rm="rm -rfv"
alias -g grep="grep --color=auto"
alias -g ls="logo-ls -Dh"
alias -g ip="ip -color=auto"
#alias -g vim="nvim"
#alias -g search="ddgr -n3"
#alias -g compile_all_suckless="cd ~/.git/dwm && doas make clean install && cd ../st && doas make clean install && cd ../dmenu && doas make clean install && cd ../slstatus && doas make clean install && cd"
alias -g cp="cp -riv"
#alias -g sxiv="nsxiv -a -sf"
alias -g pfetch="clear && pfetch"
alias -g lf="lfrun"
alias -g newsboat="newsboat -r"
alias -g porupdate="doas emaint -a sync;doas emerge -avuqDN @world"
alias -g porclean="doas emerge -c;doas eix-test-obsolete;doas eclean -d distfiles;doas eclean -d packages"

# Basic auto/tab complete:
autoload -U compinit
zstyle ':completion:*' menu select
zmodload zsh/complist
compinit
_comp_options+=(globdots)		# Include hidden files.

# vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu:
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char
bindkey '^H' backward-kill-word

# Change cursor shape for different vi modes.
function zle-keymap-select () {
    case $KEYMAP in
        vicmd) echo -ne '\e[1 q';;      # block
        viins|main) echo -ne '\e[5 q';; # beam
    esac
}

export LANG=en_US.UTF-8
export ZSH_COMPDUMP=$ZDOTDIR/cache/.zcompdump-$HOST
bindkey -s '^o' '^ulfcd\n'
bindkey -s '^a' '^ubc -lq\n'
bindkey -s '^f' '^ucd "$(dirname "$(fzf)")"\n'
bindkey '^[[P' delete-char
autoload -Uz compinit
compinit

source ~/.config/zsh/zsh-plugins/plugins/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/.config/zsh/zsh-plugins/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
