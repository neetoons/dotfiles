{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "sorter";
  src = ./sorter;
  buildInputs = [ pkgs.bash pkgs.subversion ];
  nativeBuildInputs = [ pkgs.makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp sorter.sh $out/bin/sorter
    wrapProgram $out/bin/sorter \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.bash pkgs.subversion ]}
  '';
}
