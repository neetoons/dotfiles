{ pkgs, ... }:
{
  services.open-webui.enable = true;
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cpu;
  };
}
