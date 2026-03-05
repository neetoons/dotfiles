{ pkgs ? import <nixpkgs> {}, }:
pkgs.buildNpmPackage rec {
  name = "discord-desktop-mobile";
  src = pkgs.fetchFromGitHub {
    owner = "neetoons";
    repo = "discord-desktop-mobile";
    rev = "1.3.0";
    hash = "sha256-IMyb7q4CPBMNTZhisdrY2BM/QAoLE4NdMR+fvGZb5N4=";
  };

  npmDepsHash = "sha256-hPAUqObi+GQkyXc6mX9bK/WcGB0QFf0q3EN93+4Q1OE=";

  dontNpmBuild = true;
  nativeBuildInputs = [
    pkgs.electron
  ];

  installPhase = ''
    mkdir -p $out/lib/node_modules/${name} 
    cp -R . $out/lib/node_modules/${name}

    makeWrapper ${pkgs.electron}/bin/electron $out/bin/${name} \
      --add-flags $out/lib/node_modules/${name}/main.js

    mkdir -p $out/share/applications
    cat > $out/share/applications/${name}.desktop << EOF
    [Desktop Entry]
    Name=Discord Mobile
    Comment=discord app
    Exec=$out/bin/${name} %U
    Terminal=false
    Type=Application
    Icon=Discord
    Categories=Utility;
    EOF
  '';

  env = {
    ELECTRON_SKIP_BINARY_DOWNLOAD = 1;
  };
    
}
