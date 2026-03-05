{
  services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        { 
          timeout = 600;
          on-timeout = "hyprlock";
        }
        { 
          timeout = 900;
          on-timeout = "hyprctl dispatch dpms off";
          on-resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
