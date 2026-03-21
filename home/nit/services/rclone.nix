{ config, pkgs, ... }:
{
  systemd.user.services.rclone = {
    Unit = {
      Description = "Rclone";
      After = [ "network-online.target" "graphical-session.target" ];
    };

    Service = {
      ExecStartPre = "${pkgs.coreutils}/bin/mkdir -p /home/nit/GoogleDrive";
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount nit: /home/nit/GoogleDrive \
          --vfs-cache-mode writes \
          --dir-cache-time 1h \
          --vfs-cache-max-age 1h
      '';
      ExecStop = "/run/current-system/sw/bin/fusermount -u /home/nit/GoogleDrive";
      Restart = "on-failure";
      RestartSec = "5s";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
