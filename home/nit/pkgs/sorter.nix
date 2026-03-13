{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "sorter";
  src = pkgs.fetchFromGitHub {
    owner = "neetoons";
    repo = "sorter.sh";
    rev = "master";
    sha256 = "sha256-Q23E0EeXrBFAHY0kGCXuGWlw2MzMxiSVBNJD//LA9A0=";
  };
  buildInputs = [ pkgs.bash pkgs.subversion ];
  nativeBuildInputs = [ pkgs.makeWrapper ];
  installPhase = ''
    mkdir -p $out/bin
    cp sorter.sh $out/bin/sorter.sh
    wrapProgram $out/bin/sorter.sh \
      --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.bash pkgs.subversion ]}
  '';
}
