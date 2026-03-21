{
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      # Posicionamiento y Layout
      position = "top-center";
      offset_x = 1;
      offset_y = 0;
      background_alpha = 0.1;
      no_background = true;
      horizontal = true;
      alignment = "top";
      legacy_layout = 0;
      table_columns = 25;

      # Fuentes
      font_size = 16;
      font_scale = 1;
      font_size_text = 24;
      font_scale_media_player = 0.55;
      no_small_font = true;

      # Estadísticas de Rendimiento
      fps = true;
      cpu_stats = true;
      gpu_stats = true;
      ram = true;
      vram = true;
      cpu_power = true;
      gpu_power = true;

      # Información Miscelánea
      arch = true;
      wine = true;
      resolution = true;
      gamemode = true;
      vkbasalt = true;

      # Colores (Catppuccin Mocha vibes o según tu .conf)
      text_color = "FFFFFF";
      gpu_color = "FFFFFF";
      cpu_color = "FFFFFF";
      vram_color = "FFFFFF";
      ram_color = "FFFFFF";
      engine_color = "FFFFFF";
      io_color = "A491D3";
      frametime_color = "FFFFFF";
      background_color = "505050";
      media_player_color = "FFFFFF";
      wine_color = "FFFFFF";

      # Atajos
      toggle_hud = "F12";
    };

    settingsPerApplication = {
      mpv.no_display = true;
    };
  };
}
