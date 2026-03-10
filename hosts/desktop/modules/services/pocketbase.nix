{pkgs, lib, ...}:
{
    systemd.services.pocketbase = {
    script = "${pkgs.pocketbase}/bin/pocketbase serve --dir /var/pocketbase/pb_data";
    serviceConfig = {
        LimitNOFILE = 4096;
    };
    wantedBy = [ "multi-user.target" ];
    };
}
