{ pkgs, ... }:
let
  wallpapers = "${pkgs.assets}/share/assets/wallpapers";
  wallpaper = "${pkgs.assets}/share/assets/wallpapers/1.jpg";
in
{
  systemd.user.services.waypaper = {
    Unit = {
      Description = "waypaper service";
      After = [ "graphical-session.target" ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = "${pkgs.waypaper}/bin/waypaper --restore --folder ${wallpapers} --backend mpvpaper";
      Restart = "on-failure";
      RestartSec = "5s";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}
