# Fix PATH order after path_helper messes it up
if [[ -n "$IN_NIX_SHELL" ]]; then
    PATH=$(echo "$PATH" | sed -e 's|/opt/homebrew/bin:||g' -e 's|/opt/homebrew/sbin:||g') # Remove homebrew paths
    if [[ -d "/opt/homebrew/bin" ]]; then
        export PATH="$PATH:/opt/homebrew/bin:/opt/homebrew/sbin" # Add homebrew paths at the end
    fi
fi
