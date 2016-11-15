# If run as an Interactive Shell...
if [[ $- == *i* ]]; then

    # Set System-Wide Options
    export PAGER="$(which less)"
    export EDITOR="$(which vim)"

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
    LOCAL_BIN="${HOME}/.local/bin"
    if [ -e "${LOCAL_BIN}" ]; then
        export PATH="${LOCAL_BIN}:${PATH}"
    fi

    # Platform Based Configuration
    case "$(uname)" in
        OpenBSD)
            export PATH HOME TERM
            export PKG_PATH="http://mirror.planetunix.net/pub/$(uname)/$(uname -r)/packages/$(machine -a)"
            alias pkg_add="sudo pkg_add -vim"
            ;;
        FreeBSD)
            if [ -f ${HOME}/.termcap ]; then
              export TERMCAP=$(< ${HOME}/.termcap)
            fi
            alias pkg_add="sudo pkg_add -r"
            ;;
        NetBSD)  ;;
        Linux)
            alias ls="ls --color='auto'"
            ;;
        *)       ;;
    esac

    #### Set up the shell
    # Shell Based Configuration
    set -o vi
    ####
fi
