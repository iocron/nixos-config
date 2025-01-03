## man configuration.nix
## man home-manager
## man home-configuration.nix
## nixos-help # Open NixOS Manual in the Browser

{ config, pkgs, lib, nixos-hardware, ... }:
# let
  # https://www.reddit.com/r/NixOS/comments/k2wq3h/importing_variables_from_a_file/ 
  # variables = import ./variables.nix { inherit config pkgs lib; };
  # variables = import ./variables.nix; # regular import or module import
  # unstableTarball = fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixpkgs-unstable.tar.gz";
# in 
{
  imports = [
      "${builtins.fetchGit { url = "https://github.com/NixOS/nixos-hardware.git"; }}/framework/16-inch/7040-amd" # ALTERNATIVE_TO_INSTALL_HARDWARE_PACKAGE: https://github.com/NixOS/nixos-hardware/tree/master
      ./hardware-configuration.nix
      ./hardware-configuration-custom.nix
      ./language.nix
      ./system.nix
      ./users
  ];
}
