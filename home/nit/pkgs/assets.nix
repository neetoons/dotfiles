{ stdenv, fetchFromGitHub }:

stdenv.mkDerivation rec {
  pname = "dotfiles-assets";
  version = "1.0";

  src = fetchFromGitHub {
    owner = "neetoons";
    repo = "dotfiles";
    rev = "assets";
    sha256 = "sha256-RZ/35WzFDEy4Sk7nSnUoU2Bx16w4N4bHLZFxnErtvt8=";
  };

  installPhase = ''
    mkdir -p $out/share/assets/
    cp -r * $out/share/assets/
  '';
}
