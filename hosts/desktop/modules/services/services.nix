{
  imports = [
    ./neetoons-bot.nix
    ./vscbot.nix
    ./sorter.nix
    ./clean-cache.nix
    ./xwayland-satellite.nix

  ];
  services.flatpak.enable = true;
}
