function fish_prompt_old
    echo ''
    set_color $fish_color_cwd
    echo (path basename $PWD)
    echo -n ' ▸ '
end


function fish_prompt
    echo ''
    set -l last_status $status

    if not set -q -g __fish_arrow_functions_defined
        set -g __fish_arrow_functions_defined

        function _git_branch_name
            set -l branch (git symbolic-ref --quiet HEAD 2>/dev/null)

            if set -q branch[1]
                echo (string replace -r '^refs/heads/' '' $branch)
            else
                echo (git rev-parse --short HEAD 2>/dev/null)
            end
        end

        function _is_git_dirty
            not command git diff-index --cached --quiet HEAD -- &>/dev/null
            or not command git diff --no-ext-diff --quiet --exit-code &>/dev/null
        end

        function _is_git_repo
            type -q git
            or return 1

            git rev-parse --git-dir >/dev/null 2>&1
        end

        function _hg_branch_name
            echo (hg branch 2>/dev/null)
        end

        function _is_hg_dirty
            set -l stat (hg status -mard 2>/dev/null)
            test -n "$stat"
        end

        function _is_hg_repo
            fish_print_hg_root >/dev/null
        end

        function _repo_branch_name
            _$argv[1]_branch_name
        end

        function _is_repo_dirty
            _is_$argv[1]_dirty
        end

        function _repo_type
            if _is_hg_repo
                echo hg
                return 0
            else if _is_git_repo
                echo git
                return 0
            end

            return 1
        end
    end


    # ─────────────────────────────────────────────
    # Colors
    # Full intensity
    set -l cyan (set_color -o cyan)
    set -l red (set_color -o red)
    set -l green (set_color -o green)

    # Muted repo colors
    set -l repo_blue (set_color --dim blue)
    set -l repo_red (set_color --dim red)
    set -l repo_yellow (set_color --dim yellow)
    set -l muted (set_color --dim brblack)

    set -l normal (set_color normal)


    # ─────────────────────────────────────────────
    # CWD

    set -l cwd_text (path basename -- $PWD)
    set -l cwd "$cyan$cwd_text"


    # ─────────────────────────────────────────────
    # Git / Hg

    set -l repo_info
    set -l repo_text

    if set -l repo_type (_repo_type)
        set -l repo_branch (_repo_branch_name $repo_type)

        set repo_text "$repo_type:$repo_branch"
        set repo_info "$repo_blue$repo_type:$repo_red$repo_branch"

        if _is_repo_dirty $repo_type
            set repo_text "$repo_text ✗"
            set repo_info "$repo_info$repo_yellow ✗"
        end

        set repo_info "$repo_info$normal"
    end


    # ─────────────────────────────────────────────
    # Time
    set -l time_text (date "+%R")
    set -l time "$muted$time_text$normal"


    # ─────────────────────────────────────────────
    # First line

    set -l right_text "$repo_text $time_text"

    set -l left_width (string length --visible -- "$cwd_text")
    set -l right_width (string length --visible -- "$right_text")

    # Start column is 1-indexed.
    set -l right_column (math $COLUMNS - $right_width + 1)

    # Don't allow the right side to overlap the CWD.
    set -l minimum_column (math $left_width + 3)

    if test $right_column -lt $minimum_column
        set right_column $minimum_column
    end

    # Move cursor to the right side of the terminal.
    printf '%s' "$cwd"
    printf '\e[%dG' $right_column
    printf '%s' "$repo_info"

    if test -n "$repo_info"
        printf ' %s' "$time"
    else
        printf '%s' "$time"
    end

    printf '\n'


    # ─────────────────────────────────────────────
    # Arrow — full intensity

    set -l arrow_color "$green"

    if test $last_status != 0
        set arrow_color "$red"
    end

    set -l arrow "$arrow_color➜ "

    if fish_is_root_user
        set arrow "$arrow_color# "
    end


    # ─────────────────────────────────────────────
    # Command status

    set -l prompt_status

    if test $last_status -ne 0
        set prompt_status (set_color $fish_color_status)"[$last_status]$normal"
    end


    # ─────────────────────────────────────────────
    # Second line — command input

    echo -n $prompt_status ' ' $arrow
end