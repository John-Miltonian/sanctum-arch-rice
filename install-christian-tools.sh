#!/bin/bash
# Sanctum OS - Christian Tools Installation Script
# Installs Bible and prayer tools for Arch Linux

set -e

echo "✠ Sanctum OS - Installing Christian Tools ✠"
echo ""

# Check if running on Arch
if ! command -v pacman &>/dev/null; then
    echo "Error: This script is designed for Arch Linux."
    exit 1
fi

# Create directories
mkdir -p ~/bin
mkdir -p ~/.local/bin
mkdir -p ~/.config/wallpapers

# Update system
echo "Updating system..."
sudo pacman -Syu --noconfirm

# Install base dependencies
echo "Installing dependencies..."
sudo pacman -S --needed --noconfirm \
    base-devel \
    git \
    awk \
    curl \
    jq \
    make \
    gcc \
    npm \
    go \
    python \
    python-pip \
    python-requests \
    html2text \
    fzf \
    sqlite

# Install AUR helper if not present
if ! command -v yay &>/dev/null; then
    echo "Installing yay AUR helper..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
fi

echo ""
echo "=== Installing Christian Tools ==="
echo ""

# 1. kjv - Command-line KJV Bible
echo "Installing kjv (KJV Bible)..."
if ! command -v kjv &>/dev/null; then
    cd /tmp
    git clone https://github.com/LukeSmithxyz/kjv.git
    cd kjv
    sudo make install
    echo "✓ kjv installed"
else
    echo "✓ kjv already installed"
fi

# 2. layeh/kjv - Alternative C version
echo "Installing layeh/kjv (C version)..."
if ! command -v kjv &>/dev/null; then
    cd /tmp
    git clone https://github.com/layeh/kjv.git layeh-kjv
    cd layeh-kjv
    make
    sudo cp kjv /usr/local/bin/kjv-layeh
    echo "✓ layeh/kjv installed as kjv-layeh"
fi

# 3. bib - NET Bible reader
echo "Installing bib (NET Bible)..."
if ! command -v bib &>/dev/null; then
    cd /tmp
    git clone https://github.com/prestonharberts/bib.git
    cd bib
    sudo cp bib /usr/local/bin/
    sudo chmod +x /usr/local/bin/bib
    echo "✓ bib installed"
else
    echo "✓ bib already installed"
fi

# 4. daily-verse - Daily verse CLI
echo "Installing daily-verse..."
if ! command -v daily-verse &>/dev/null; then
    cd /tmp
    git clone https://github.com/patlehmann1/daily-verse.git
    cd daily-verse
    go build -o daily-verse .
    sudo cp daily-verse /usr/local/bin/
    echo "✓ daily-verse installed"
else
    echo "✓ daily-verse already installed"
fi

# 5. bible-cli - TUI Bible reader
echo "Installing bible-cli (TUI)..."
if ! command -v bible-cli &>/dev/null; then
    sudo npm install -g bible-cli
    echo "✓ bible-cli installed"
else
    echo "✓ bible-cli already installed"
fi

# 6. grepbible - Multi-language search
echo "Installing grepbible..."
if ! command -v grepbible &>/dev/null; then
    # Install pipx if not present
    if ! command -v pipx &>/dev/null; then
        sudo pacman -S --noconfirm python-pipx
        pipx ensurepath
    fi
    pipx install grepbible
    echo "✓ grepbible installed"
else
    echo "✓ grepbible already installed"
fi

# 7. c-bible - C-based searcher
echo "Installing c-bible..."
if ! command -v c-bible &>/dev/null; then
    cd /tmp
    git clone https://github.com/tysteiman/c-bible.git
    cd c-bible
    make
    sudo cp c-bible /usr/local/bin/
    echo "✓ c-bible installed"
else
    echo "✓ c-bible already installed"
fi

# 8. bible_verse-cli - Multi-version CLI
echo "Installing bible_verse-cli..."
if ! command -v bible_verse &>/dev/null; then
    cd /tmp
    git clone https://github.com/RaynardGerraldo/bible_verse-cli.git
    cd bible_verse-cli
    sudo cp bible_verse-cli.sh /usr/local/bin/bible_verse
    sudo chmod +x /usr/local/bin/bible_verse
    echo "✓ bible_verse-cli installed"
