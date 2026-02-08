{ pkgs ? import <nixpkgs> {} }:

let
  pname = "ely-prism-launcher";
  version = "10.0.2"; # Asegúrate de que esta versión coincida con el tag de GitHub

  src = pkgs.fetchurl {
    url = "https://github.com/ElyPrismLauncher/ElyPrismLauncher/releases/download/${version}/ElyPrismLauncher-Linux-x86_64.AppImage";
    hash = "sha256-EW9qHsymbWIUNalH0ExY0KSwsQ7shzlFr5Kq2qFZCHk=";
  };

  iconSrc = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/ElyPrismLauncher/ElyPrismLauncher/refs/heads/develop/program_info/io.github.elyprismlauncher.ElyPrismLauncher_256.png";
    hash = "sha256-0vAZFrK10FJEIxMDFwnZSXLd819LaiV6wg2BD8hAvfQ=";
  };

  javaRuntime = pkgs.jdk21;

in pkgs.appimageTools.wrapType2 {
  inherit pname version src;

extraPkgs = pkgs: with pkgs; [
    jdk21
    wayland
    libxkbcommon
    libGL
    vulkan-loader
    zlib
    stdenv.cc.cc.lib
    fuse
    libpulseaudio
    makeWrapper
    xdg-utils
  ];

  # Variables de entorno para forzar Wayland si es posible
extraInstallCommands = ''
    source "${pkgs.makeWrapper}/nix-support/setup-hook"

    # 1. Envolver para Wayland
    wrapProgram $out/bin/${pname} \
      --set QT_QPA_PLATFORM "wayland;xcb" \
      --set SDL_VIDEODRIVER "wayland" \
      --set _JAVA_AWT_WM_NONREPARENTING 1

    # 2. Instalar el icono en el sistema
    mkdir -p $out/share/icons/hicolor/scalable/apps
    cp ${iconSrc} $out/share/icons/hicolor/scalable/apps/elyprism.svg

    # 3. Crear el acceso directo usando el nuevo icono
    mkdir -p $out/share/applications
    cat > $out/share/applications/${pname}.desktop << EOF
    [Desktop Entry]
    Name=Ely Prism Launcher
    Comment=Minecraft Launcher (Ely.by version)
    Exec=$out/bin/${pname} %U
    Terminal=false
    Type=Application
    Icon=elyprism
    Categories=Game;Network;
    EOF
  '';
}
