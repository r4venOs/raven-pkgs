#!/bin/bash
# Setup local qtile configuration files for packaging

echo "Setting up qtile configuration files..."

# Create directory structure
mkdir -p etc/skel/.config/qtile

# Copy qtile configuration from home directory
if [ -d "$HOME/.config/qtile" ]; then
    echo "Copying qtile configuration from ~/.config/qtile..."
    
    # Copy all files
    cp -r "$HOME/.config/qtile/"* etc/skel/.config/qtile/
    
    echo "✓ Files copied to etc/skel/.config/qtile/"
    echo ""
    echo "Contents:"
    ls -la etc/skel/.config/qtile/
    echo ""
    echo "Ready to build package!"
else
    echo "ERROR: No qtile configuration found in ~/.config/qtile"
    exit 1
fi
