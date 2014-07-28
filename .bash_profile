# Read when a shell starts

# Read in the GPG Agent Info, if it is available
if [ -f "${HOME}/.gpg-agent-info" ]; then
    . "${HOME}/.gpg-agent-info"
    export GPG_AGENT_INFO
    export SSH_AUTH_SOCK
else
    eval $(gpg-agent --daemon --enable-ssh-support --write-env-file "${HOME}/.gpg-agent-info")
fi

# Start the SSH Agent
if [ -z "${SSH_AUTH_SOCK}" ] || [ -z "${SSH_AGENT_PID}" ]; then
    eval `ssh-agent`
fi


# Load shell helpers
CONFIG_DIR="${HOME}/.config/bash"
if [ -d "$CONFIG_DIR" ]; then
    printf "\x1b[33mLoading configs:\x1b[00m\n"
    for CONFIG_FILE in `ls ${CONFIG_DIR}/*.cfg`; do
        printf "    \x1b[33m${CONFIG_FILE}...\x1b[00m"
        . "${CONFIG_FILE}" 2>/dev/null && \
                printf " \x1b[32mOK!\x1b[00m " || \
                printf " \x1b[31mFAILURE!\x1b[00m "
        printf "\n"
    done
    printf "\n"
fi

# Add to the PATH variable
prepend_path "${HOME}/.local/bin"

# Platform Based Configuration
case "$(uname)" in
    OpenBSD)
        export PATH HOME TERM
        export PKG_PATH="http://mirror.planetunix.net/pub/$(uname)/$(uname -r)/packages/$(machine -a)"
        alias pkg_add="sudo pkg_add -vim"
        ;;
    FreeBSD)
        alias pkg_add="sudo pkg_add -r"
        ;;
    NetBSD)  ;;
    Linux)   ;;
    *)       ;;
esac

#### Set up the shell
# Shell Based Configuration
set -o emacs
bind "^I=complete"
####

#### Set up our prompts
# Prompt Color Legend:
# Green:        PS1, Last command was successful
# Red:          PS1, Last command was unsuccessful
# Yellow:       PS2, Incomplete command entered
# Blue:         PS3, Select statement menu prompt
# Purple:       PS4, Debug mode
export PS1='[01;37m[\w] [01;`last_status`m$>[0m '      # Primary Prompt
export PS2='[01;37m[\w] [01;33m$>[0m     '             # Incomplete Command
export PS3='[01;37m[\w] [01;34m$>[0m '                 # KSH Select Prompt
export PS4='[01;37m[\w] [01;35m$>[0m '                 # Debug Prompt (set -x)
####
