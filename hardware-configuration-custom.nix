{ config, pkgs, lib, ... }: 
{
  # import = [];
  # Usage: e.g. use in configuration.nix like: imports = [./modules/hardware-advanced.nix ...]

  config = {
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    # boot.initrd.luks.devices."luks-6b862ad1-3067-42fc-b873-04e2cc152d9e".device = "/dev/disk/by-uuid/6b862ad1-3067-42fc-b873-04e2cc152d9e";
    # boot.initrd.luks.devices."luks-fd66369f-8038-4437-b5f1-519c670d0265".device = "/dev/disk/by-uuid/fd66369f-8038-4437-b5f1-519c670d0265";

    # boot.initrd.availableKernelModules = [ "nvme" "xhci_pci" "thunderbolt" "usbhid" "usb_storage" "sd_mod" "hid_multitouch" ];
    # boot.initrd.kernelModules = [ ]; # "psmouse" "hid_multitouch"
    # boot.kernelModules = [ "kvm-amd" ];
    # boot.blacklistedKernelModules = [ "psmouse" ]; # "sof-audio-pci-intel-tgl" "sof_audio_pci_intel_tgl"

    # boot.kernelPatches =  [
    #   {
    #     name = "pinctrl_amd";
    #     patch = null;
    #     extraConfig = ''
    #       PINCTRL_AMD y
    #     '';
    #   }
    # ];

    # hardware.enableRedistributableFirmware = true;

    # Configure keymap in X11
    services.xserver.xkb = {
        layout = config.defaultLang; # "de";
        variant = "";
    };

    # Security
    security.rtkit.enable = true;
    security.sudo.extraConfig = ''
      Defaults        timestamp_timeout=30
    '';

    # Some programs need SUID wrappers, can be configured further or are started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    # Networking
    networking.hostName = "foss"; # Define your hostname.
    networking.networkmanager.enable = true;

    networking.firewall = {
      enable = true;
      allowPing = false;
      # allowedTCPPorts = [ 80 443 631 ];
      # allowedUDPPorts = [ 80 443 631 ]; 
      # allowedTCPPorts = [ 80 443 1119 ]; # 1119 (for Bnet)
      # allowedUDPPorts = [  ]; # 1119 (for Bnet) 
      #extraCommands = ''
        # iptables -A INPUT -p udp -j DROP
        # iptables -A INPUT -p tcp -j DROP
      #'';
      #allowedUDPPortRanges = [
      #  { from = 4000; to = 4007; }
      #  { from = 8000; to = 8010; }
      #];
      #trustedInterfaces = [ "docker0" ]; # if problems with docker occur
      # checkReversePath = "loose"; # sometimes needed for mullvad / wireguard, disable if vpn is not used
    };

    # Wireguard
    # networking.wireguard.enable = true;

    # Enable Mullvad-VPN
    services.mullvad-vpn.enable = true;   # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Bluetooth
    hardware.bluetooth.enable = true;

    # Fingerprint
    services.fprintd.enable = true;

    # Power Profiles Deamon
    # (see also: https://community.frame.work/t/nixos-on-the-framework-laptop-16/46743/18)
    # services.power-profiles-daemon.enable = true;

    # Enable touchpad support
    # (enabled default in most desktopManager)
    # services.libinput.enable = true;
    # services.xserver.libinput.enable = true;
    # services.xserver.synaptics.enable = true;

    # DISPLAY MANAGER (e.g. X11)
    # services.displayManager.setupCommands = ''
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;

    # Hardware GPU
    # (see also: https://github.com/quentinmit/isz/blob/f6b53b1734a997a1a3971e91668336af18ca015b/nix/modules/isz/gpu.nix#L11)
    hardware.graphics.extraPackages = with pkgs; [
      # https://nixos.org/manual/nixos/stable/#sec-gpu-accel-opencl-amd
      rocmPackages.clr.icd
      # https://nixos.org/manual/nixos/stable/#sec-gpu-accel-vulkan-amd
      # Disable for now (radv driver in mesa should handle)
      # amdvlk
    ];

    hardware.graphics.enable = lib.mkDefault true;
    hardware.graphics.enable32Bit = lib.mkDefault true;
    # hardware.amdgpu.initrd.enable = lib.mkDefault true;

    # Load nvidia driver for Xorg and Wayland
    # (read further: https://nixos.wiki/wiki/Nvidia)
    # (see also: https://github.com/NixOS/nixos-hardware/blob/master/common/gpu/amd/default.nix)
    services.xserver.videoDrivers = [ "modesetting" ]; # OLD: "amdgpu" or "nvidia"

    # Firmware, Disk, FileSystem
    # (see also: https://github.com/quentinmit/isz/blob/main/goddard/configuration.nix)
    services.fstrim.enable = true;
    services.smartd.enable = true;
    services.fwupd.enable = true;

    # Linux Kernal Binary Optimizer
    services.hardware.bolt.enable = true;

    # Keyboard Custom
    # hardware.keyboard.qmk.enable = true;

    # Special Kernal Boot
    boot.kernelPackages = pkgs.linuxPackages_latest;
    # boot.kernelParams = [''dyndbg="file drivers/base/firmware_loader/main.c +fmp"''];

    # Enable sound with pipewire.
    # services.blueman.enable = true;
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
