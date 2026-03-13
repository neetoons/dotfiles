{ pkgs, lib, config, ... }:
{
  systemd.timers."sorter" = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "minutely";
      Persistent = true;
      Unit = "sorter.service";
    };
  };

  systemd.services."sorter" = {
    script = ''
      cd /home/nit/Downloads
      ${pkgs.bash}/bin/bash $HOME/sorter.sh
    '';
    serviceConfig = {
      Type = "oneshot";
      #User = "nit"; #FIXME
    };
  };
}
