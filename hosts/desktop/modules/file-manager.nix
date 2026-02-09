{pkgs, ...}:
{
    programs.thunar.enable = true;
    programs.thunar.plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
    ];
    environment.systemPackages = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
    ];

    services.gvfs.enable = true;
    services.tumbler.enable = true;
    xdg.portal.config.preferred."org.freedesktop.impl.portal.FileChooser" = "thunar";
}
