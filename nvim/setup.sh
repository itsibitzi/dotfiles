SCRIPT_PATH=$( cd $(dirname $0) ; pwd -P )

if [[ "$OSTYPE" = "darwin"* ]]; then
    if ! command -v &> /dev/null; then
        brew install \
            ripgrep
    fi
else
    echo 'Not supporting non MacOS for now'
    exit 1
fi

mkdir -p ~/.config/nvim/

# Basic init
cp "$SCRIPT_PATH/init.vim" ~/.config/nvim/init.vim

# Lua scripts
cp -r "$SCRIPT_PATH/lua/" ~/.config/nvim/lua/
