{ pkgs, ... }:
{
  systemd.user.services.pulseeffects = {
    Unit = {
      Description = "pulse effects EQ";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.pulseeffects-legacy}/bin/pulseeffects";
      Restart = "on-failure";
      RestartSec = "5s";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
