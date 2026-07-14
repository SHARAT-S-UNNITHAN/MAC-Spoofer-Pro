#!/bin/bash
# ╔══════════════════════════════════════════════════════════════╗
# ║                                                              ║
# ║     ███╗   ███╗ █████╗  ██████╗                             ║
# ║     ████╗ ████║██╔══██╗██╔════╝                             ║
# ║     ██╔████╔██║███████║██║                                  ║
# ║     ██║╚██╔╝██║██╔══██║██║                                  ║
# ║     ██║ ╚═╝ ██║██║  ██║╚██████╗                             ║
# ║     ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝                             ║
# ║                                                              ║
# ║     ███████╗██████╗  ██████╗  ██████╗ ███████╗███████╗██████╗║
# ║     ██╔════╝██╔══██╗██╔═══██╗██╔═══██╗██╔════╝██╔════╝██╔══██║
# ║     ███████╗██████╔╝██║   ██║██║   ██║█████╗  █████╗  ██████╔╝║
# ║     ╚════██║██╔═══╝ ██║   ██║██║   ██║██╔══╝  ██╔══╝  ██╔══██║║
# ║     ███████║██║     ╚██████╔╝╚██████╔╝██║     ███████╗██║  ██║║
# ║     ╚══════╝╚═╝      ╚═════╝  ╚═════╝ ╚═╝     ╚══════╝╚═╝  ╚═╝║
# ║                                                              ║
# ║              Created By: Sharat S Unnithan                   ║
# ║                                                              ║
# ╚══════════════════════════════════════════════════════════════╝

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
BOLD='\033[1m'
DIM='\033[2m'
BLINK='\033[5m'
NC='\033[0m'

[[ $EUID -ne 0 ]] && { echo -e "${RED}Run with: sudo $0${NC}"; exit 1; }

# Install deps
command -v macchanger &>/dev/null || { apt update -qq && apt install -y macchanger; }
command -v zenity &>/dev/null || apt install -y zenity

