{
  lib,
  fetchurl,
  xorg,
  stdenv,
  pkgs,
}:

let
  arch =
    {
      x86_64-linux = "amd64";
      aarch64-linux = "arm64";
    }
    ."${stdenv.hostPlatform.system}" or (throw "Unsupported system: ${stdenv.hostPlatform.system}");
  hash =
    {
      amd64-linux_hash = "sha256-1jXo8MMk2EEkLo0n4ICmGJteKProLYKkMF//g63frHs=";
      arm64-linux_hash = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=";
    }
    ."${arch}-linux_hash";

  mkFranzDerivation = pkgs.callPackage "${pkgs.path}/pkgs/applications/networking/instant-messengers/franz/generic.nix" { };
in
mkFranzDerivation rec {
  pname = "ferdium";
  name = "Ferdium";
  version = "7.1.1";
  src = fetchurl {
    url = "https://github.com/ferdium/ferdium-app/releases/download/v${version}/Ferdium-linux-${version}-${arch}.deb";
    inherit hash;
  };

  extraBuildInputs = [ xorg.libxshmfence ];

  passthru = {
    updateScript = ./update.sh;
  };

  meta = with lib; {
    description = "All your services in one place built by the community";
    homepage = "https://ferdium.org/";
    license = licenses.asl20;
    maintainers = with maintainers; [ magnouvean ];
    platforms = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    hydraPlatforms = [ ];
  };
}
