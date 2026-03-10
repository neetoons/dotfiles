{ config, pkgs, lib, ... }:

let
  working_directory = "/var/lib/yt-dlp-api";
  actualDownloadsPath = "/var/lib/yt-dlp-api/downloads";
  ytDlpApiSrc  = pkgs.fetchFromGitHub {
    owner = "neetoons";
    repo = "yt-dlp-api";
    rev = "main";
    hash = "sha256-nQ+hyZMUZGqf0oRKHYb5Zbr5d67FBA3JPfV/3taASW8=";
  };
  ytDlpApiPackage = pkgs.buildNpmPackage rec {
    pname = "yt-dlp-api";
    version = "1.0.0";

    src = ytDlpApiSrc;

    buildAndTest = false;

    installPhase = ''
      ${pkgs.nodePackages.typescript}/bin/tsc

      mkdir -p $out/lib/${pname}-${version}
      mkdir -p $out/lib/${pname}-${version}/downloads
      cp -r dist node_modules package.json $out/lib/${pname}-${version}/

    '';

    nativeBuildInputs = [ pkgs.nodePackages.typescript ];
    npmDepsHash = "sha256-N30FM8UylAzFKiEFFpPbLgH2L+lmxGjLbZgXpEfUaiU=";
  };

in
{
  systemd.services."yt-dlp-api" = {
    description = "API para yt-dlp";
    after = [ "network.target" ];
    wantedBy = [ "multi-user.target" ];
   serviceConfig = {
      Type = "exec";
      DynamicUser = true;
      WorkingDirectory = working_directory;
      ExecStart = ''
        ${pkgs.nodejs_24}/bin/node ${ytDlpApiPackage}/lib/yt-dlp-api-1.0.0/dist/index.js
        '';
      Restart = "on-failure";
      RestartSec = 5;
    };

    # Opcional: Ejecutar el servicio como un usuario específico
    # Es una buena práctica no ejecutar servicios como root.
    #user = "yt-dlp-api"; # Puedes crear este usuario o usar uno existente como "nobody"
    #group = "yt-dlp-api"; # Puedes crear este grupo o usar uno existente
    restartTriggers = [ ytDlpApiPackage ]; # Reinicia si el paquete se actualiza
    environment = {
      PORT = "3005";
    };
  };
    systemd.tmpfiles.rules = [
      "d /var/lib/yt-dlp-api 0755 root root -"
    ];

  # Opcional: Crea el usuario y grupo si no existen
  users.users.yt-dlp-api = {
    isSystemUser = true;
    isNormalUser = false;
    group = "yt-dlp-api";
    home = working_directory;
    createHome = true;
  };
  users.groups.yt-dlp-api = { };

   #networking.firewall.allowedTCPPorts = [ 3005 ];
}