# ASCII Art Banner
show_banner() {
    clear
    echo -e "${RED}${BOLD}"
    echo "╔══════════════════════════════════════════════════════════╗"
    echo "║                                                          ║"
    echo "║     ███╗   ███╗ █████╗  ██████╗                         ║"
    echo "║     ████╗ ████║██╔══██╗██╔════╝                         ║"
    echo "║     ██╔████╔██║███████║██║                              ║"
    echo "║     ██║╚██╔╝██║██╔══██║██║                              ║"
    echo "║     ██║ ╚═╝ ██║██║  ██║╚██████╗                         ║"
    echo "║     ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝                         ║"
    echo "║                                                          ║"
    echo "║     ███████╗██████╗  ██████╗  ██████╗ ███████╗██████╗    ║"
    echo "║     ██╔════╝██╔══██╗██╔═══██╗██╔═══██╗██╔════╝██╔══██╗   ║"
    echo "║     ███████╗██████╔╝██║   ██║██║   ██║█████╗  ██████╔╝   ║"
    echo "║     ╚════██║██╔═══╝ ██║   ██║██║   ██║██╔══╝  ██╔══██╗   ║"
    echo "║     ███████║██║     ╚██████╔╝╚██████╔╝██║     ██║  ██║   ║"
    echo "║     ╚══════╝╚═╝      ╚═════╝  ╚═════╝ ╚═╝     ╚═╝  ╚═╝   ║"
    echo "║                                                          ║"
    echo "║            Created By: Sharat S Unnithan                 ║"
    echo "║                                                          ║"
    echo "╚══════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Animated spinner
spinner() {
    local pid=$1
    local spin='|/-\'
    local i=0
    while kill -0 $pid 2>/dev/null; do
        printf "\r  ${CYAN}[%c]${NC} Working..." "${spin:i++%4:1}"
        sleep 0.1
    done
    printf "\r  ${GREEN}[✓]${NC} Done!           \n"
}

# Show current MACs with style
show_macs() {
    echo -e "\n${CYAN}${BOLD}╔════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}${BOLD}║         CURRENT MAC ADDRESSES             ║${NC}"
    echo -e "${CYAN}${BOLD}╚════════════════════════════════════════════╝${NC}\n"
    
    for iface in $(ip link show | grep -E "^[0-9]+:" | awk '{print $2}' | sed 's/:$//' | grep -v lo); do
        mac=$(ip link show "$iface" | grep "ether" | awk '{print $2}')
        vendor=$(macchanger -l 2>/dev/null | grep -i "${mac:0:8}" | head -1 | awk '{$1=""; print $0}' | xargs)
        [[ -z "$vendor" ]] && vendor="Unknown"
        
        echo -e "  ${YELLOW}${BOLD}$iface${NC}"
        echo -e "  ${DIM}├─ MAC:${NC}    ${WHITE}$mac${NC}"
        echo -e "  ${DIM}└─ Vendor:${NC} ${DIM}$vendor${NC}\n"
    done
    echo -e "${DIM}────────────────────────────────────────────${NC}"
}

# TUI Mode - Full terminal UI
tui_mode() {
    while true; do
        show_banner
        show_macs
        
        echo -e "\n${CYAN}${BOLD}╔════════════════════════════════════════════╗${NC}"
        echo -e "${CYAN}${BOLD}║              SPOOF OPTIONS                ║${NC}"
        echo -e "${CYAN}${BOLD}╚════════════════════════════════════════════╝${NC}\n"
        
        echo -e "  ${GREEN}1${NC}) 🎲 Random MAC"
        echo -e "  ${GREEN}2${NC}) ✏️  Custom MAC"
        echo -e "  ${GREEN}3${NC}) 🏢 Same Vendor MAC"
        echo -e "  ${GREEN}4${NC}) 🍎 Specific Vendor (Apple, Intel, etc)"
        echo -e "  ${GREEN}5${NC}) 🔄 Spoof ALL Interfaces"
        echo -e "  ${GREEN}6${NC}) ♻️  Reset to Original"
        echo -e "  ${GREEN}7${NC}) 💾 Save Current MACs"
        echo -e "  ${GREEN}8${NC}) 📂 Restore from Backup"
        echo -e "  ${RED}9${NC}) 🚪 Exit"
        
        echo -ne "\n${CYAN}${BOLD}>>> ${NC}"
        read choice
        
        case $choice in
            1|2|3|4|6)
                echo -ne "\n${YELLOW}Interface (eth0/wlan0): ${NC}"
                read iface
                [[ -z "$iface" ]] && continue
                
                ip link set "$iface" down &
                spinner $!
                
                case $choice in
                    1) macchanger -r "$iface" 2>/dev/null ;;
                    2) 
                        echo -ne "${YELLOW}MAC (xx:xx:xx:xx:xx:xx): ${NC}"
                        read mac
                        macchanger -m "$mac" "$iface" 2>/dev/null
                        ;;
                    3) macchanger -a "$iface" 2>/dev/null ;;
                    4)
                        echo -ne "${YELLOW}Vendor name (Apple, Samsung): ${NC}"
                        read vendor
                        oui=$(macchanger -l 2>/dev/null | grep -i "$vendor" | shuf -n 1 | awk '{print $3}')
                        nic=$(printf '%02x:%02x:%02x' $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))
                        macchanger -m "$oui:$nic" "$iface" 2>/dev/null
                        ;;
                    6) macchanger -p "$iface" 2>/dev/null ;;
                esac
                
                ip link set "$iface" up
                echo -e "\n${GREEN}${BOLD}[✓] MAC Changed Successfully!${NC}"
                sleep 1
                ;;
            5)
                for iface in $(ip link show | grep -E "^[0-9]+:" | awk '{print $2}' | sed 's/:$//' | grep -v lo); do
                    echo -e "${YELLOW}Spoofing $iface...${NC}"
                    ip link set "$iface" down
                    macchanger -r "$iface" 2>/dev/null
                    ip link set "$iface" up
                done
                echo -e "\n${GREEN}${BOLD}[✓] All interfaces spoofed!${NC}"
                sleep 1
                ;;
            7)
                file="$HOME/.mac-backup-$(date +%Y%m%d-%H%M%S)"
                for iface in $(ip link show | grep -E "^[0-9]+:" | awk '{print $2}' | sed 's/:$//' | grep -v lo); do
                    mac=$(ip link show "$iface" | grep "ether" | awk '{print $2}')
                    echo "$iface=$mac" >> "$file"
                done
                echo -e "\n${GREEN}${BOLD}[✓] Saved to $file${NC}"
                sleep 1
                ;;
            8)
                echo -e "\n${YELLOW}Available backups:${NC}"
                ls -1 ~/.mac-backup-* 2>/dev/null || { echo "None found!"; sleep 1; continue; }
                echo -ne "${CYAN}File: ${NC}"
                read file
                [[ -f "$file" ]] && while IFS='=' read -r iface mac; do
                    ip link set "$iface" down
                    macchanger -m "$mac" "$iface" 2>/dev/null
                    ip link set "$iface" up
                done < "$file"
                echo -e "\n${GREEN}${BOLD}[✓] Restored!${NC}"
                sleep 1
                ;;
            9) 
                echo -e "\n${GREEN}Stay Anonymous! 👻${NC}\n"
                exit 0
                ;;
        esac
    done
}

