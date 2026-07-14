```bash
cd ~/github-scripts

# Abort any rebase in progress
git rebase --abort 2>/dev/null

# Reset completely
rm -rf .git
git init

# Add the script
git add mac-spoofer-pro.sh

# Create DETAILED README
cat > README.md << 'ENDOFFILE'
# 🎭 MAC Spoofer Pro

![Version](https://img.shields.io/badge/version-2.0.0-blue)
![Platform](https://img.shields.io/badge/platform-Linux%20%7C%20Kali-red)
![License](https://img.shields.io/badge/license-MIT-green)
![Bash](https://img.shields.io/badge/Bash-5.0%2B-4EAA25?logo=gnu-bash)

### 🔐 Change Your MAC Address Instantly — Terminal UI + GUI

<p align="center">
  <b>Beautiful ASCII Art Terminal Interface</b> | <b>Zenity GUI Dialogs</b>
</p>

---

## 📖 Table of Contents
- [Features](#-features)
- [Screenshots](#-screenshots)
- [Quick Start](#-quick-start)
- [Usage](#-usage)
- [Installation](#-installation)
- [Modes](#-modes)
- [Examples](#-examples)
- [Requirements](#-requirements)
- [FAQ](#-faq)
- [Author](#-author)

---

## ✨ Features

| Feature | Description |
|---------|-------------|
| 🎲 **Random MAC** | Generate completely random MAC address |
| ✏️ **Custom MAC** | Set your own MAC address manually |
| 🏢 **Same Vendor** | Keep manufacturer, change device ID |
| 🍎 **Specific Vendor** | Spoof as Apple, Intel, Samsung, etc |
| 🔄 **Spoof All** | Change ALL interfaces at once |
| ♻️ **Reset Original** | Restore permanent hardware MAC |
| 💾 **Backup/Restore** | Save current MACs, restore anytime |
| 🎨 **ASCII Art UI** | Beautiful colored terminal interface |
| 🖥️ **GUI Mode** | Graphical mode with Zenity dialogs |
| 🔒 **Root Protected** | Requires sudo for security |

---

## 📸 Screenshots

### Terminal UI (ASCII Art Mode)
```
╔══════════════════════════════════════════════════════════╗
║     ███╗   ███╗ █████╗  ██████╗                         ║
║     ████╗ ████║██╔══██╗██╔════╝                         ║
║     ██╔████╔██║███████║██║                              ║
║     ██║╚██╔╝██║██╔══██║██║                              ║
║     ██║ ╚═╝ ██║██║  ██║╚██████╗                         ║
║     ╚═╝     ╚═╝╚═╝  ╚═╝ ╚═════╝                         ║
║          Created By: Sharat S Unnithan                   ║
╚══════════════════════════════════════════════════════════╝
```

### GUI Mode
Point-and-click interface with dropdown menus and dialog boxes.

---

## 🚀 Quick Start

```bash
# Clone the repo
git clone https://github.com/SHARAT-S-UNNITHAN/MAC-Spoofer-Pro.git
cd MAC-Spoofer-Pro

# Run Terminal UI mode
sudo ./mac-spoofer-pro.sh

# Or run GUI mode
sudo ./mac-spoofer-pro.sh --gui
```

---

## 📝 Usage

### Terminal Mode (Default)
```bash
sudo ./mac-spoofer-pro.sh
```
Navigate with keyboard numbers. Shows beautiful ASCII art banner.

### GUI Mode
```bash
sudo ./mac-spoofer-pro.sh --gui
```
Graphical interface with buttons and dropdowns.

---

## 🔧 Installation

### Dependencies
```bash
# Install required packages
sudo apt update
sudo apt install macchanger zenity
```

### Verify Installation
```bash
macchanger --version
zenity --version
```

---

## 🎯 Modes

### 1. Terminal UI Mode
```
Options:
  1) 🎲 Random MAC
  2) ✏️  Custom MAC
  3) 🏢 Same Vendor MAC
  4) 🍎 Specific Vendor (Apple, Intel, etc)
  5) 🔄 Spoof ALL Interfaces
  6) ♻️  Reset to Original
  7) 💾 Save Current MACs
  8) 📂 Restore from Backup
  9) 🚪 Exit
```

### 2. GUI Mode
Click-based interface with:
- Interface selector dropdown
- Action buttons (Random, Custom, Vendor, Reset)
- Success/confirmation dialogs

---

## 💡 Examples

### Random MAC on wlan0
```bash
sudo ./mac-spoofer-pro.sh
# Select interface: wlan0
# Select option: 1
```

### Apple MAC on eth0 (GUI)
```bash
sudo ./mac-spoofer-pro.sh --gui
# Select eth0 → Specific Vendor → Type "Apple"
```

### Spoof ALL interfaces at once
```bash
sudo ./mac-spoofer-pro.sh
# Select option: 5
```
[Terminal Mode](screenshots/terminal-mode.png)
---

## 📋 Requirements

| Package | Version | Purpose |
|---------|---------|---------|
| `macchanger` | Any | MAC spoofing |
| `zenity` | 3.0+ | GUI dialogs |
| `bash` | 4.0+ | Shell |
| `sudo` | Any | Root privileges |

---

## ❓ FAQ

**Q: Will this break my internet?**
A: No. MAC change is temporary. Reboot restores original.

**Q: Is this legal?**
A: Yes, for privacy on YOUR devices. Don't use on networks you don't own.

**Q: Does it survive reboot?**
A: No, unless you use the save/restore feature.

**Q: Works on WiFi and Ethernet?**
A: Yes, supports all network interfaces.

**Q: Kali Linux compatible?**
A: Yes, tested on Kali, Ubuntu, Debian.

---

## 🛡️ Security Note

This tool is for:
- ✅ Privacy protection
- ✅ Security testing (on YOUR devices)
- ✅ Educational purposes
- ❌ NOT for illegal activities

---

## 📂 File Structure
```
MAC-Spoofer-Pro/
├── mac-spoofer-pro.sh    # Main script
├── README.md             # Documentation
└── LICENSE               # MIT License
```

---

## 🌟 Star History

If this helped you, please ⭐ the repo!

---

## 👤 Author

**Sharat S Unnithan**

[![GitHub](https://img.shields.io/badge/GitHub-SHARAT--S--UNNITHAN-black?logo=github)](https://github.com/SHARAT-S-UNNITHAN)
[![LinkedIn](https://img.shields.io/badge/LinkedIn-Sharat%20S%20Unnithan-blue?logo=linkedin)](https://linkedin.com/in/sharat-s-unnithan-b363852a7)

---

## 📄 License

MIT License • Copyright © 2024 Sharat S Unnithan

See [LICENSE](LICENSE) for full details.

---

<p align="center">
  <b>Made with ❤️ in Kerala, India</b>
</p>
ENDOFFILE

# Create proper LICENSE
cat > LICENSE << 'ENDOFFILE'
MIT License

Copyright (c) 2024 Sharat S Unnithan

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

