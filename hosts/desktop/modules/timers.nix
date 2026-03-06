{pkgs, pkgs-unstable, ...}:
{
    systemd.timers."gammastep" = {
    wantedBy = [ "timers.target" ];
        timerConfig = {
            OnCalendar = "-*-*-* 19:00:00";
            Persistent = true;
            OnBootSec = "5m";
            OnUnitActiveSec = "5m";
            Unit = "gammastep.service";
        };
    };

    systemd.services."gammastep" = {
        script = ''
            set -eu
            export $XDG_RUNTIME_DIR /run/user/1000
            ${pkgs.gammastep}/bin/gammastep -m wayland -O 2500K
        '';
        serviceConfig = {
            Type = "oneshot";
            User = "root";
        };
    };
}
