{ pkgs, ... }:
{
  services.swayidle =
    let
      lock = "${pkgs.swaylock}/bin/swaylock --daemonize";
      display = status: "${pkgs.niri}/bin/niri msg action power-${status}-monitors";
    in
    {
      enable = true;
      events = [
        {
          event = "before-sleep";
          command = "${pkgs.procps}/bin/pkill -STOP mpvpaper; ${pkgs.systemd}/bin/systemctl --user stop gammastep;";
        }
        {
          event = "unlock";
          command = "${pkgs.procps}/bin/pkill -CONT mpvpaper; ${pkgs.systemd}/bin/systemctl --user start gammastep";
        }
        {
          event = "after-resume";
          command = "${pkgs.procps}/bin/pkill -CONT mpvpaper";
        }
        {
          event = "lock";
          command = "${pkgs.procps}/bin/pkill -STOP mpvpaper";
        }
      ];

      timeouts = [
        {
          timeout = 600; # in seconds
          command = "${pkgs.libnotify}/bin/notify-send 'Locking in 5 seconds' -t 5000";
        }
        {
          timeout = 595;
          command = lock;
        }
        {
          timeout = 1200;
          command = display "off";
          resumeCommand = display "on";
        }
      ];
    };
}
