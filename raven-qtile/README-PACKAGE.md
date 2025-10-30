# Raven Qtile Package - Setup Guide

## 📦 Package Files

Your package now has:
- ✅ **PKGBUILD** - Complete package build script
- ✅ **raven-qtile.install** - Installation messages and instructions
- ✅ **.gitignore** - Excludes build files from git

## 🚀 Next Steps

### 1. Prepare Your GitHub Repository

Your GitHub repo should contain these files from your qtile config:

```
raven-qtile/
├── config.py          # Main qtile configuration (REQUIRED)
├── autostart.sh       # Autostart script (recommended)
├── scripts/           # Custom scripts (optional)
├── Wallpaper/         # Wallpapers (optional)
├── *.png, *.jpg       # Icons/images (optional)
├── README.md          # Repository documentation
└── LICENSE            # License file (recommended)
```

### 2. Copy Your Qtile Config to GitHub Repo

```bash
# Clone your GitHub repository
cd /tmp
git clone git@github.com:r4venOs/raven-qtile.git
cd raven-qtile

# Copy your qtile configuration
cp ~/.config/qtile/config.py .
cp ~/.config/qtile/autostart.sh .

# Copy scripts if you have them
if [ -d ~/.config/qtile/scripts ]; then
    cp -r ~/.config/qtile/scripts .
fi

# Copy wallpapers if you have them
if [ -d ~/.config/qtile/Wallpaper ]; then
    cp -r ~/.config/qtile/Wallpaper .
fi

# Copy images
cp ~/.config/qtile/*.png . 2>/dev/null || true
cp ~/.config/qtile/*.jpg . 2>/dev/null || true

# Create README
cat > README.md << 'EOF'
# Raven Qtile Configuration

Custom Qtile window manager configuration for OffenArch.

## Features

- Modern and minimal design
- Custom keybindings
- Autostart script
- Wallpaper support

## Installation

### From AUR/Repository
```bash
sudo pacman -S raven-qtile
```

### Manual Installation
```bash
git clone https://github.com/r4venOs/raven-qtile.git
cd raven-qtile
cp -r * ~/.config/qtile/
```

## Keybindings

- `Mod+Return` - Open terminal
- `Mod+Shift+Return` - Open rofi launcher
- `Mod+q` - Close window
- `Mod+Shift+r` - Restart Qtile
- `Mod+Shift+q` - Quit Qtile

## Dependencies

- qtile
- python
- python-psutil

## Optional Dependencies

- picom - Compositor
- nitrogen - Wallpaper manager
- rofi - Application launcher
- kitty/alacritty - Terminal

## License

MIT
EOF

# Create LICENSE
cat > LICENSE << 'EOF'
MIT License

Copyright (c) 2025 r4venOs

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF

# Commit and push
git add .
git commit -m "Initial qtile configuration"
git push origin main
```

### 3. Create a Release Tag

```bash
cd /tmp/raven-qtile

# Create and push tag v1.0.0
git tag -a v1.0.0 -m "Release version 1.0.0"
git push origin v1.0.0
```

This creates the release that the PKGBUILD will download from.

### 4. Build the Package

```bash
cd /home/c3p0/iso

# Build the package
./build-package.sh /home/c3p0/iso/raven-pkgs/raven-qtile

# Update repository database
./build-repo-db.sh
```

## 📝 PKGBUILD Details

### What It Does

The PKGBUILD:
1. Downloads your qtile config from GitHub release (v1.0.0)
2. Installs to `/etc/skel/.config/qtile/`
3. New users automatically get the config
4. Existing users can copy from `/etc/skel/`

### Source URL

```bash
source=("${pkgname}-${pkgver}.tar.gz::https://github.com/r4venOs/${pkgname}/archive/refs/tags/v${pkgver}.tar.gz")
```

This downloads: `https://github.com/r4venOs/raven-qtile/archive/refs/tags/v1.0.0.tar.gz`

### Dependencies

**Required:**
- qtile
- python
- python-psutil

**Optional:**
- picom (compositor)
- nitrogen (wallpaper)
- rofi (launcher)
- kitty/alacritty (terminal)
- dunst (notifications)
- playerctl (media control)
- brightnessctl (brightness)
- pamixer (audio)

## 🔄 Updating the Package

When you update your qtile config:

### 1. Update GitHub

```bash
cd /tmp/raven-qtile
# Make your changes
git add .
git commit -m "Update configuration"
git push origin main
```

### 2. Create New Release

```bash
# Increment version
git tag -a v1.0.1 -m "Release version 1.0.1"
git push origin v1.0.1
```

### 3. Update PKGBUILD

```bash
cd /home/c3p0/iso/raven-pkgs/raven-qtile
nano PKGBUILD

# Change:
pkgver=1.0.1
pkgrel=1
```

### 4. Rebuild

```bash
cd /home/c3p0/iso
./build-package.sh /home/c3p0/iso/raven-pkgs/raven-qtile
./build-repo-db.sh
```

## 🧪 Testing the Package

### Test Build

```bash
cd /home/c3p0/iso/raven-pkgs/raven-qtile
makepkg -sf
```

### Test Installation

```bash
sudo pacman -U raven-qtile-1.0.0-1-any.pkg.tar.zst
```

### Verify Files

```bash
# Check installed files
pacman -Ql raven-qtile

# Check config location
ls -la /etc/skel/.config/qtile/
```

## 📋 Checklist

Before building:
- [ ] Qtile config pushed to GitHub
- [ ] Release tag created (v1.0.0)
- [ ] README.md in repository
- [ ] LICENSE in repository
- [ ] PKGBUILD updated
- [ ] .install file updated

## 🐛 Troubleshooting

### Build fails: "Cannot find source"

**Problem:** GitHub release doesn't exist

**Solution:**
```bash
# Check if tag exists
git ls-remote --tags https://github.com/r4venOs/raven-qtile

# Create tag if missing
cd /tmp/raven-qtile
git tag -a v1.0.0 -m "Release v1.0.0"
git push origin v1.0.0
```

### Build fails: "config.py not found"

**Problem:** config.py not in repository root

**Solution:**
```bash
# Make sure config.py is in root
cd /tmp/raven-qtile
ls -la config.py  # Should exist
git add config.py
git commit -m "Add config.py"
git push
```

### Package installs but config not working

**Problem:** Missing dependencies

**Solution:**
```bash
# Install required dependencies
sudo pacman -S qtile python python-psutil

# Install optional dependencies
sudo pacman -S picom nitrogen rofi kitty dunst
```

## 📚 Resources

- [PKGBUILD Documentation](https://wiki.archlinux.org/title/PKGBUILD)
- [Qtile Documentation](http://docs.qtile.org/)
- [Your Repository](https://github.com/r4venOs/raven-qtile)

---

**Ready to build!** Follow the steps above to prepare your package.
