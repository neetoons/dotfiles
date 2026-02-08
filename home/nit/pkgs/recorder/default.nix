{ pkgs, stdenv, bash, lib, makeWrapper, ... }:

let
  # Definimos una lista de todas las dependencias que el script necesita para EJECUTARSE
  runtimeDeps = [
    pkgs.wf-recorder # Necesario para la funcionalidad del script
    pkgs.bash        # Necesario para el shebang (aunque sea implícito, es bueno tenerlo)
  ];
in

stdenv.mkDerivation {
  pname = "recorder";
  version = "1.0";

  src = ./recorder.sh;

  # Las herramientas que necesitamos *durante* la construcción (el makeWrapper)
  nativeBuildInputs = [ makeWrapper ];

  # Las dependencias que el script necesita en su PATH al ser ejecutado
  buildInputs = runtimeDeps;

  # Usamos solo la fase de instalación
  phases = [ "installPhase" ];

  installPhase = ''
    mkdir -p $out/bin
    cp $src $out/bin/recorder
    chmod +x $out/bin/recorder
    wrapProgram $out/bin/recorder \
      --prefix PATH : ${lib.makeBinPath runtimeDeps}
  '';
}
