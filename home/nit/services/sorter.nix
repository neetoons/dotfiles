{ pkgs, config, ... }: {
  systemd.user.services.sorter = {
    Unit = {
      Description = "sort download files";
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "sorter" ''
        TARGET_DIR="${config.home.homeDirectory}/Downloads"
        if [ -d "$TARGET_DIR" ]; then
          cd "$TARGET_DIR"
          ${pkgs.sorter}/bin/sorter
        else
          echo "Error: No se encontró la carpeta de Descargas."
          exit 1
        fi
      ''}";
    };
  };

  systemd.user.timers.sorter = {
    Unit.Description = "sort download files";
    Timer = {
      OnCalendar = "*:0/5";
      Persistent = true;
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
