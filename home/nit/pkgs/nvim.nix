{pkgs, ...}:
{
    home.packages = with pkgs; [
        neovim
        ripgrep
        lua-language-server
    ];
}
