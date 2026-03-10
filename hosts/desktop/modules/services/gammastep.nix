{pkgs, lib, config, ...}:
{
    systemd.timers."gammastep-on" = {
    wantedBy = [ "timers.target" ];
        timerConfig = {
        OnCalendar="*-*-* 19:00:00";
        Persistent = true;
        Unit = "gammastep-on.service";
        };
    };

    systemd.services."gammastep-on" = {
        script = ''
            set -eu
            pkill gammastep
            ${pkgs.gammastep}/bin/gammastep -m wayland -O 2500K
        '';
        serviceConfig = {
            Type = "oneshot";
        };
    };

    systemd.timers."gammastep-off" = {
    wantedBy = [ "timers.target" ];
        timerConfig = {
        OnCalendar="*-*-* 6:00:00";
        Persistent = true;
        Unit = "gammastep-off.service";
        };
    };

    systemd.services."gammastep-off" = {
        script = ''
            set -eu
            pkill gammastep
        '';
        serviceConfig = {
            Type = "oneshot";
        };
    };
}
