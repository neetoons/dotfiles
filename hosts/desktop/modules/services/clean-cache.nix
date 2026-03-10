{pkgs, lib, config, ...}:
{
    systemd.timers."clean-cache" = {
    wantedBy = [ "timers.target" ];
        timerConfig = {
        OnCalendar="daily";
        Persistent = true;
        Unit = "clean-cache.service";
        };
    };

    systemd.services."clean-cache" = {
        script = ''${pkgs.bash}/bin/bash /home/nit/clean-cache.sh'';
        serviceConfig = {
            Type = "oneshot";
        };
    };
}

