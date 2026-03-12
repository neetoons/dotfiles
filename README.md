# ❄️ Nit's NixOS Configuration

A personal, highly customized NixOS configuration built with **Flakes** and **Home Manager**, featuring a modern Wayland-based desktop environment centered around the **Niri** scroll-stacking window manager.

## 🎨 Aesthetic & Desktop Environment

*   **Window Manager:** [Niri](https://github.com/YaLTeR/niri) - A scroll-stacking tiling Wayland compositor.
*   **Bar & Widgets:** [Eww](https://github.com/elkowar/eww) (ElKowars wacky widgets) with custom status scripts.
*   **Theming:** [Stylix](https://github.com/danth/stylix) using the **Catppuccin Mocha** palette.
*   **Icons:** Papirus (Pink variant).
*   **Cursor:** Custom ManhattanCafe theme.
*   **Lockscreen:** Hyprlock.
*   **Wallpaper Management:** Waypaper.

## 🚀 Key Features

*   **NixOS 25.11 (Unstable/Rolling):** Staying on the cutting edge.
*   **Optimized Kernel:** Uses the CachyOS kernel for improved responsiveness.
*   **Modular Design:** Clean separation between system-wide (`hosts/`) and user-specific (`home/`) configurations.
*   **Gaming Ready:** Steam, Lutris, Heroic, and MangoHud pre-configured. Includes a custom Tibia setup.
*   **Development Stack:** Pre-configured with Neovim, Fish shell, Node.js (Latest), Python, and various CLI tools (Yazi, Fzf, Btop).
*   **Creative Suite:** OBS Studio, Kdenlive, GIMP, Audacity, and LMMS.
*   **Productivity:** Obsidian for notes, Zen Browser for web, and Thunderbird for mail.

## 📂 Repository Structure

```text
.
├── flake.nix               # Entry point for the configuration
├── hosts/                  # System-wide configurations
│   └── desktop/            # Configuration for the 'nixos' host
│       ├── configuration.nix
│       └── modules/        # Reusable system modules (audio, networking, etc.)
├── home/                   # Home Manager configurations
│   └── nit/                # User 'nit' configuration
│       ├── home.nix        # Main home entry point
│       ├── niri/           # Niri WM settings & keybinds
│       └── pkgs/           # App-specific configs (Alacritty, Eww, Nvim, etc.)
└── README.md
```

## ⌨️ Key Bindings (Niri)

*   `Mod + X`: Open Alacritty
*   `Mod + S`: Fuzzel (App Launcher)
*   `Mod + E`: Thunar (File Manager)
*   `Mod + Shift + E`: Zen Browser
*   `Mod + Q`: Close Window
*   `Mod + H/J/K/L`: Focus Left/Down/Up/Right
*   `Mod + Space`: Toggle Overview
*   `Print`: Screenshot

## 🛠️ Installation

> [!WARNING]
> This configuration is tailored for specific hardware. Review `hosts/desktop/hardware-configuration.nix` before applying.

1.  **Clone the repository:**
    ```bash
    git clone https://github.com/neetoons/dotfiles.git
    cd dotfiles
    ```

2.  **Apply the configuration:**
    ```bash
    sudo nixos-rebuild switch --flake .#nixos
    ```

## ❄️ Credits

Special thanks to the authors of the following flakes and projects used in this setup:
*   [niri-flake](https://github.com/sodiboo/niri-flake)
*   [stylix](https://github.com/nix-community/stylix)
*   [spicetify-nix](https://github.com/Gerg-L/spicetify-nix)
*   [zen-browser-flake](https://github.com/0xc000022070/zen-browser-flake)
*   [oxicord](https://github.com/linuxmobile/oxicord)
*   [nix-cachyos-kernel](https://github.com/xddxdd/nix-cachyos-kernel)
