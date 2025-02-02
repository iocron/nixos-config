## man configuration.nix
## man home-manager
## man home-configuration.nix
## nixos-help # Open NixOS Manual in the Browser
## nixos-option services # List nixos options of a service/package
## nixos-option services.mullvad-vpn # Show nixos options of a explicit service/package

## INSTALL_INFO_01: Install nixos-hardware first before using nixos-rebuild!! See: https://github.com/NixOS/nixos-hardware/tree/master or as below:
##  sudo nix-channel --add https://github.com/NixOS/nixos-hardware/archive/master.tar.gz nixos-hardware
##  sudo nix-channel --update

## INSTALL_INFO_02: Add & Update nixos-unstable before using the unstable channel:
##  sudo nix-channel --add https://nixos.org/channels/nixos-unstable nixos-unstable
##  sudo nix-channel --update

{ config, pkgs, lib, ... }:
# let
  # https://www.reddit.com/r/NixOS/comments/k2wq3h/importing_variables_from_a_file/ 
  # variables = import ./variables.nix { inherit config pkgs lib; };
  # variables = import ./variables.nix; # regular import or module import
  # unstableTarball = fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixpkgs-unstable.tar.gz";
# in 
{
  imports = [
      # "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/framework/16-inch/7040-amd" # ALTERNATIVE_TO_INSTALL_HARDWARE_PACKAGE: https://github.com/NixOS/nixos-hardware/tree/master
      <nixos-hardware/framework/16-inch/7040-amd>
      ./hardware-configuration.nix
      ./hardware-configuration-custom.nix
      ./language.nix
      ./system.nix
      ./users
  ];
}
