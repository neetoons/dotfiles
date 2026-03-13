{ pkgs, lib, config, ... }:
{

  systemd.services."sorter" = {
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExectStart = ''
        cd /home/nit/Documents
        ${pkgs.bash}/bin/bash oxicord_nit.sh &
      '';
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
