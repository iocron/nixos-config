{ config, pkgs, lib, ... }: 
{
  # import = [];

  config = { # config = rec { ... }; # if you want to use self-referencing variables
    # Enable the X11 windowing system.
    services.xserver.enable = true;

    # Enable the KDE Plasma Desktop Environment.
    services.xserver.displayManager.sddm.enable = true;
    # services.xserver.desktopManager.plasma5.enable = true;
    # services.xserver.displayManager.setupCommands = ''
    #   kwriteconfig5 --file ~/.config/kwinrc --group TabBox --key LayoutName big_icons # icons
    # '';

    # systemd.user.services.plasma5extended = {
    #   enable = true;
    #   description = "Changing KDE5 Theme Settings";
    #   serviceConfig = {
    #     Type = "oneshot";
    #     ExecStart = ''
    #       /run/current-system/sw/bin/kwriteconfig5 --file ~/.config/kwinrc --group TabBox --key LayoutName "big_icons" 
    #     '';
    #   };
    #   wantedBy = [ "multi-user.target" ];
    # };

    # systemd.user.services.plasma5extended = {
    #   description = "My Shell Command";
    #   script = ''
    #     #!/bin/sh
    #     echo "Hello from NixOS"
    #     /run/current-system/sw/bin/kwriteconfig5 --file ~/.config/kwinrc --group TabBox --key LayoutName big_icons
    #   '';
    #   wantedBy = [ "multi-user.target" ]; 
    # };

    # services.xserver.desktopManager.session = [{
    #   # see also: https://discourse.nixos.org/t/opening-i3-from-home-manager-automatically/4849/2
    #   name = "plasma5.TabBox";
    #   # Add or modify KDE Plasma settings here
    #   manage = "desktop";
    #   start = ''
    #     # Configure Alt+Tab behavior
    #     # big_icons, ..
    #     ${pkgs.runtimeShell} kwriteconfig5 --file ~/.config/kwinrc --group TabBox --key LayoutName "icons" 
    #     & waitPID=$!
    #   '';
    # }];

    # Configure keymap in X11
    services.xserver.layout = "de";
    services.xserver.xkbVariant = "";

    # Enable touchpad support (enabled default in most desktopManager).
    ## services.xserver.libinput.enable = true;
  };

  # options = {};
}
