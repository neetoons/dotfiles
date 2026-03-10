{config, pkgs, lib, ...}:
{
  services.jellyfin = {
    enable = true;
    user="nit";
    openFirewall = true;
  };
  environment.systemPackages = [
    pkgs.jellyfin
    pkgs.jellyfin-web
    pkgs.jellyfin-ffmpeg
  ];
}
