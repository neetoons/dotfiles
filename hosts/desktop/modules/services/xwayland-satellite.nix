{ pkgs, ... }:

{
  environment.systemPackages = [pkgs.xwayland-satellite];
  systemd.user.services.xwayland-satellite = {
    enable = true;
    description = "Xwayland-satellite";
    after = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];

    serviceConfig = {
       User = "nit";
       Group = "users";
       ExecStart = ''${pkgs.xwayland-satellite}/bin/xwayland-satellite'';
       Restart = "on-failure";
       Environment = "PATH=${pkgs.xwayland-satellite}/bin";
       RestartSec = 3;
    };
  };
}
