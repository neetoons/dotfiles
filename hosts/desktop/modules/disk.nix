{ pkgs, ...}:
{
    # Bootloader
    boot.loader.grub = {
      enable = true;
      device = "/dev/sda";
      theme = pkgs.catppuccin-grub;
      #theme = pkgs.catppuccin-grub.override {
      #  flavor = "mocha";
      #};
    };

    # Automatic updating
    system.autoUpgrade.enable = true;
    system.autoUpgrade.dates = "weekly";

    # Storage optimization
    nixpkgs.config.allowUnfree = true;
    nix.optimise.automatic = true;
    nix.optimise.dates = [ "04:00" ];
    nix.settings.auto-optimise-store = true;
    nix.gc = {
        automatic = true;
        dates = "daily";
        options = "--delete-older-than 1d";
    };

    nix.extraOptions = ''
    min-free = ${toString (100 * 1024 * 1024)}
    max-free = ${toString (1024 * 1024 * 1024)}
    '';

    # smart
    services.smartd = {
        enable = true;
        devices = [
            {
                device = "/dev/sda";
            }
        ];
    };
    swapDevices = [{
        device = "/swapfile";
        size = 10 * 1024; # 10GB
    }];


  nix.settings.download-buffer-size = 524288000;
}
