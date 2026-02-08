{
	imports = [
    #./pocketbase/default.nix
    ./neetoons-bot/default.nix
    ./vscbot/default.nix
    ./yt-dlp/default.nix
    #./jellyfin/default.nix
    ./sorter/default.nix
    ./clean-cache/default.nix
    ./vsftpd/default.nix
	];


	services.flatpak.enable = true;
}