else
    echo "✓ bible_verse-cli already installed"
fi

# GUI Bible Study Apps
echo ""
echo "=== Installing GUI Bible Study Apps ==="
echo ""

# BibleTime
echo "Installing BibleTime..."
yay -S --noconfirm bibletime 2>/dev/null || echo "BibleTime available in AUR: yay -S bibletime"

# Xiphos
echo "Installing Xiphos..."
sudo pacman -S --noconfirm xiphos 2>/dev/null || yay -S --noconfirm xiphos 2>/dev/null || echo "Xiphos available in AUR"

# Ezra Bible App (AppImage or build from source)
echo "Installing Ezra Bible App..."
if ! command -v ezra-bible-app &>/dev/null; then
    cd /tmp
    wget -q "https://github.com/ezra-bible-app/ezra-bible-app/releases/latest/download/ezra-bible-app-linux.AppImage" -O ezra-bible-app.AppImage 2>/dev/null || true
    if [[ -f ezra-bible-app.AppImage ]]; then
        chmod +x ezra-bible-app.AppImage
        sudo mv ezra-bible-app.AppImage /usr/local/bin/ezra-bible-app
        echo "✓ Ezra Bible App installed"
    else
        echo "Ezra Bible App - download manually from GitHub releases"
    fi
else
    echo "✓ Ezra Bible App already installed"
fi

# Create helper scripts
echo ""
echo "=== Creating Helper Scripts ==="
echo ""

# Prayer time reminder (simplified Christian hours)
cat > ~/.local/bin/christian-hours << 'EOF'
#!/bin/bash
# Christian Prayer Hours - simplified
# Matins/Lauds, Prime, Terce, Sext, None, Vespers, Compline

hour=$(date +%H)

# Simplified prayer hours
case $hour in
    06|07) echo "🌅 Matins/Lauds - Morning Prayer" ;;
    08|09) echo "📖 Prime - First Hour" ;;
    10|11) echo "🕐 Terce - Third Hour" ;;
    12|13) echo "☀ Sext - Sixth Hour (Midday)" ;;
    14|15) echo "🕒 None - Ninth Hour" ;;
    17|18) echo "🌇 Vespers - Evening Prayer" ;;
    20|21) echo "🌙 Compline - Night Prayer" ;;
    *) echo "🕯 The hour of silence" ;;
esac
EOF
chmod +x ~/.local/bin/christian-hours

# Random verse widget
cat > ~/.local/bin/random-verse << 'EOF'
#!/bin/bash
# Display a random Bible verse

verses=(
    "John 3:16"
    "Psalm 23:1"
    "Philippians 4:13"
    "Romans 8:28"
    "Jeremiah 29:11"
    "Proverbs 3:5-6"
    "Isaiah 40:31"
    "Matthew 11:28"
    "Psalm 46:10"
    "Joshua 1:9"
    "1 Corinthians 13:4-8"
    "Galatians 5:22-23"
    "Ephesians 2:8"
    "2 Timothy 1:7"
    "Hebrews 11:1"
)

random_verse=${verses[$RANDOM % ${#verses[@]}]}

if command -v kjv &>/dev/null; then
    kjv "$random_verse" 2>/dev/null | head -3
elif command -v bib &>/dev/null; then
    bib "$random_verse" 2>/dev/null | head -3
else
    echo "${random_verse} - For God so loved the world..."
fi
EOF
chmod +x ~/.local/bin/random-verse

echo ""
echo "✠ Installation Complete ✠"
echo ""
echo "Installed Tools:"
echo "  Terminal: kjv, bib, daily-verse, bible-cli, grepbible, c-bible, bible_verse"
echo "  GUI: BibleTime, Xiphos, Ezra Bible App"
echo "  Helpers: christian-hours, random-verse"
echo ""
echo "Usage Examples:"
echo "  kjv John 3:16"
echo "  bib Psalm 23"
echo "  bible-cli"
echo "  daily-verse"
echo "  grepbible 'John 3:16' -l en"
echo "  random-verse"
echo ""
