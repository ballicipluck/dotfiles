# editors
set -gx EDITOR "zed --wait"

# Ensure Homebrew is in PATH (needed for VSCode integrated terminal)
fish_add_path /opt/homebrew/bin

# neovim
alias nv=nvim

# zoxide
zoxide init fish | source
functions --copy __zoxide_z __zoxide_z_original
function __zoxide_z
    __zoxide_z_original $argv
    and pwd
end
# /zoxide

# mise
$HOME/.local/bin/mise activate fish | source

fzf --fish | source

# OrbStack: command-line tools and integration
source ~/.orbstack/shell/init2.fish 2>/dev/null || :

# Make local mise / luarocks Lua modules available to child processes (used by busted)
# not using busted for now.
# set -x LUA_PATH '$HOME/.local/share/mise/installs/lua/5.1/share/lua/5.1/?.lua;$HOME/.local/share/mise/installs/lua/5.1/share/lua/5.1/?/init.lua;$HOME/.local/share/mise/installs/lua/5.1/luarocks/share/lua/5.1/?.lua;$HOME/.local/share/mise/installs/lua/5.1/luarocks/share/lua/5.1/?/init.lua;;'
# set -x LUA_CPATH '$HOME/.local/share/mise/installs/lua/5.1/lib/lua/5.1/?.so;$HOME/.local/share/mise/installs/lua/5.1/luarocks/lib/lua/5.1/?.so;;'