#!/bin/bash
# Liturgical Theme Switcher for Sanctum OS
# Changes color scheme based on liturgical season

THEME=${1:-auto}
CONFIG_DIR="$HOME/.config"

# Color definitions
readonly COLOR_GOLD="#c9a227"      # Major feasts
readonly COLOR_PURPLE="#9d7eb5"    # Advent, Lent
readonly COLOR_RED="#c45c5c"       # Pentecost, martyrs
readonly COLOR_GREEN="#5c8c5c"     # Ordinary time
readonly COLOR_WHITE="#e8e8e8"     # Easter, Christmas
readonly COLOR_BLACK="#15151a"     # Dark background
readonly COLOR_GRAY="#3a3a45"      # Secondary dark

# Determine current liturgical season
get_season() {
    local month=$(date +%m)
    local day=$(date +%d)
    
    # Advent (4 Sundays before Christmas - approx Dec 1-24)
    if [[ $month == "12" && $day -le 24 ]]; then
        echo "advent"
        return
    fi
    
    # Christmas (Dec 25 - Jan 6)
    if [[ ($month == "12" && $day -ge 25) || ($month == "01" && $day -le 6) ]]; then
        echo "christmas"
        return
    fi
    
    # Lent (40 days before Easter - roughly Feb-Mar)
    # Simplified: Feb 15 - Apr 10
    if [[ ($month == "02" && $day -ge 15) || ($month == "03") || ($month == "04" && $day -le 10) ]]; then
        echo "lent"
        return
    fi
    
    # Easter Season (50 days after Easter - roughly Apr 11 - May)
    if [[ ($month == "04" && $day -ge 11) || ($month == "05" && $day -le 31) ]]; then
        echo "easter"
        return
    fi
    
    # Pentecost (May 15-25)
    if [[ $month == "05" && $day -ge 15 && $day -le 25 ]]; then
        echo "pentecost"
        return
    fi
    
    # Ordinary Time (Green)
    echo "ordinary"
}

# Get color for season
get_color() {
    case $1 in
        advent|lent|purple) echo "$COLOR_PURPLE" ;;
        christmas|easter|white) echo "$COLOR_WHITE" ;;
        pentecost|red) echo "$COLOR_RED" ;;
        ordinary|green) echo "$COLOR_GREEN" ;;
        gold|feast) echo "$COLOR_GOLD" ;;
        *) echo "$COLOR_GOLD" ;;
    esac
}

# Get accent color for season
get_accent() {
    case $1 in
        advent|lent|purple) echo "#b07ab0" ;;
        christmas|easter|white) echo "#f0f0f0" ;;
        pentecost|red) echo "#e07a7a" ;;
        ordinary|green) echo "#7aad7a" ;;
        gold|feast) echo "#e6c45c" ;;
        *) echo "#e6c45c" ;;
    esac
}

# Apply theme to Kitty
apply_kitty_theme() {
    local color=$1
    local accent=$2
    local season=$3
    
    # Update kitty.conf with new colors
    sed -i "s/^active_border_color .*/active_border_color $color/" "$CONFIG_DIR/kitty/kitty.conf"
    sed -i "s/^cursor .*/cursor $color/" "$CONFIG_DIR/kitty/kitty.conf"
    sed -i "s/^selection_background .*/selection_background $color/" "$CONFIG_DIR/kitty/kitty.conf"
    sed -i "s/^color3  .*/color3  $color/" "$CONFIG_DIR/kitty/kitty.conf"
    sed -i "s/^color11 .*/color11 $accent/" "$CONFIG_DIR/kitty/kitty.conf"
    
    # Reload kitty if running
    if pgrep -x "kitty" > /dev/null; then
        kill -USR1 $(pgrep -x "kitty") 2>/dev/null || true
    fi
}

