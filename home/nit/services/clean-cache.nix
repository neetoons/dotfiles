{ pkgs, config, ... }: {
  systemd.user.services.clean-cache = {
    Unit = {
      Description = "Clean Spotify cache storage";
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "clean-cache" ''
        CACHE_DIR="${config.home.homeDirectory}/.cache/spotify/Storage"

        echo "Iniciando la limpieza de la caché de Spotify en: $CACHE_DIR"
        if [ -d "$CACHE_DIR" ]; then
          ${pkgs.findutils}/bin/find "$CACHE_DIR" -mindepth 1 -delete
          echo "Limpieza completada con éxito."
        else
          echo "Aviso: El directorio $CACHE_DIR no existe."
        fi
      ''}";
    };
  };

  systemd.user.timers.clean-cache = {
    Unit.Description = "Timer to clean Spotify cache daily";
    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
