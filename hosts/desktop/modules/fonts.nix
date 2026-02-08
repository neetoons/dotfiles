{pkgs, ...}:
{
    fonts.packages = with pkgs; [
        nerd-fonts.fira-code
        nerd-fonts.droid-sans-mono
        nerd-fonts.iosevka
        nerd-fonts.hack
        nerd-fonts.jetbrains-mono
        symbola
        unifont
        inter
        font-awesome
        noto-fonts-cjk-sans
        noto-fonts-color-emoji
        liberation_ttf
        fira-code-symbols
        mplus-outline-fonts.githubRelease
        dina-font
        proggyfonts
        roboto
        iosevka
    ];
}
