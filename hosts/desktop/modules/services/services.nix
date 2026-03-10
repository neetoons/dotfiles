{
    imports = [
        ./neetoons-bot.nix
        ./vscbot.nix
        ./yt-dlp.nix
        #./jellyfin/default.nix
        ./xwayland-satellite.nix
        ./sorter.nix
        ./clean-cache.nix
    ];
    services.flatpak.enable = true;
}
