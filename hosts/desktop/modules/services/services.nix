{
  imports = [
    ./neetoons-bot.nix
    ./vscbot.nix
    ./xwayland-satellite.nix
  ];

  services = {
      flatpak.enable = true;
      journald.extraConfig = "SystemMaxUse=500M";
  };
}
