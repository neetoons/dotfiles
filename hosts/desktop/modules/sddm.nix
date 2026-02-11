{ config, pkgs, ... }:

let
  # Definimos la derivación (la receta para construir el paquete) del tema
  sddm-astronaut = pkgs.stdenv.mkDerivation {
    pname = "sddm-astronaut-theme";
    version = "1.0";

    src = pkgs.fetchFromGitHub {
      owner = "Keyitdev";
      repo = "sddm-astronaut-theme";
      rev = "master";
      # Si el hash falla, cámbialo por lib.fakeHash y copia el que te dé el error
      sha256 = "sha256-+94WVxOWfVhIEiVNWwnNBRmN+d1kbZCIF10Gjorea9M=";
    };
    nativeBuildInputs = with pkgs; [
        kdePackages.qttools
        kdePackages.wrapQtAppsHook
    ];
    installPhase = ''
      # Definimos la carpeta de destino siguiendo la estructura de Nix
      targetDir="$out/share/sddm/themes/sddm-astronaut-theme"
      mkdir -p "$targetDir"

      # Copiamos todo el contenido del repo a la carpeta del tema
      cp -rv ./* "$targetDir/"

      # Corregimos las fuentes: las movemos a la carpeta de fuentes global de Nix
      mkdir -p $out/share/fonts
      if [ -d "Fonts" ]; then
        cp -rv Fonts/* $out/share/fonts/
      fi

      # Ajustar el metadata.desktop para que use la variante por defecto correctamente
      # 'sed' es un editor de texto por comandos que usaremos para cambiar la configuración
      #sed -i 's|ConfigFile=Themes/astronaut.conf|ConfigFile=Themes/astronaut.conf|' "$targetDir/metadata.desktop"
      sed -i 's|^ConfigFile=.*|ConfigFile=Themes/pixel_sakura_static.conf|' "$targetDir/metadata.desktop"
    '';
  };
in
{
  # 1. Habilitar SDDM y aplicar el tema
  services.displayManager = {
    sddm.enable = true;
    sddm.theme = "sddm-astronaut-theme";
    # Usamos la versión de SDDM basada en Qt6 para compatibilidad total
    sddm.package = pkgs.kdePackages.sddm;
    sddm.wayland.enable = true;
    defaultSession = "niri";
    sddm.extraPackages = [ pkgs.sddm-astronaut ];
  };

  # 2. Instalar dependencias necesarias en el sistema
  environment.systemPackages = with pkgs; [
    sddm-astronaut # El tema que definimos arriba
    kdePackages.qtsvg
    kdePackages.qtbase
    kdePackages.qtvirtualkeyboard # Teclado virtual que pide el script
    kdePackages.qtmultimedia
  ];

  # 3. Asegurar que NixOS registre las fuentes del tema
  fonts.packages = [
    sddm-astronaut
  ];

  # 4. Configurar el teclado virtual en SDDM (equivalente al .conf.d del script)
  services.displayManager.sddm.settings = {
    General = {
      InputMethod = "qtvirtualkeyboard";
    };
  };
}
