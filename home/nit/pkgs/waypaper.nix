{pkgs, ...}:
let
  assets = pkgs.callPackage ./assets.nix { };
  folder = "${assets}/share/assets/wallpapers";
  wallpaper = "${assets}/share/assets/wallpapers/3.jpg";
in
{
      xdg.configFile."waypaper/config.ini".text =  ''
        [Settings]
        language = en
        folder = ${folder}
        monitors = All
        wallpaper = ${wallpaper}
        show_path_in_tooltip = True
        backend = mpvpaper
        fill = fill
        sort = name
        color = #ffffff
        subfolders = False
        all_subfolders = False
        show_hidden = False
        show_gifs_only = False
        zen_mode = False
        post_command =
        number_of_columns = 3
        swww_transition_type = any
        swww_transition_step = 63
        swww_transition_angle = 0
        swww_transition_duration = 2
        swww_transition_fps = 60
        mpvpaper_sound = False
        mpvpaper_options =
        use_xdg_state = False
        stylesheet = $HOME/.config/waypaper/style.css
    '';
}
