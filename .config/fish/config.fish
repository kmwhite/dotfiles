if [ -d $HOME/.local/bin ]
  set PATH $HOME/.local/bin $PATH
end

set EDITOR (which vim)
set -x GPG_TTY (tty)

source ~/.config/fish/completions/mix.fish
source ~/.asdf/asdf.fish
source ~/.asdf/completions/asdf.fish

# function fish_right_prompt; end

set -g theme_display_git yes
set -g theme_display_git_untracked yes
set -g theme_display_git_ahead_verbose yes
set -g theme_git_worktree_support no
set -g theme_display_vagrant no
set -g theme_display_docker_machine no
set -g theme_display_hg no
set -g theme_display_virtualenv no
set -g theme_display_ruby no
set -g theme_display_user no
set -g theme_display_vi no
set -g theme_display_date no
set -g theme_display_cmd_duration yes
set -g theme_title_display_process yes
set -g theme_title_display_path no
set -g theme_title_use_abbreviated_path no
set -g theme_date_format "+%a %H:%M"
set -g theme_avoid_ambiguous_glyphs yes
set -g theme_powerline_fonts no
set -g theme_nerd_fonts no
set -g theme_show_exit_status yes
set -g default_user kristofer
set -g theme_color_scheme base16-dark
set -g fish_prompt_pwd_dir_length 0
set -g theme_project_dir_length 0

fundle plugin 'oh-my-fish/plugin-android-sdk'
fundle plugin 'oh-my-fish/plugin-bang-bang'
fundle plugin 'oh-my-fish/theme-bobthefish'
fundle plugin 'oh-my-fish/plugin-basename-compat'
fundle plugin 'tuvistavie/fish-ssh-agent'
fundle plugin 'fisherman/pipenv'

fundle init

eval (dircolors $HOME/.config/dircolors | head -n 1 | sed 's/^LS_COLORS=/set -x LS_COLORS /;s/;$//')
