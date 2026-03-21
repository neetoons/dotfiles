{ pkgs, ... }:
{
  home.packages = with pkgs; [
    gemini-cli
    yarn
    pnpm
    nodejs_latest
    typescript
    python310
    vscodium
    bruno # probar APIs
    sqlitebrowser
    lazygit
    tmux
  ];
}
