{ pkgs }:
pkgs.stdenv.mkDerivation rec {
  name = "manhattan-cafe";
  pname = "${name}";
  src = pkgs.assets;
  installPhase = ''
    mkdir -p $out/share/icons/ManhattanCafe
    cp -r ${pkgs.assets}/share/assets/cursors/ManhattanCafe/* $out/share/icons/ManhattanCafe/
  '';
}
