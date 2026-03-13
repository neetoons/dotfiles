{ inputs, config, pkgs, lib, ... }:
let
  wallpapers = "${pkgs.assets}/share/assets/wallpapers";
  wallpaper = "${pkgs.assets}/share/assets/wallpapers/1.jpg";
in
{
  programs.niri = {
    enable = true;
    package = pkgs.niri;
    settings = {
      input = {
        keyboard = {
          xkb = {
            layout = "us";
            variant = "intl";
          };
          numlock = true;
        };
      };

      gestures.hot-corners.enable = false;

      #cursor = {
      #  hide-when-typing = true;
      #  hide-after-inactive-ms = 1000;
      #};

      outputs."eDP-1" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 120.030;
        };
        scale = 2.0;
        position = { x = 1280; y = 0; };
      };

      layout = {
        gaps = 12;
        center-focused-column = "never";
        default-column-width = { proportion = 0.5; };

        preset-column-widths = [
          { proportion = 1.0 / 3.0; }
          { proportion = 1.0 / 2.0; }
          { proportion = 2.0 / 3.0; }
        ];

        focus-ring.enable = false;

        border = {
          width = 1;
          active.color = "#ffffff00";
          inactive.color = "#000000ff"; # Recomiendo 8 dígitos para evitar ambigüedad
        };

        shadow = {
          softness = 7;
          spread = 4;
          offset = { x = 0; y = 5; };
          color = "#00000080";
        };
      };
      spawn-at-startup = [
        { command = [ "sh" "-c" "${pkgs.waypaper}/bin/waypaper --wallpaper ${wallpaper} --folder ${wallpapers}" ]; }
        { command = [ "${pkgs.eww}/bin/eww" "-c" "${config.xdg.configHome}/eww" "open-many" "bar" ]; }
        { command = [ "sh" "-c" "${pkgs.rclone}/bin/rclone" "mount" "nit:" "${config.xdg.configHome}/GoogleDrive" ]; }
        { command = [ "sh" "-c" "wl-paste" "--type" "text" "--watch" "cliphist" "store" ]; }
        { command = [ "${pkgs.pulseeffects-legacy}/bin/pulseeffects" ]; }
      ];

      prefer-no-csd = true;
      screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
      hotkey-overlay.skip-at-startup = true;
      animations = {
        slowdown = 0.3;
      };

      window-rules = [
        {
          matches = [
            { app-id = "steam"; }
            { app-id = "vesktop"; }
            { app-id = "discord"; }
            { app-id = "spotify"; }
            { app-id = "ferdium"; }
            { app-id = "thunar"; }
            { app-id = "zen-beta"; }
          ];
          default-column-width = { proportion = 1.0; };
        }
        {
          matches = [{ app-id = "^org\\.wezfurlong\\.wezterm$"; }];
          default-column-width = { };
        }
        {
          matches = [{ app-id = "zen-beta$"; title = "^Picture-in-Picture$"; }];
          open-floating = true;
        }
        {
          geometry-corner-radius = {
            top-left = 20.0;
            top-right = 20.0;
            bottom-left = 10.0;
            bottom-right = 10.0;
          };
          clip-to-geometry = true;
        }
        {
          matches = [{ is-window-cast-target = true; }];
          focus-ring = {
            active.color = "#f38ba8";
            inactive.color = "#7d0d2d";
          };
          border.inactive.color = "#7d0d2d";
          shadow.color = "#7d0d2d70";
        }
      ];

      binds = {
        # Aplicaciones y Comandos
        "Mod+I".action.spawn-sh = [ "hyprlock" ];
        #Mod+O {spawn-sh "rofi -modi 'emoji:rofimoji' -show emoji"; }
        "Mod+Shift+P".action.spawn-sh = [ "echo '' | fuzzel --dmenu | xargs -I{} xdg-open 'https://thepiratebay.org/search.php?q={}&video=on'" ];
        "Mod+1".action.spawn-sh = [ "niri msg action set-dynamic-cast-window --id $(niri msg --json pick-window | jq .id) &" ];
        "Mod+2".action.spawn-sh = [ "niri msg action set-dynamic-cast-window" ];
        "Mod+3".action.spawn-sh = [ "niri msg action set-dynamic-cast-monitor" ];
        "Mod+Y".action.spawn-sh = [ "echo '' | fuzzel --dmenu | xargs -I{} xdg-open https://www.youtube.com/results?search_query={}" ];
        "Mod+B".action.spawn-sh = [ "xdg-open https://www.youtube.com/feed/history" ];
        "Mod+D".action.spawn-sh = [ "xdg-open ${config.xdg.configHome}/Downloads" ];

        "Mod+Shift+Y".action.spawn-sh = [ "xdg-open https://www.youtube.com/playlist?list=LL" ];

        "Mod+S".action.spawn-sh = [ "fuzzel" ];
        "Mod+E".action.spawn-sh = [ "thunar" ];
        "Mod+Shift+E".action.spawn-sh = [ "zen-beta" ];
        "Mod+X".action.spawn-sh = [ "alacritty" ];
        "Mod+T".action.spawn-sh = [ "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy" ];
        "Mod+KP_Up".action.spawn-sh = [ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+ -l 1.0" ];
        "Mod+KP_Down".action.spawn-sh = [ "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-" ];

        "Mod+Shift+KP_End".action.spawn-sh = [ "mpv '${config.xdg.configHome}/Downloads/5. Audio/fah.ogg'" ];
        "Mod+Shift+KP_Down".action.spawn-sh = [ "mpv '${config.xdg.configHome}/Downloads/5. Audio/stfu.mp3'" ];
        "Mod+Shift+KP_Next".action.spawn-sh = [ "mpv '${config.xdg.configHome}/Downloads/5. Audio/efn.ogg'" ];
        "Mod+Shift+KP_Left".action.spawn-sh = [ "mpv '${config.xdg.configHome}/Downloads/5. Audio/toma mamaguevo.mp3'" ];


        # Navegación y Layout

        "Mod+Space".action.toggle-overview = { };
        "Mod+Q".action.close-window = { };
        "Mod+Left".action.focus-column-left = { };
        "Mod+Right".action.focus-column-right = { };
        "Mod+H".action.focus-column-left = { };
        "Mod+L".action.focus-column-right = { };
        "Mod+J".action.focus-window-or-workspace-down = { };
        "Mod+K".action.focus-window-or-workspace-up = { };
        "Mod+Up".action.focus-window-or-workspace-up = { };
        "Mod+Down".action.focus-window-or-workspace-down = { };
        "Mod+Shift+J".action.move-column-to-workspace-down = { };
        "Mod+Shift+K".action.move-column-to-workspace-up = { };
        "Mod+BracketLeft".action.consume-or-expel-window-left = { };
        "Mod+BracketRight".action.consume-or-expel-window-right = { };

        "Mod+Shift+Minus".action.set-window-height = "-10%";
        "Mod+Shift+Equal".action.set-window-height = "+10%";

        "Mod+Shift+F".action.toggle-window-floating = { };
        "Mod+W".action.toggle-column-tabbed-display = { };
        "Mod+Shift+H".action.move-column-left = { };
        "Mod+Shift+L".action.move-column-right = { };

        "Mod+Shift+Left".action.move-column-left = { };
        "Mod+Shift+Right".action.move-column-right = { };
        "Mod+C".action.center-column = { };

        "Mod+R".action.switch-preset-column-width = { };
        "Mod+Shift+R".action.switch-preset-window-height = { };
        "Mod+Ctrl+R".action.reset-window-height = { };
        "Mod+F".action.maximize-column = { };
        "Mod+M".action.fullscreen-window = { };
        "Mod+C".action.center-column = { };

        # gammastep
        "Mod+Shift+1".action.spawn-sh = [ "pkill gammastep; gammastep -m wayland -O 2500K" ];
        "Mod+Shift+2".action.spawn-sh = [ "pkill gammastep" ];

        "Mod+wheelscrollup".action.focus-column-left = { };
        "Mod+wheelscrolldown".action.focus-column-right = { };

        #"Mod+Shift+wheelscrolldown".action.focus-window-or-workspace-down = { cooldown-ms=150;};
        "Mod+Shift+wheelscrollup".action.focus-column-right = { };
        "Mod+Shift+wheelscrolldown".action.focus-window-or-workspace-down = { };



        # Capturas
        "Mod+P".action.spawn-sh = [ "recorder" ];
        "Print".action.screenshot = { };
        "Mod+Print".action.spawn-sh = [ "mkdir -p ${config.xdg.configHome}/Pictures/screenshots && grim -t png -g \"$(slurp)\" - | satty --filename - -o ~/Pictures/screenshots/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png" ];
        "Mod+Ctrl+Print".action.spawn-sh = [ "mkdir -p ${config.xdg.configHome}/Pictures/screenshots && grim -g \"0,0 1440x900\" - | tee ~/Pictures/screenshots/Screenshot_$(date +%Y-%m-%d_%H-%M-%S).png | wl-copy" ];

        # Utilidades Nix/Web
        "Mod+G".action.spawn-sh = [ "echo '' | fuzzel --dmenu | xargs -I{} xdg-open https://www.google.com/search?q={}" ];
        "Mod+Shift+G".action.spawn-sh = [ "xdg-open https://gemini.google.com" ];
        "Mod+N".action.spawn-sh = [ "echo '' | fuzzel --dmenu | xargs -I{} xdg-open https://search.nixos.org/packages?query={}" ];
        "Mod+Shift+N".action.spawn-sh = [ "echo '' | fuzzel --dmenu | xargs -I{} xdg-open https://mynixos.com/search?q={}" ];

        # Control de Reproducción
        "Mod+KP_Right".action.spawn-sh = [ "playerctl next" ];
        "Mod+KP_Left".action.spawn-sh = [ "playerctl previous" ];
        "Mod+KP_Begin".action.spawn-sh = [ "playerctl play-pause" ];

        "Mod+Shift+Q".action.quit = { };
        "Ctrl+Alt+Delete".action.quit = { };
      };
    };
  };
}
