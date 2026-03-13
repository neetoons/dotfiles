{ pkgs, ... }:
{

  environment.systemPackages = with pkgs; [
    alsa-utils
    pulseeffects-legacy
  ];

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    jack.enable = true;
    extraConfig.pipewire."91-null-sinks" = {
      "context.modules" = [
        {
          name = "libpipewire-module-loopback";
          args = {
            "node.description" = "Mono Playback Device";
            "capture.props" = {
              "node.name" = "mono_output";
              "media.class" = "Audio/Sink";
              "audio.position" = "MONO";
            };
            "playback.props" = {
              "node.name" = "playback.mono_output";
              "audio.position" = "MONO";
              "node.passive" = "true";
            };
          };
        }
      ];
    };
  };

  #services.pulseaudio.package = pkgs.pulseaudioFull;
  #services.pulseaudio.enable = true;
}
