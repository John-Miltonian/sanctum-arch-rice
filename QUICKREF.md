# Sanctum OS - Quick Reference Guide

## First Time Setup

```bash
# 1. Install dependencies
sudo pacman -S --needed niri waybar kitty wofi swaybg mako wl-clipboard grim slurp
yay -S swaylock-effects wlogout

# 2. Run setup
./setup.sh

# 3. Install Christian tools
./install-christian-tools.sh

# 4. Add wallpaper
# Save dark religious image to ~/.config/wallpapers/sanctum-dark.jpg

# 5. Start Niri
niri
```

## Essential Keybindings

| Key | Action |
|-----|--------|
| `Super+Enter` | Open Kitty terminal |
| `Super+Space` | Open Wofi launcher |
| `Super+Q` | Close window |
| `Super+Tab` | Overview/Exposé |
| `Super+F` | Toggle fullscreen |
| `Super+Shift+E` | Exit Niri |
| `Super+L` | Lock screen |
| `Super+1-0` | Switch workspaces (Sanctum, Scripture, etc.) |
| `Super+Shift+1-0` | Move window to workspace |

## Christian Tool Keybindings

| Key | Action |
|-----|--------|
| `Super+B` | Open Bible CLI (TUI) |
| `Super+Shift+B` | Open BibleTime (GUI) |
| `Super+V` | Daily verse in terminal |
| `Super+K` | KJV Bible reader |

## Liturgical Theme Commands

```bash
liturgical-theme.sh auto       # Auto-detect based on date
liturgical-theme.sh advent     # Purple - preparation
liturgical-theme.sh christmas  # White/Gold - celebration
liturgical-theme.sh lent       # Purple - penitence
liturgical-theme.sh easter     # White/Gold - resurrection
liturgical-theme.sh pentecost  # Red - Holy Spirit
liturgical-theme.sh ordinary   # Green - growth (default)
```

## Bible Commands

```bash
# KJV Bible reader
kjv John 3:16                  # Single verse
kjv Psalm 23                   # Full chapter
kjv "Song of Solomon 2:1-4"    # Range

# NET Bible
bib John 3:16

# Daily verse
daily-verse

# TUI Bible reader
bible-cli

# Multi-language search
grepbible "John 3:16" -l en    # English
grepbible "John 3:16" -l la    # Latin Vulgate

# Random verse
random-verse
```

## Prayer Hours

```bash
christian-hours    # Show current prayer hour
```

Hours of the Divine Office:
- **Matins/Lauds** (6-7 AM) - Morning Prayer
- **Prime** (8-9 AM) - First Hour
- **Terce** (10-11 AM) - Third Hour
- **Sext** (12-1 PM) - Midday
- **None** (2-3 PM) - Ninth Hour
- **Vespers** (5-6 PM) - Evening Prayer
- **Compline** (8-9 PM) - Night Prayer

## Workspace Names

1. **Sanctum** (✠) - Main workspace
2. **Scripture** (✞) - Bible study
3. **Communion** (☧) - Communication
4. **Labor** (⚒) - Work/development
5. **Reflection** (✡) - Media/entertainment
6. **Rest** (☽) - Relaxation
7. **Prayer** (🙏) - Meditation/prayer apps
8. **Study** (📖) - Learning
9. **Service** (⚙) - System/tools
10. **Glory** (☀) - Special projects

## Aliases

| Alias | Command |
|-------|---------|
| `k` | `kjv` |
| `verse` | `daily-verse` |
| `hours` | `christian-hours` |
| `theme` | `liturgical-theme.sh` |

## Configuration Locations

| File | Location |
|------|----------|
| Niri config | `~/.config/niri/config.kdl` |
| Waybar config | `~/.config/waybar/` |
| Kitty config | `~/.config/kitty/kitty.conf` |
| Cross prompt | `~/.config/zsh/cross-prompt.zsh` |
| Wofi style | `~/.config/wofi/style.css` |
| Wallpapers | `~/.config/wallpapers/` |

## Troubleshooting

### Niri won't start
```bash
# Check if running on Wayland
 echo $WAYLAND_DISPLAY

# Check for errors
niri 2>&1 | tee /tmp/niri.log
```

### Transparency not working
- Ensure `background_opacity` is set in kitty.conf
- Check compositor is running

### Missing icons in Waybar
```bash
# Install Font Awesome
sudo pacman -S ttf-font-awesome
```

### Bible tools not found
```bash
# Check if in PATH
which kjv

# Reinstall
./install-christian-tools.sh
```

## Wallpaper Recommendations

**Sources:**
- Wikimedia Commons (Public Domain)
- Artvee (Public Domain Art)
- Your own church photography

**Artists for dark religious art:**
- Caravaggio (Tenebrism)
- Rembrandt (chiaroscuro)
- Georges de La Tour (candlelight)
- Zurbarán (Spanish religious)
- Ribera (saints)

## Daily Use Workflow

1. **Morning:** Terminal opens with daily verse
2. **Bible Study:** `Super+2` to Scripture workspace, `Super+B` for Bible CLI
3. **Work:** `Super+4` to Labor workspace, `Super+Enter` for terminal
4. **Prayer:** `Super+7` to Prayer workspace, `christian-hours` for hour reminder
5. **Evening:** `Super+L` to lock, Vespers reflection

## Customization

### Change Cross Style
Edit `~/.config/zsh/cross-prompt.zsh`:
```zsh
local cross="✠"  # Change to: ✞ ✝ ☧ ☩ ✟ ♰ ♱ ✙ ✚
```

### Change Colors
Edit `~/.config/waybar/style.css` for bar colors.
Edit `~/.config/kitty/kitty.conf` for terminal colors.

### Add New Workspaces
Edit `~/.config/niri/config.kdl` - add workspace names and keybindings.
