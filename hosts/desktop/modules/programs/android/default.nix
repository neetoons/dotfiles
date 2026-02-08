{pkgs, ...}:
{
    #virtualisation.waydroid.enable = true;
    environment.systemPackages =  [ pkgs.scrcpy pkgs.android-tools];
}
