{
  config,
  lib,
  pkgs,
  ...
}: let
  tuigreet = "${pkgs.tuigreet}/bin/tuigreet";
  theme = "border=brightblack;text=brightblack;prompt=brightblack;time=brightblack;action=brightblack;button=brightblack;input=brightblack;container=brightblack";
in {
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${tuigreet} --time --remember --remember-session --theme '${theme}' --cmd ${lib.getExe config.programs.niri.package}-session";
        user = "greeter";
      };
    };
  };
  systemd.services.greetd.serviceConfig = {
    Type = "idle";
    StandardInput = "tty";
    StandardOutput = "tty";
    StandardError = "journal"; # Without this errors will spam on screen
    # Without these bootlogs will spam on screen
    TTYReset = true;
    TTYVHangup = true;
    TTYVTDisallocate = true;
  };
}
