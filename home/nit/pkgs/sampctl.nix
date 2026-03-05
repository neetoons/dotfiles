{ pkgs }:

let
  version = "1.12.0";
  arch = if pkgs.stdenv.isx86_64 then "amd64" else "386";
  sha256_amd64 = "sha256-Jbuwog6YlQ58xFPVTScnDkmRPt66l1eMc0fhfusiNx8=";
  sha256_386 = "sha256-HiHX5hntFfi0Wxi+KxNa6MGzEZcT942erB7mxUNKze0=";

in pkgs.stdenv.mkDerivation rec {
  pname = "sampctl";
  inherit version;

  src = pkgs.fetchurl {
    url = "https://github.com/Southclaws/sampctl/releases/download/${version}/sampctl_${version}_linux_${arch}.deb";
    sha256 = if pkgs.stdenv.isx86_64 then sha256_amd64 else sha256_386;
  };

  nativeBuildInputs = [
    pkgs.dpkg
    pkgs.autoPatchelfHook
  ];

  unpackPhase = ''
    dpkg-deb -x $src .
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp usr/bin/sampctl $out/bin/
  '';

  meta = with pkgs.lib; {
    description = "A development tool for SA-MP (San Andreas Multiplayer)";
    homepage = "https://github.com/Southclaws/sampctl";
    license = licenses.mit;
    platforms = [ "x86_64-linux" "i686-linux" ];
  };
}
