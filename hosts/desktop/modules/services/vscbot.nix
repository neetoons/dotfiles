{ pkgs, ...}:
{
    environment.systemPackages = [pkgs.nodejs_latest];
    systemd.services.vscbot = {
        enable = true;
        description = "vscbot - discord bot";
        after = [ "network-online.target" ];
        wants = [ "network-online.target" ];
        wantedBy = [ "multi-user.target" ];

        serviceConfig = {
            User = "nit";
            Group = "users";
            WorkingDirectory = "/home/nit/discord_bots/vscbot/";
            ExecStart = ''
                ${pkgs.nodejs_latest}/bin/node .
            '';
            EnvironmentFile = "/home/nit/discord_bots/vscbot/.env";
            Restart = "on-failure";
            RestartSec = 5;

        };
    };

    users.extraUsers.vscbot = {
    isSystemUser = true;
    group = "users";
    };
}
