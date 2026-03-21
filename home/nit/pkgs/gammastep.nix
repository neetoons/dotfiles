{ pkgs, ... }:
{
  services.gammastep = {
    enable = true;
    provider = "manual";
    latitude = 10.48;
    longitude = -66.90;

    temperature = {
      day = 6500;
      night = 2500;
    };

    settings = {
      general = {
        fade = 1;
        brightness-day = 1.0;
        brightness-night = 0.8;
        gamma = 0.9;
      };
    };
  };
}
