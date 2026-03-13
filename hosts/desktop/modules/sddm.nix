{ config, pkgs, ... }:
let
  backgroundPlaceholder = "${pkgs.assets}/share/assets/wallpapers/23.png";
  background = "${pkgs.assets}/share/assets/wallpapers/2.mp4";
  sddm-astronaut = pkgs.stdenv.mkDerivation {
    pname = "sddm-astronaut-theme";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "Keyitdev";
      repo = "sddm-astronaut-theme";
      rev = "master";
      sha256 = "sha256-+94WVxOWfVhIEiVNWwnNBRmN+d1kbZCIF10Gjorea9M=";
    };
    nativeBuildInputs = with pkgs; [
      kdePackages.qttools
      kdePackages.wrapQtAppsHook
    ];
    installPhase = ''
      targetDir="$out/share/sddm/themes/sddm-astronaut-theme"
      mkdir -p "$targetDir"

      cp -rv ./* "$targetDir/"

      mkdir -p $out/share/fonts
      if [ -d "Fonts" ]; then
        cp -rv Fonts/* $out/share/fonts/
      fi

      sed -i 's|ConfigFile=Themes/astronaut.conf|ConfigFile=Themes/astronaut.conf|' "$targetDir/metadata.desktop"
      sed -i 's|Background="Backgrounds/astronaut.png"|Background="${background}"|' "$targetDir/Themes/astronaut.conf"
      sed -i 's|BackgroundPlaceholder=""|BackgroundPlaceholder="${backgroundPlaceholder}"|' "$targetDir/Themes/astronaut.conf"
      sed -i 's|PartialBlur="true"|PartialBlur="false"|' "$targetDir/Themes/astronaut.conf"
    '';
  };
in
{
  services.displayManager = {
    sddm.enable = true;
    sddm.theme = "sddm-astronaut-theme";
    sddm.package = pkgs.kdePackages.sddm;
    sddm.wayland.enable = true;
    defaultSession = "niri";
    sddm.extraPackages = [ pkgs.sddm-astronaut ];
  };

  environment.systemPackages = with pkgs; [
    sddm-astronaut
    kdePackages.qtsvg
    kdePackages.qtbase
    kdePackages.qtvirtualkeyboard
    kdePackages.qtmultimedia
  ];

  fonts.packages = [
    sddm-astronaut
  ];

  services.displayManager.sddm.settings = {
    General = {
      InputMethod = "qtvirtualkeyboard";
    };
  };
}
