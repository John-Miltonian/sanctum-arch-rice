# Sanctum OS - Dark Christian Arch Rice

A dark mode, transparent window Arch Linux rice with Christian liturgical theming.

![Sanctum OS](screenshots/preview.png)

## Overview

This rice features:
- **WM**: Niri (scrollable tiling window manager)
- **Bar**: Waybar with liturgical workspace names and gold accents
- **Terminal**: Kitty with transparency (92% opacity) and cross prompt
- **Theme**: Dark mode with gold/amber accents following liturgical colors
- **Wallpaper**: Dark religious artwork (Tenebrism/Caravaggio style)
- **Transparency**: All windows support transparency effects

## Screenshots

*Add your own screenshots to the `screenshots/` folder*

## Installation

### One-Line Install

```bash
curl -fsSL https://raw.githubusercontent.com/John-Miltonian/sanctum-arch-rice/master/install.sh | bash
```

### Manual Install

```bash
# 1. Install dependencies
sudo pacman -S niri waybar kitty wofi swaybg mako wl-clipboard

# Install AUR packages
yay -S swaylock-effects wlogout

# 2. Clone the rice
git clone https://github.com/John-Miltonian/sanctum-arch-rice.git

# 3. Run setup
cd sanctum-arch-rice
./setup.sh
```

## Dependencies

### Required
- `niri` - Window manager
- `waybar` - Status bar
- `kitty` - Terminal emulator
- `wofi` - Application launcher
- `swaybg` - Wallpaper daemon
- `mako` - Notification daemon

### Optional (AUR)
- `swaylock-effects` - Lock screen with blur effects
- `wlogout` - Logout menu

## Keybindings (Niri)

| Key | Action |
|-----|--------|
| Super+Enter | Open terminal |
| Super+Q | Close window |
| Super+Space | Open launcher (wofi) |
| Super+1-9 | Switch to workspace |
| Super+Shift+1-9 | Move window to workspace |
| Super+Tab | Toggle overview |
| Super+F | Fullscreen |
| Super+Shift+E | Exit Niri |

## Workspaces

Workspaces follow liturgical naming:
- 1: Sanctum
- 2: Scripture
- 3: Prayer
- 4: Work
- 5: Study
- 6: Rest
- 7: Media
- 8: System
- 9: Communion

## Theming

Colors follow the liturgical calendar:
- **Gold** (#c9a227): Major feasts (default accent)
- **Purple** (#9d7eb5): Advent, Lent
- **Red** (#c45c5c): Pentecost, martyrs
- **Green** (#5c8c5c): Ordinary time
- **White** (#d8cfc4): Easter, Christmas

### Switching Themes

```bash
~/.local/bin/liturgical-theme.sh [gold|purple|red|green|white]
```

## Terminal Prompt

The Zsh prompt features a cross symbol (✠) and displays:
- Username@hostname
- Current directory
- Git branch (if in a repo)
- Liturgical color indicator

Add to `~/.zshrc`:
```bash
source ~/.config/zsh/cross-prompt.zsh
```

## Wallpaper

Place your dark religious artwork at:
```
~/.config/wallpapers/sanctum-dark.jpg
```

Recommended sources:
- Wikimedia Commons (public domain religious art)
- Artvee (classical art)
- Caravaggio, Rembrandt, Zurbarán (Tenebrism style)

## File Structure

```
~/.config/
├── niri/config.kdl          # Window manager config
├── waybar/
│   ├── config               # Bar configuration
│   └── style.css            # Dark theme with gold accents
├── kitty/
│   ├── kitty.conf           # Terminal with transparency
│   └── session.conf         # Auto-start session
├── wofi/style.css           # Launcher styling
├── mako/config              # Notifications
├── swaylock/config          # Lock screen
├── wlogout/
│   ├── layout               # Power menu layout
│   └── style.css            # Power menu styling
└── zsh/
    ├── cross-prompt.zsh     # Christian-themed prompt
    └── aliases              # Shell aliases

~/.local/bin/
├── liturgical-theme.sh      # Theme switcher
└── fetch-wallpapers.sh      # Wallpaper helper
```

## Customization

### Change Accent Color

Edit `~/.config/waybar/style.css`:
```css
/* Change gold to your preferred color */
border-color: #c9a227;  /* Gold */
```

### Adjust Transparency

Edit `~/.config/kitty/kitty.conf`:
```
background_opacity 0.92  # Adjust 0.0-1.0
```

### Change Cross Symbol

Edit `~/.config/zsh/cross-prompt.zsh` and change:
```zsh
local CROSS="✠"  # Try: † ✝ ✞ ✟ ⛪
```

## Gallery

*Add your screenshots here*

## Credits

- Niri: https://github.com/YaLTeR/niri
- Inspired by Christian art and liturgical tradition

## License

MIT License - Feel free to modify and share.

---

*"The earth is the Lord's, and everything in it." - Psalm 24:1*
