# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
  xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

if [ "$color_prompt" = yes ]; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
  *)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

source /usr/local/lib/google-cloud-sdk/completion.bash.inc
source /usr/local/lib/google-cloud-sdk/path.bash.inc

alias rm='rm -i'
alias ..="cd .."
alias c="clear"

source ~/.git-prompt.sh

color_sample() {
  for fore in `seq 30 37`; do printf "\e[${fore}m \\\e[${fore}m \e[m\n"; for mode in 1 4 5; do printf "\e[${fore};${mode}m \\\e[${fore};${mode}m \e[m"; for back in `seq 40 47`; do printf "\e[${fore};${back};${mode}m \\\e[${fore};${back};${mode}m \e[m"; done; echo; done; echo; done; printf " \\\e[m\n"
  }

__git_prompt() {
  local branch=$(__git_ps1 "%s")
  if [[ ! -z "${branch}" ]]; then
    echo -e "\e[0;32m${branch}\e[0m"
  fi
}

__gcloud_prompt() {
  if [[ ! -f ~/.config/gcloud/active_config ]]; then
    return 0
  fi
  local project_id=$(cat ~/.config/gcloud/configurations/config_$(cat ~/.config/gcloud/active_config) | grep 'project' | sed -r 's/.*project\s?=\s?(.+)/\1/g')
  if [[ ! -z "${project_id}" ]]; then
    echo -e "\e[0;33m${project_id}\e[0m"
  fi
}

__dev_prompt() {
  local txt=$(__gcloud_prompt)
  local branch=$(__git_prompt)
  if [[ ! -z ${txt} && ! -z ${branch} ]]; then
    txt="${txt}|"
  fi
  txt="${txt}${branch}"

  if [[ ! -z ${txt} ]]; then
    echo "(${txt})"
  fi
}

__prev_result_prompt() {
  if [[ $? != 0 ]]; then
    echo -e "\e[31m\xE2\x9C\x98\e[0m "
  fi 
}

export PS1='[$(__prev_result_prompt)\u@\[\e[0;35m\]\h\[\e[0m\]]$(__dev_prompt) \w\n$ '
