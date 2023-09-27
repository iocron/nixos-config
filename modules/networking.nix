{ config, pkgs, lib, ... }:
{
  # imports = [
  #   ./modules/mymodule.nix
  # ];

  config = {
    # Networking Enable
    networking.networkmanager.enable = true;

    # HostName
    networking.hostName = "nixos"; # Define your hostname.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

    # Proxy
    # networking.proxy.default = "http://user:password@proxy:port/";
    # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

    # Open ports in the firewall.
    networking.firewall = {
      enable = true;
      allowPing = false;
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
    services.mullvad-vpn.enable = true;
  };

  options = {
    
  };
}
