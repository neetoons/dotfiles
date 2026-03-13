{ pkgs, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./modules/sddm.nix
    ./modules/wayland.nix
    ./modules/audio.nix
    ./modules/disk.nix
    ./modules/enviroment.nix
    ./modules/fonts.nix
    ./modules/file-manager.nix
    ./modules/networking.nix
    ./modules/services/services.nix
  ];

  services.journald.extraConfig = "SystemMaxUse=500M";
  documentation.man.generateCaches = false;


  users.users.nit.shell = pkgs.fish;

  programs.localsend.enable = true;
  programs.fish.enable = true;
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.nit = {
    isNormalUser = true;
    description = "Nit's Desktop";
    extraGroups = [ "networkmanager" "wheel" "video" "render" ];
  };

  programs.dconf.enable = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nix.gc.automatic = true;
  nix.settings.auto-optimise-store = true;

  time.timeZone = "America/Caracas";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "es_VE.UTF-8";
    LC_IDENTIFICATION = "es_VE.UTF-8";
    LC_MEASUREMENT = "es_VE.UTF-8";
    LC_MONETARY = "es_VE.UTF-8";
    LC_NAME = "es_VE.UTF-8";
    LC_NUMERIC = "es_VE.UTF-8";
    LC_PAPER = "es_VE.UTF-8";
    LC_TELEPHONE = "es_VE.UTF-8";
    LC_TIME = "es_VE.UTF-8";
  };

  system.stateVersion = "24.05";
}
