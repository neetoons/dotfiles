{
  imports = [
    ./neetoons-bot.nix
    ./vscbot.nix
    ./sorter.nix
    ./clean-cache.nix
  ];
  services.flatpak.enable = true;
}