# GUI Mode
gui_mode() {
    while true; do
        INTERFACES=$(ip link show | grep -E "^[0-9]+:" | awk '{print $2}' | sed 's/:$//' | grep -v lo | tr '\n' ' ')
        
        IFACE=$(zenity --list --title="🎭 MAC Spoofer Pro" \
            --text="<b><big>MAC Spoofer Pro</big></b>\n\nCreated By: Sharat S Unnithan\n\nSelect Network Interface:" \
            --column="Interface" $INTERFACES \
            --width=500 --height=400 2>/dev/null)
        
        [[ -z "$IFACE" ]] && break
        
        CURRENT_MAC=$(ip link show "$IFACE" | grep "ether" | awk '{print $2}')
        
        ACTION=$(zenity --list --title="MAC Spoofer Pro - $IFACE" \
            --text="<b>Interface:</b> $IFACE\n<b>Current MAC:</b> $CURRENT_MAC\n\nChoose Action:" \
            --column="Action" --column="Description" \
            "🎲 Random" "Generate random MAC address" \
            "✏️ Custom" "Enter your own MAC address" \
            "🏢 Same Vendor" "Keep same manufacturer" \
            "🍎 Specific Vendor" "Choose Apple, Intel, Samsung..." \
            "♻️ Reset" "Restore original MAC" \
            --width=500 --height=400 2>/dev/null)
        
        case "$ACTION" in
            "🎲 Random")
                ip link set "$IFACE" down
                macchanger -r "$IFACE" 2>/dev/null
                ip link set "$IFACE" up
                ;;
            "✏️ Custom")
                CUSTOM=$(zenity --entry --title="Custom MAC" \
                    --text="Enter MAC address:" \
                    --entry-text="00:11:22:33:44:55" \
                    --width=400 2>/dev/null)
                [[ -n "$CUSTOM" ]] && {
                    ip link set "$IFACE" down
                    macchanger -m "$CUSTOM" "$IFACE" 2>/dev/null
                    ip link set "$IFACE" up
                }
                ;;
            "🏢 Same Vendor")
                ip link set "$IFACE" down
                macchanger -a "$IFACE" 2>/dev/null
                ip link set "$IFACE" up
                ;;
            "🍎 Specific Vendor")
                VENDOR=$(zenity --entry --title="Vendor MAC" \
                    --text="Enter vendor name:" \
                    --entry-text="Apple" \
                    --width=400 2>/dev/null)
                [[ -n "$VENDOR" ]] && {
                    oui=$(macchanger -l 2>/dev/null | grep -i "$VENDOR" | shuf -n 1 | awk '{print $3}')
                    nic=$(printf '%02x:%02x:%02x' $((RANDOM%256)) $((RANDOM%256)) $((RANDOM%256)))
                    ip link set "$IFACE" down
                    macchanger -m "$oui:$nic" "$IFACE" 2>/dev/null
                    ip link set "$IFACE" up
                }
                ;;
            "♻️ Reset")
                ip link set "$IFACE" down
                macchanger -p "$IFACE" 2>/dev/null
                ip link set "$IFACE" up
                ;;
        esac
        
        NEW_MAC=$(ip link show "$IFACE" | grep "ether" | awk '{print $2}')
        zenity --info --title="MAC Spoofer Pro" \
            --text="<b>MAC Changed Successfully!</b>\n\n<b>Old:</b> $CURRENT_MAC\n<b>New:</b> $NEW_MAC" \
            --width=400 2>/dev/null
    done
}

# Mode selection
if [[ "$1" == "--gui" ]] || [[ "$1" == "-g" ]]; then
    gui_mode
else
    tui_mode
fi
