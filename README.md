# Dotfiles

A comprehensive collection of configuration files and setup scripts for Ubuntu, Arch Linux, Fedora, and macOS systems.

## 🚀 Quick Start

```bash
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles
./install.sh
```

## 📁 Directory Structure

```
.
├── assets/                 # Visual assets and resources
│   ├── fonts/             # Hack Nerd Fonts collection
│   └── themes/            # Themes and backgrounds
│       └── backgrounds/   # Wallpapers and videos
├── config/                # Configuration files
│   ├── applications/      # Application-specific configs
│   │   ├── firefox/      # Firefox customization (userChrome.css)
│   │   └── rofi/         # Rofi launcher configuration
│   ├── desktop/          # Desktop environment configs
│   │   └── kde/          # KDE Plasma shortcuts and settings
│   ├── docker/           # Docker configurations
│   └── shell/            # Shell configurations
│       ├── docker_functions.bash  # Docker helper functions
│       └── zsh/          # Zsh configuration
├── os/                    # OS-specific installation scripts
│   ├── arch/             # Arch Linux scripts & configs
│   │   ├── install.sh    # Base system setup
│   │   ├── kde_install.sh # KDE setup
│   │   ├── zshrc         # Arch-specific zsh config (with AUR detection)
│   │   └── p10k.zsh      # Powerlevel10k config
│   ├── fedora/           # Fedora scripts & configs
│   │   ├── install.sh
│   │   ├── kde_install.sh
│   │   ├── zshrc
│   │   └── p10k.zsh
│   ├── mac/              # macOS scripts
│   │   └── install.sh
│   └── ubuntu/           # Ubuntu/Debian scripts & configs
│       ├── install.sh
│       ├── kde_install.sh
│       ├── zshrc
│       └── p10k.zsh
├── scripts/               # Utility scripts
│   ├── hardware/         # Hardware-specific scripts
│   │   └── lg-gram/      # LG Gram laptop audio fixes
│   ├── setup/            # Setup and installation helpers
│   └── utilities/        # General utility scripts
└── install.sh            # Main installation script
```

## 🛠️ Features

### Automated Installation
- **Universal installer**: Detects your OS and runs appropriate setup
- **Modular design**: Choose between base system, KDE Plasma, or both
- **Safe installation**: Backs up existing configurations

### Supported Systems
- **Ubuntu/Debian** (primary)
- **Arch Linux/Manjaro**
- **Fedora**
- **macOS**

### Core Tools Installed
- **Terminal**: Zsh with Oh My Zsh, tmux, Neovim
- **Development**: Git, Docker, build essentials
- **Utilities**: fzf, ripgrep, bat, eza, btop, glow
- **Fonts**: Hack Nerd Font family

### Desktop Environment
- **KDE Plasma** customization
- **Themes**: Ant-Dark theme, Papirus icons
- **Gestures**: Touchegg configuration
- **Effects**: Rounded corners, transparency

## 📝 Installation Options

### 1. Full Installation
Installs all tools and configurations:
```bash
./install.sh
# Select option 3 (Both)
```

### 2. Base System Only
Installs terminal tools and development environment:
```bash
./install.sh
# Select option 1 (Base system setup)
```

### 3. KDE Plasma Only
Installs desktop environment customizations:
```bash
./install.sh
# Select option 2 (KDE Plasma setup)
```

### 4. Configuration Files Only
Links dotfiles without installing packages:
```bash
./install.sh
# Select option 4 (Configuration files only)
```

## 🔧 Utility Scripts

### Shell Utilities
- `claude_launcher.sh` - Launch Claude AI in fullscreen Firefox
- `firefox_fix.sh` - Firefox launcher utility
- `ssh_gen.sh` - Interactive SSH key generator
- `drive.sh` - Mount OneDrive using rclone

### Spotify Control
Located in `scripts/utilities/spotify_tools/`:
- Control Spotify playback from command line
- Next/previous track, play/pause, volume control
- Uses MPRIS for Linux desktop integration

### Docker Functions
Source `config/shell/docker_functions.bash` for helpers:
- `dls` - List containers with color coding
- `dils` - List images
- `dsh <container>` - Shell into container
- `dkill <container>` - Stop container
- `drm <container>` - Remove container
- `dcommit <container> <image:tag>` - Commit container

## 🎨 Customization

### OS-Specific Configurations
Each OS has its own zsh configuration with specific features:
- **Arch Linux**: Includes AUR helper detection (yay/paru) and package search
- **Ubuntu**: Docker functions, ROS settings, and apt-specific aliases
- **Fedora**: DNF-specific configurations
- **macOS**: Homebrew paths and macOS-specific settings

The installer automatically links the appropriate configuration based on your OS.

### Firefox
Custom CSS for a clean, minimal interface:
1. Navigate to `about:profiles`
2. Open root directory
3. Create `chrome` folder
4. Copy files from `config/applications/firefox/chrome/`
5. Enable in `about:config`: `toolkit.legacyUserProfileCustomizations.stylesheets`

### KDE Shortcuts
Import keyboard shortcuts:
```bash
# System Settings > Shortcuts > Import Scheme
config/desktop/kde/latest.kksrc
```

### Themes
Wallpapers and backgrounds in `assets/themes/backgrounds/`

## 🔌 Hardware Support

### LG Gram Audio Fix
For LG Gram laptops with audio issues:
```bash
sudo scripts/hardware/lg-gram/necessary-verbs.sh
```

## 📋 Requirements

### General
- Git
- Curl/wget
- sudo access

### Ubuntu/Debian
- apt package manager
- Ubuntu 20.04+ recommended

### Arch Linux
- pacman and yay (AUR helper)
- base-devel group

### Fedora
- dnf package manager
- Development tools group

### macOS
- Homebrew
- Command Line Tools

## 🤝 Contributing

Feel free to submit issues and pull requests. Please follow the existing directory structure and naming conventions.

## 📄 License

This project is open source and available under the MIT License.