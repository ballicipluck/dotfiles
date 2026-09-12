function fish_prompt
    echo ''
    set_color $fish_color_cwd
    echo (path basename $PWD)
    # set_color normal
    echo -n ' ▸ '
end
