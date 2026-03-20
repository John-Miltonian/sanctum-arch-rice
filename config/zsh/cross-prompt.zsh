# Sanctum OS - Christian Cross Zsh Prompt
# Features a cross symbol and liturgical colors

# Enable colors
autoload -U colors && colors

# Git info function
function git_info() {
    local branch=$(git symbolic-ref --short HEAD 2>/dev/null)
    if [[ -n $branch ]]; then
        local status_icon=""
        if [[ -n $(git status --porcelain 2>/dev/null) ]]; then
            status_icon=" ✗"
        fi
        echo " %F{243}(${branch}${status_icon})%f"
    fi
}

# Current liturgical season color
function liturgical_color() {
    local month=$(date +%m)
    local day=$(date +%d)
    
    # Simplified liturgical calendar colors
    # Advent (roughly Dec 1-24)
    if [[ $month == "12" && $day -le 24 ]]; then
        echo "%F{135}"  # Purple
    # Christmas (Dec 25 - Jan 6)
    elif [[ ($month == "12" && $day -ge 25) || ($month == "01" && $day -le 6) ]]; then
        echo "%F{230}"  # Gold/White
    # Lent (simplified - 40 days before Easter, roughly Feb-Mar)
    elif [[ $month == "02" || ($month == "03" && $day -le 20) ]]; then
        echo "%F{135}"  # Purple
    # Easter season (simplified)
    elif [[ $month == "04" ]]; then
        echo "%F{230}"  # White/Gold
    # Pentecost (May)
    elif [[ $month == "05" ]]; then
        echo "%F{203}"  # Red
    # Ordinary Time - Green (default)
    else
        echo "%F{107}"  # Green
    fi
}

# Cross prompt construction
function build_prompt() {
    local exit_code=$?
    local cross_color=$(liturgical_color)
    
    # Cross symbol - Orthodox style
    local cross="✠"
    
    # Alternative crosses (uncomment your preference):
    # local cross="✞"    # Outline cross
    # local cross="✝"    # Latin cross
    # local cross="☧"    # Chi Rho
    # local cross="☩"    # Cross with outlines
    # local cross="✟"    # Shadowed cross
    # local cross="♰"    # Curved cross
    # local cross="♱"    # Curved outline cross
    # local cross="✙"    # Heavy cross
    # local cross="✚"    # Medical/plus cross
    
    # User and host
    local user_host="%F{240}%n%f@%F{240}%m%f"
    
    # Directory - gold if in home, gray otherwise
    local dir=""
    if [[ $PWD == $HOME ]]; then
        dir=" %F{220}~%f"
    else
        dir=" %F{250}%~%f"
    fi
    
    # Git info
    local git=$(git_info)
    
    # Exit status indicator
    local exit_indicator=""
    if [[ $exit_code -ne 0 ]]; then
        exit_indicator=" %F{196}✗${exit_code}%f"
    fi
    
    # Build the prompt line 1
    PROMPT="${user_host}${dir}${git}${exit_indicator}
"
    
    # Build the prompt line 2 - the cross
    if [[ $exit_code -eq 0 ]]; then
        PROMPT+="${cross_color}${cross}%f "
    else
        PROMPT+="%F{196}${cross}%f "
    fi
}

# Set the prompt function
precmd_functions+=(build_prompt)

# Right prompt with time and date
RPROMPT="%F{243}%D{%H:%M:%S}%f"

# Continuation prompt
PROMPT2="%F{243}...%f "

# Selection prompt
PROMPT3="%F{220}?%f "

# Spelling prompt
SPROMPT="%F{220}Did you mean: %r? [n,y,a,e]%f "

# Enable prompt substitution
setopt prompt_subst

# Title bar
function set_title() {
    print -Pn "\e]0;%n@%m: %~\a"
}
precmd_functions+=(set_title)

# ASCII Cross for terminal startup (optional)
function welcome_cross() {
    if [[ -z $WELCOME_SHOWN ]]; then
        cat << 'EOF'

         ███████╗ █████╗ ███╗   ██╗ ██████╗████████╗██╗   ██╗███╗   ███╗
         ██╔════╝██╔══██╗████╗  ██║██╔════╝╚══██╔══╝██║   ██║████╗ ████║
         ███████╗███████║██╔██╗ ██║██║        ██║   ██║   ██║██╔████╔██║
         ╚════██║██╔══██║██║╚██╗██║██║        ██║   ██║   ██║██║╚██╔╝██║
         ███████║██║  ██║██║ ╚████║╚██████╗   ██║   ╚██████╔╝██║ ╚═╝ ██║
         ╚══════╝╚═╝  ╚═╝╚═╝  ╚═══╝ ╚═════╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝

EOF
        echo "    %F{220}✠ In nomine Patris, et Filii, et Spiritus Sancti ✠%f"
        echo ""
        export WELCOME_SHOWN=1
    fi
}
# Uncomment to show welcome on terminal start:
# precmd_functions+=(welcome_cross)

# Daily verse on startup (optional)
function verse_greeting() {
    if [[ -z $VERSE_SHOWN ]] && command -v daily-verse &>/dev/null; then
        echo ""
        daily-verse --plain 2>/dev/null | head -1 | xargs -I {} echo "    %F{220}✠ {}%f"
        echo ""
        export VERSE_SHOWN=1
    fi
}
# Uncomment to show daily verse on terminal start:
# precmd_functions+=(verse_greeting)
