{ pkgs, ... }:

{
  xdg.mimeApps = {
    enable = true;

    # Aplicaciones por defecto (lo que se abre con doble clic)
    defaultApplications = {
      # --- Navegación y Web ---
      "text/html" = [ "zen-beta.desktop" ];
      "x-scheme-handler/http" = [ "zen-beta.desktop" ];
      "x-scheme-handler/https" = [ "zen-beta.desktop" ];
      "x-scheme-handler/about" = [ "zen-beta.desktop" ]; # Mejorado: Zen en vez de Brave
      "x-scheme-handler/unknown" = [ "zen-beta.desktop" ];
      "application/pdf" = [ "zen-beta.desktop" ];
      "image/webp" = [ "swayimg.desktop" ];

      # --- Desarrollo y Texto ---
      "text/plain" = [ "nvim.desktop" ];
      "application/json" = [ "nvim.desktop" ];
      "text/x-csrc" = [ "nvim.desktop" ];
      "application/x-wine-extension-ini" = [ "nvim.desktop" ];
      "application/x-wine-extension-pwn" = [ "nvim.desktop" ]; # Para tu toolchain de Pawn
      "application/x-desktop" = [ "nvim.desktop" ];

      # --- Archivos y Sistema ---
      "inode/directory" = [ "thunar.desktop" ];
      "application/x-gnome-saved-search" = [ "thunar.desktop" ];
      "application/x-rar" = [ "org.gnome.FileRoller.desktop" ];
      "application/rar" = [ "org.gnome.FileRoller.desktop" ];
      "application/vnd.rar" = [ "org.gnome.FileRoller.desktop" ];
      "application/x-7z-compressed" = [ "org.gnome.FileRoller.desktop" ];
      "application/zip" = [ "org.gnome.FileRoller.desktop" ];

      # --- Multimedia ---
      "video/mp4" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/quicktime" = [ "mpv.desktop" ];
      "audio/mpeg" = [ "mpv.desktop" ];
      "audio/flac" = [ "org.kde.elisa.desktop" ];
      "image/jpeg" = [ "swayimg.desktop" ];
      "image/png" = [ "swayimg.desktop" ];

      # --- Protocolos Específicos ---
      "x-scheme-handler/discord" = [ "vesktop.desktop" ];
      "x-scheme-handler/tg" = [ "org.telegram.desktop.desktop" ];
      "x-scheme-handler/tonsite" = [ "org.telegram.desktop.desktop" ];
      "x-scheme-handler/gitkraken" = [ "GitKraken.desktop" ];
      "x-scheme-handler/notion" = [ "Notion.desktop" ];
      "x-scheme-handler/mailto" = [ "zen-beta.desktop" ];
    };

    # Asociaciones añadidas (aparecen en el menú "Abrir con...")
    associations.added = {
      "image/png" = [ "gimp.desktop" "pinta.desktop" "satty.desktop" ];
      "image/jpeg" = [ "pinta.desktop" "gimp.desktop" ];
      "video/mp4" = [ "fr.handbrake.gnb.desktop" "zen-beta.desktop" "mpv.desktop" ];
      "video/webm " = [ "fr.handbrake.gnb.desktop" "zen-beta.desktop" "mpv.desktop" ];
      "video/x-matroska" = [ "fr.handbrake.ghb.desktop" "mpv.desktop" ];
      "text/plain" = [ "nvim.desktop" "obsidian.desktop" ];
      "application/json" = [ "nvim.desktop" ];
    };
  };
}
