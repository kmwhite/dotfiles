source ~/.asdf/asdf.fish
source ~/.config/fish/completions/asdf.fish
source ~/.config/fish/completions/mix.fish

fundle plugin 'oh-my-fish/plugin-android-sdk'
fundle plugin 'oh-my-fish/plugin-bang-bang'
fundle plugin 'nesl247/fish-theme-dracula'
fundle plugin 'oh-my-fish/plugin-basename-compat'

fundle init

function functions_rename
    set -l old_func $argv[1]
    set -l new_func $argv[2]
    if test $old_func = $new_func
        return
    end

    functions --copy $old_func $new_func
    functions --erase $old_func

    set -l saved_func $HOME/.config/fish/functions/$old_func.fish
    if test -f $saved_func
        funcsave $new_func
        rm $saved_func
    end
end

functions_rename fish_prompt fish_prompt_orig
function fish_prompt
  echo ""
  fish_prompt_orig
end
