{ config, pkgs, lib, ... }: 
{
  # import = [];

  config = {
    # Bluetooth
    hardware.bluetooth.enable = true;

    # OpenGL
    hardware.opengl.enable = true;
    hardware.opengl.driSupport = true;

    # Load nvidia driver for Xorg and Wayland
    # (read further: https://nixos.wiki/wiki/Nvidia)
    # services.xserver.videoDrivers = [ "nvidia" ];
    # services.xserver.videoDrivers = [ "amdgpu" ];

    # Enable sound with pipewire.
    sound.enable = true;
    hardware.pulseaudio.enable = false;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true; # If you want to use JACK applications, uncomment this

      # use the example session manager (no others are packaged yet so this is enabled by default,
      # no need to redefine it in your config for now)
      # media-session.enable = true;
    };
  };

  # options = {};
}
