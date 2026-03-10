{ pkgs, ... }:

{
  programs.mpv = {
    enable = true;

    profiles = {
      # Bloque para configuración de video estándar
      video = {
        profile-cond = "p[\"current-tracks/video\"] and not p[\"current-tracks/video\"].image";
        profile-restore = "copy-equal";
        taskbar-progress = "yes";
      };

      # Bloque optimizado para visualización de imágenes (Image Viewer mode)
      image = {
        profile-desc = "ModernZ osc Image Viewer mode";
        profile-cond = "p[\"current-tracks/video\"] and p[\"current-tracks/video\"].image and not p[\"current-tracks/video\"].albumart";
        profile-restore = "copy-equal";

        video-recenter = "yes";
        taskbar-progress = "no";
        stop-screensaver = "no";
        prefetch-playlist = "yes";
        video-aspect-override = "no";
        image-display-duration = "inf";

        # Uso de comillas escapadas para las variables de mpv
        title = "\${media-title} [\${?width:\${width}x\${height}}]";

        # Opciones específicas para el script ModernZ
        script-opts-append = [
          "modernz-fade_alpha=50"
          "modernz-show_window_title=yes"
          "modernz-bottomhover_zone=50"
          "modernz-window_title=\${media-title} [\${?width:\${width}x\${height}}]"
        ];
      };
    };
    scripts = with pkgs.mpvScripts; [
        modernz
        thumbfast
    ];
  };
}
