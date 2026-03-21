{ pkgs, ... }:
let
  workingDirectory = "/var/lib/discord-bots/vscbot";
in
{

  systemd.services.vscbot = {
    enable = true;
    description = "Discord Bot: VSCBot";
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      User = "discord-bot";
      Group = "users";
      WorkingDirectory = workingDirectory;
      ExecStart = ''
        ${pkgs.nodejs_latest}/bin/node .
      '';
      EnvironmentFile = "${workingDirectory}/.env";
      Restart = "on-failure";
      RestartSec = 5;
      NoNewPrivileges = true;
      PrivateTmp = true;
    };
  };
}
