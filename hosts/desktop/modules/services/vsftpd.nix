{ config, pkgs, ... }:
{

  services.vsftpd = {
    enable = true;
    localUsers = true;
    writeEnable = true;
    #localRoot = "/home/nit/ftp";
    #allowWriteableChroot = true; # Use with caution and understand the implications

    # Passive mode configuration (Crucial for most clients behind NAT/firewall)
    # Define a range of ports for passive data connections.
    # These ports MUST be opened in your firewall.
    extraConfig = ''
      pasv_enable=YES
      pasv_min_port=50000
      pasv_max_port=50099
    '';

    # Optional: Restrict access to specific users
    userlistEnable = true;
    userlistDeny = false; # If false, only users in 'userlist' are allowed
    userlist = [
      "nit"
    ];
  };

  # Open necessary ports in the firewall
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      #20 # FTP data (active mode) - often not strictly needed for passive
      #21 # FTP control
    ];
    allowedTCPPortRanges = [
      # Passive mode port range (must match pasv_min_port and pasv_max_port)
      #{ from = 50000; to = 50099; }
    ];
  };
    systemd.tmpfiles.rules = [
    # Rule 1: Set the user's home directory to be owned by root.
    # This satisfies vsftpd's security check, as the user 'nit' cannot write here.
    "d /home/nit/ftp 0755 root users -"

    # Rule 2: Create a 'ftp' subdirectory inside the home directory owned by 'nit'.
    # This is where the user will be able to upload and edit files.
    "d /home/nit/ftp 0755 nit users -"
    ];
  # Define your FTP user (if it's a local system user)
  #users.users.ftp = {
  #  isNormalUser = true;
  #  #home = "/home/nit/ftp"; # Or your desired home directory
  #  #password = "123123";
  #  #group = "users";
  #  #extraGroups = [ "wheel" ]; # Optional: add to wheel group for sudo, etc.
  #};
}
