{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "tibia";
  version = "latest";

  src = pkgs.fetchurl {
    url = "https://github.com/neetoons/tibia-nix/releases/download/release/tibia.x64.tar.gz";
    sha256 = "sha256-aKWGJXXjGHlLsZ9jv6TNi3fncomSzFtPnLtwwmeQco4=";
  };

  nativeBuildInputs = with pkgs; [
    autoPatchelfHook
    makeWrapper
    imagemagick
  ];


  dontWrapQtApps = true;
  buildInputs = with pkgs; [
    openssl
    kdePackages.wrapQtAppsHook
    kdePackages.qtwayland
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.wayland
    libGL
    xorg.libX11
    xorg.libXext
    xorg.libXcursor
    xorg.libXinerama
    xorg.libXrender
    xorg.libxcb
    libxcb-wm
    libxcb-image
    libxcb-keysyms
    libxcb-render-util
    libxkbcommon
    dbus
    fontconfig
    freetype
    glib
    zlib
    nss
    nspr
  ];

installPhase = ''
    mkdir -p $out/bin
    mkdir -p $out/opt/tibia
    mkdir -p $out/share/applications
    mkdir -p $out/share/pixmaps

    cp -r . $out/opt/tibia/

    if [ -f $out/opt/tibia/tibia.ico ]; then
      magick $out/opt/tibia/tibia.ico $out/share/pixmaps/tibia.png
    fi

    makeWrapper $out/opt/tibia/Tibia $out/bin/tibia \
      --set QT_QPA_PLATFORM xcb \
      --set QT_XKB_CONFIG_ROOT "${pkgs.xkeyboard_config}/share/X11/xkb" \
      --set QT_QPA_PLATFORM_PLUGIN_PATH "$out/opt/tibia/plugins/platforms" \
      --set QT_PLUGIN_PATH "$out/opt/tibia/plugins" \
      --prefix LD_LIBRARY_PATH : "$out/opt/tibia/lib:${pkgs.lib.makeLibraryPath buildInputs}" \
      --set SSL_CERT_FILE "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt"

    cat <<EOF > $out/share/applications/com.tibia.client.desktop
    [Desktop Entry]
    Type=Application
    Name=Tibia Installer
    Exec=$out/bin/tibia
    Icon=tibia
    Path=$out/opt
    Terminal=false
    Categories=Game;
    StartupWMClass=Tibia
    EOF

    cat <<EOF > $out/share/applications/tibia.desktop
    [Desktop Entry]
    Name=Tibia
    Comment=Online Role Playing Game
    Exec=env LD_LIBRARY_PATH="/home/nit/.local/share/CipSoft GmbH/Tibia/packages/Tibia/bin/lib:/home/nit/.local/share/CipSoft GmbH/Tibia/packages/Tibia/lib:\$NIX_LD_LIBRARY_PATH" "/home/nit/.local/share/CipSoft GmbH/Tibia/packages/Tibia/bin/client"
    Icon=$out/opt/tibia/tibia.ico
    Terminal=false
    Type=Application
    Categories=Game;
    EOF
  '';

  meta = with pkgs.lib; {
    description = "Cliente de Tibia para NixOS";
    homepage = "https://github.com/neetoons/tibia-nix";
    license = licenses.unfree;
    platforms = platforms.linux;
  };
}
