# zoxide (directory jumping)
eval "$(zoxide init zsh)"

# zsh-syntax-highlighting (must be loaded before autosuggestions)
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggestions
source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'

# Starship prompt
eval "$(starship init zsh)"

# loongsuite-pilot: add ~/.local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# loongsuite-pilot BEGIN qodercli-intercept
qodercli() { BUN_OPTIONS="--preload=/Users/nihplod/.loongsuite-pilot/hooks/qodercli-token-intercept.mjs" command qodercli "$@"; }
# loongsuite-pilot END qodercli-intercept

# loongsuite-pilot BEGIN claude-code-intercept
claude() { BUN_OPTIONS="--preload=/Users/nihplod/.loongsuite-pilot/hooks/claude-code-fetch-intercept.mjs ${BUN_OPTIONS}" command claude "$@"; }
# loongsuite-pilot END claude-code-intercept