# Apply theme to Waybar
apply_waybar_theme() {
    local color=$1
    local season=$2
    
    # Update waybar CSS by modifying the active border color
    sed -i "s/border-bottom: 2px solid rgba([0-9a-f]*, [0-9.]*);/border-bottom: 2px solid $color;/" "$CONFIG_DIR/waybar/style.css" 2>/dev/null || true
    
    # Add liturgical class to waybar
    # This requires waybar to be restarted to take full effect
    pkill -USR2 waybar 2>/dev/null || true
}

# Update Niri config
apply_niri_theme() {
    local color=$1
    
    # Update border color in niri config
    sed -i "s/border-color .*/border-color \"$color\"/" "$CONFIG_DIR/niri/config.kdl"
}

# Set wallpaper based on season
set_seasonal_wallpaper() {
    local season=$1
    local wallpaper_dir="$CONFIG_DIR/wallpapers"
    
    # Check for seasonal wallpapers
    if [[ -f "$wallpaper_dir/sanctum-$season.jpg" ]]; then
        swaybg -i "$wallpaper_dir/sanctum-$season.jpg" -m fill &
    fi
}

# Display current theme info
show_theme_info() {
    local season=$1
    local color=$2
    
    echo ""
    echo "✠ Liturgical Theme Applied ✠"
    echo ""
    echo "Season: $season"
    echo "Color: $color"
    echo ""
    
    case $season in
        advent)
            echo "Advent - A time of preparation and expectation"
            echo "Theme: Hope and anticipation"
            ;;
        lent)
            echo "Lent - A time of penitence and reflection"
            echo "Theme: Sacrifice and preparation"
            ;;
        easter)
            echo "Easter - The season of resurrection joy"
            echo "Theme: Victory and new life"
            ;;
        christmas)
            echo "Christmas - The celebration of the Incarnation"
            echo "Theme: Joy and light in darkness"
            ;;
        pentecost)
            echo "Pentecost - The coming of the Holy Spirit"
            echo "Theme: Fire and empowerment"
            ;;
        ordinary)
            echo "Ordinary Time - Growing in faith and discipleship"
            echo "Theme: Life and growth"
            ;;
    esac
    echo ""
}

# Main function
main() {
    # Determine season
    if [[ "$THEME" == "auto" ]]; then
        SEASON=$(get_season)
    else
        SEASON="$THEME"
    fi
    
    # Get colors
    PRIMARY=$(get_color "$SEASON")
    ACCENT=$(get_accent "$SEASON")
    
    # Apply themes
    apply_kitty_theme "$PRIMARY" "$ACCENT" "$SEASON"
    apply_waybar_theme "$PRIMARY" "$SEASON"
    apply_niri_theme "$PRIMARY"
    set_seasonal_wallpaper "$SEASON"
    
    # Save current theme
    echo "$SEASON" > "$CONFIG_DIR/.liturgical-season"
    
    # Show info
    show_theme_info "$SEASON" "$PRIMARY"
    
    # Send notification
    if command -v notify-send &>/dev/null; then
        notify-send "✠ Sanctum OS" "Liturgical theme changed to: $SEASON"
    fi
}

# Help
show_help() {
    cat << 'EOF'
Liturgical Theme Switcher for Sanctum OS

Usage: liturgical-theme.sh [SEASON]

Seasons:
  auto      - Automatically detect based on date (default)
  advent    - Purple - Hope and expectation
  lent      - Purple - Penitence and reflection  
  easter    - White/Gold - Resurrection joy
  christmas - White/Gold - Incarnation celebration
  pentecost - Red - Holy Spirit fire
  ordinary  - Green - Growth and discipleship
  gold      - Gold - Major feasts
  purple    - Purple - Solemn feasts
  red       - Red - Martyrs and passion
  green     - Green - Ordinary time
  white     - White - Joyful feasts

Examples:
  liturgical-theme.sh auto      # Auto-detect season
  liturgical-theme.sh advent    # Force Advent theme
  liturgical-theme.sh gold      # Force gold accents

EOF
}

# Handle arguments
case $1 in
    -h|--help|help)
        show_help
        exit 0
        ;;
    *)
        main
        ;;
esac
