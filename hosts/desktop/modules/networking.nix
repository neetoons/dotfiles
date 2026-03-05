{ pkgs, ... }:
{
    # Enable networking
    networking = {
        networkmanager.enable = true;

        # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
        # (the default) this is the recommended approach. When using systemd-networkd it's
        # still possible to use this option, but it's recommended to use it in conjunction
        # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
        # interfaces.enp2s0.useDHCP = lib.mkDefault true;
        useDHCP = false; # Importante para evitar conflictos con NetworkManager

        hostName = "nixos";
        firewall = {
            enable = true;
            allowPing = true;
            allowedTCPPorts = [ ];
            allowedUDPPorts = [ ];
        };
    };

    programs.nm-applet.enable = true;

    # LocalSend
    programs.localsend.enable = true;

    environment.systemPackages = with pkgs; [
      polkit_gnome
      networkmanagerapplet
    ];

    # 2. Asegúrate de que el servicio polkit esté habilitado
    security.polkit.enable = true;

    # 3. Auto-arranque (Systemd User Service)
    systemd.user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };

security.polkit.extraConfig = ''
  polkit.addRule(function(action, subject) {
    if (subject.isInGroup("networkmanager") &&
        action.id.indexOf("org.freedesktop.NetworkManager.") == 0) {
      return polkit.Result.YES;
    }
  });
'';

}
