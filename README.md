# Sanctum OS - Dark Christian Arch Rice

A dark mode, transparent window Arch Linux rice with Christian theming.

## Overview

This rice features:
- **WM**: Niri (scrollable tiling window manager)
- **Bar**: Waybar with Christian icon styling
- **Terminal**: Kitty with transparency and cross prompt
- **Theme**: Dark mode with gold/amber accents (liturgical colors)
- **Wallpaper**: Dark religious artwork (Tenebrism/Caravaggio style)
- **Transparency**: All windows support transparency effects

## Christian Tools Included

### Terminal Bible Tools

1. **kjv** - Command-line King James Bible reader
   ```bash
   kjv John 3:16
   kjv Psalm 23
   ```

2. **bible-cli** - TUI Bible reader with multiple themes
   ```bash
   bible-cli
   ```

3. **daily-verse** - Daily Bible verse in terminal
   ```bash
   daily-verse
   ```

4. **grepbible** - Search across 60+ languages
   ```bash
   grepbible "John 3:16" -l en -l la
   ```

### GUI Bible Study

5. **BibleTime** - Qt-based Bible study (install via pacman)
6. **Xiphos** - GTK Bible study tool
7. **Ezra Bible App** - Modern Bible study with tags/keywords

### Prayer Tools

8. **prayer-time-cli** - Islamic-style prayer times (adapted for Christian hours)

## Installation

```bash
# Install Niri
sudo pacman -S niri

# Install dependencies
sudo pacman -S waybar kitty rofi wofi swaybg swaylock-effects

# Install Christian tools (from AUR or build from source)
yay -S kjv-git bible-cli daily-verse grepbible
sudo pacman -S bibletime xiphos

# Copy configs
cp -r config/* ~/.config/
cp -r local/bin/* ~/.local/bin/

# Set up cross prompt
echo 'source ~/.config/zsh/cross-prompt.zsh' >> ~/.zshrc
```

## Keybindings (Niri)

| Key | Action |
|-----|--------|
| `Super+Enter` | Open terminal |
| `Super+Q` | Close window |
| `Super+Space` | Open launcher |
| `Super+1-0` | Switch to workspace |
| `Super+Shift+1-0` | Move window to workspace |
| `Super+Tab` | Toggle overview |
| `Super+F` | Fullscreen |
| `Super+Shift+E` | Exit Niri |

## Theming

Colors follow the liturgical calendar:
- **Gold**: Major feasts (default accent)
- **Purple**: Advent/Lent
- **Red**: Pentecost/martyrs
- **Green**: Ordinary time
- **White**: Easter/Christmas

Switch themes with: `~/.local/bin/liturgical-theme.sh [gold|purple|red|green|white]`
