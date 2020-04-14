if [ -d $HOME/.local/bin ]
  set PATH $HOME/.local/bin $PATH
end

set EDITOR (which vim)
set -x GPG_TTY (tty)

source ~/.config/fish/completions/mix.fish
source ~/.asdf/asdf.fish
source ~/.asdf/completions/asdf.fish

fundle plugin 'oh-my-fish/plugin-android-sdk'
fundle plugin 'oh-my-fish/plugin-bang-bang'
# fundle plugin 'nesl247/fish-theme-dracula'
fundle plugin 'oh-my-fish/plugin-basename-compat'
fundle plugin 'tuvistavie/fish-ssh-agent'
fundle plugin 'fisherman/pipenv'

fundle init

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

# eval (dircolors $HOME/.config/dircolors | head -n 1 | sed 's/^LS_COLORS=/set -x LS_COLORS /;s/;$//')
