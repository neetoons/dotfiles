{inputs, pkgs, config,  lib, ... }:
let
  system = "x86_64-linux";
  #hyprlandPkgs =  inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system};
in
{
    programs.niri = {
        enable = true;
        package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri;
    };

    xdg.portal = {
        enable = true;
        extraPortals = [  pkgs.xdg-desktop-portal-gtk ];
    };

environment.systemPackages = with pkgs; [
# --- Entorno de Escritorio y Complementos (Wayland/Sway) ---
    xdg-desktop-portal # Implementa las API de Freedesktop para aplicaciones aisladas (necesario en Wayland)
    swaybg # Utilidad para establecer el fondo de pantalla en Wayland
    swww
    waypaper # Wallpaper manager
    eww # Extensible Widget Wrapper, framework para crear barras, menús y widgets personalizados
    rofi # Lanzador de aplicaciones, selector de ventanas y menús dinámicos compatible con Wayland
    fuzzel
    dunst # Daemon de notificaciones ligero y minimalista
    libnotify # Biblioteca para enviar notificaciones de escritorio
    wlogout # wlogout is a logout menu for wayland environments.

    # neccessary for dank material
# --- Herramientas de Terminal y Clipboard ---
    kitty # Emulador de terminal rápido y rico en funciones
    alacritty
    cliphist # Herramienta de historial de portapapeles para Wayland
    wl-clipboard # Herramientas de línea de comandos para manipular el portapapeles de Wayland

# --- Captura de Pantalla y Manipulación de Imágenes (Wayland) ---
    grim # Utilidad para tomar capturas de pantalla en Wayland
    slurp # Utilidad para seleccionar una región rectangular de la pantalla en Wayland
    satty # edicion de captura

# --- Audio, Media y Utilidades de Red ---
    networkmanagerapplet # Applet para gestionar la red (Wi-Fi, Ethernet, VPNs)
    mpvpaper # Herramienta para usar un video como fondo de escritorio (requiere mpv)
    playerctl # Utilidad de línea de comandos para controlar reproductores de medios compatibles con MPRIS
    gammastep # Herramienta para ajustar la temperatura de color de la pantalla según la hora del día (similar a Redshift/F.lux)

    xwayland-satellite
    ];

  services.xserver.videoDrivers = [ "modesetting" ];

  hardware.graphics = {
    enable32Bit = true;
    enable = true;
    extraPackages = with pkgs; [
      # Required for modern Intel GPUs (Xe iGPU and ARC)
      intel-media-driver     # VA-API (iHD) userspace
      vpl-gpu-rt             # oneVPL (QSV) runtime

      # Optional (compute / tooling):
      #intel-compute-runtime  # OpenCL (NEO) + Level Zero for Arc/Xe
      # NOTE: 'intel-ocl' also exists as a legacy package; not recommended for Arc/Xe.
      # libvdpau-va-gl       # Only if you must run VDPAU-only apps
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";     # Prefer the modern iHD backend
    #DISPLAY = ":0";
    # VDPAU_DRIVER = "va_gl";      # Only if using libvdpau-va-gl
  };

  # Habilitar el servicio de almacenamiento seguro
  services.gnome.gnome-keyring.enable = true;

  # Asegurar que se desbloquee al iniciar sesión
  security.pam.services.login.enableGnomeKeyring = true;

  # Necesario para que las apps encuentren el servicio en Wayland/Hyprland
  services.dbus.enable = true;
  programs.xwayland.enable = true;
}
