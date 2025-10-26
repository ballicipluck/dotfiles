# check if brew installed (prerequisite for mac setup)
if ! command -v brew &> /dev/null; then
    echo "Homebrew is not installed. Please install Homebrew first."
    exit 1
fi

# check if mise is installed
if ! command -v mise &> /dev/null; then
    echo "Mise is not installed. Please install Mise first. Maybe try 'curl https://mise.run | sh'?"
    exit 1
fi

# check if flag --full (-f) is provided (it could be any order)
FULL_SETUP=false
for arg in "$@"; do
    if [[ "$arg" == "--full" || "$arg" == "-f" ]]; then
        FULL_SETUP=true
        break
    fi
done

# use mise to install lua@5.1, and set it as the default lua version
mise install lua@5.1
mise use -g lua@5.1

# setup nvim tools (fzf, ripgrep[rg], fd, lazygit, ghostscript[gs], tectonic[tex], tree-sitter)
brew install fzf ripgrep fd lazygit tree-sitter-cli

if $FULL_SETUP; then
    brew install ghostscript tectonic
fi

