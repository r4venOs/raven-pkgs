#!/bin/bash
# Setup local kitty configuration files for packaging

echo "Setting up kitty configuration files..."

# Create directory structure
mkdir -p etc/skel/.config/kitty

# Copy kitty configuration from home directory
if [ -d "$HOME/.config/kitty" ]; then
    echo "Copying kitty configuration from ~/.config/kitty..."
    
    # Copy all files
    cp -r "$HOME/.config/kitty/"* etc/skel/.config/kitty/
    
    echo "✓ Files copied to etc/skel/.config/kitty/"
    echo ""
    echo "Contents:"
    ls -la etc/skel/.config/kitty/
    echo ""
    echo "Ready to build package!"
else
    echo "ERROR: No kitty configuration found in ~/.config/kitty"
    exit 1
fi
