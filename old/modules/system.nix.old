# https://nixos.org/manual/nixos/stable/index.html#sec-writing-modules
{ config, pkgs, lib, ... }:
{
  # import = [];
  
  config = {
    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11";

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    
    # Set some Env Defaults
    # environment.sessionVariables.DEFAULT_BROWSER = "${pkgs.brave}/bin/brave";
    # environment.shellAliases.code = "${pkgs.vscode}/bin/code"; # or in home-manager
    
    # Console Keymap
    console.keyMap = config.defaultLang;
    
    # Shell Defaults
    users.defaultUserShell = pkgs.zsh;
    environment.shells = with pkgs; [ bash zsh ]; # fish
    programs.zsh.enable = true;
    # programs.fish.enable = true;

    # FLATPAK
    # services.flatpak.enable = false;

    # Enable Nix-Flakes
    nix.settings.experimental-features = [ "nix-command" "flakes" ];  

    # CUSTOM SCRIPT
    # system.activationScripts.script.text = ''
    #   #!/bin/sh
    #   echo '
    #   123
    #   456
    #   ' > test.txt
    # '';
    
    # System Auto Updates/Upgrades
    # (see also: https://itsfoss.com/things-to-do-after-installing-nixos/)
    system.autoUpgrade = {
      enable = true;
      # flake = inputs.self.outPath;
      flags = [
        "--update-input"
        "nixpkgs"
        "-L" # print build logs
      ];
      dates = "02:00";
      randomizedDelaySec = "45min";
    };

    # Systemd Timed Services/Jobs
    # (https://nixos.wiki/wiki/Systemd/Timers)
    # systemd.timers."hello-world" = {
    #   wantedBy = [ "timers.target" ];
    #     timerConfig = {
    #       OnBootSec = "5m";
    #       OnUnitActiveSec = "5m";
    #       Unit = "hello-world.service";
    #     };
    # };
    # systemd.services."hello-world" = {
    #   script = ''
    #     set -eu
    #     ${pkgs.coreutils}/bin/echo "Hello World"
    #   '';
    #   serviceConfig = {
    #     Type = "oneshot";
    #     User = "root";
    #   };
    # };

    # GIT
    programs.git.enable = true;
    
    # PRINTING (CUPS + AVAHI Autodiscover)
    # 1. Uncomment the lines below to enable printer and autodiscover
    # 2. If you are still having problems with your printer, then: 
    #    - check FIREWALL/VPN to not block the local network!!
    #    - and/or install system packages carps-cups / sane-airscan
    # services.printing.enable = true;
    # services.printing.browsing = true;
    # services.printing.drivers = [ pkgs.gutenprint ]; # pkgs.cnijfilter2
    # services.printing.defaultShared = false;
    # services.avahi.enable = true;
    # services.avahi.nssmdns = true;
    # services.avahi.openFirewall = true;
    
    # Set your time zone.
    time.timeZone = "Europe/Berlin";
    
    # DOCKER
    # virtualisation.docker.enable = true;
    virtualisation.docker.rootless = {
      enable = true;
      setSocketVariable = true;
    };
    
    # BROWSER TELEMETRY
    programs.firefox.policies.DisableTelemetry = true;
    
    # CRYPTO, YUBIKEY, GNUPG, PCSCD, ..
    # (alternative: https://developers.yubico.com/SSH/Securing_SSH_with_FIDO2.html)
    programs.gnupg.agent.enable = true;
    programs.gnupg.agent.enableSSHSupport  = true;
    services.pcscd.enable = true; # not needed anymore for the yubikey-agent?!
    # services.udev.packages = [ pkgs.yubikey-personalization ];
    # services.yubikey-agent.enable = true;
  
    # SYSTEM PACKAGES INSTALL
    ## Package List: https://search.nixos.org/packages
    ## Package Options: https://home-manager-options.extranix.com/
    # (to search already installed packages use: `nix search wget`)
    
    environment.systemPackages = with pkgs; [
      # Choose packages: https://search.nixos.org/packages
      # carps-cups # optional
      # canon-cups-ufr2 # optional
      # brave
      dig
      # firefox
      # fish
      git
      gedit
      gparted
      helix
      htop
      home-manager
      kdePackages.plasma-firewall
      mtr
      mullvad-vpn
      neovim
      nvtopPackages.amd
      radeontop
      # sane-airscan # optional (Print Autodiscover)
      # starship
      tree
      vim
      wget
      whois
      # wireguard-tools
      unzip
      zip
      zsh
    ];
  };
  
  # options = with lib; with types; {
  #   systemPackages = mkOption { type = listOf package; };
  # };
}
