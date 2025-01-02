## man configuration.nix
## man home-manager
## man home-configuration.nix
## nixos-help # Open NixOS Manual in the Browser

{ config, pkgs, lib, ... }:
# let
  # https://www.reddit.com/r/NixOS/comments/k2wq3h/importing_variables_from_a_file/ 
  # variables = import ./variables.nix { inherit config pkgs lib; };
  # variables = import ./variables.nix; # regular import or module import
  # unstableTarball = fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixpkgs-unstable.tar.gz";
# in 
{
  ## GLOBAL HELPER VAR "unstable" in any module, for beeing able to use nixpkgs-unstable
  ## (usage example: ...packages = with pkgs; [ unstable.htop ];)
  nixpkgs.config = {
    packageOverrides = pkgs: { # packageOverrides = pkgs: with pkgs; {
      # You can use the "unstable" variable in a module with packages to reference to a unstable package, e.g.: 
      #   home.packages = with pkgs; [ unstable.rustc ];
      # unstable = import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/refs/heads/nixpkgs-unstable.tar.gz") {
      #   config = config.nixpkgs.config;
      # };
      unstable = import (fetchGit {
        url = "https://github.com/NixOS/nixpkgs";
        ref = "nixpkgs-unstable";
        rev = "8b5ab8341e33322e5b66fb46ce23d724050f6606"; # Last update: 19.09.2023
      }) {
        config = config.nixpkgs.config;
      };
    };
  };

  imports = [
      ./hardware-configuration.nix
      ./modules/hardware-advanced.nix
      ./modules/boot.nix
      ./modules/language.nix
      ./modules/networking.nix
      ./modules/security.nix
      ./modules/system.nix
      # ./modules/xserver.nix # only for KDE5?!?
      ./users
  ];
}
