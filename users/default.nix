{ config, pkgs, lib, ... }:
let
  homeManagerVersion = "24.11";
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-${homeManagerVersion}.tar.gz";
    # Get Hash Example: nix-hash --flat --base32 --type sha256 release-23.05.tar.gz # does not always work
    # TODO: Removed sha validation only temporarily:
    #       sha256 = "sha256:c91a30f330f4421ee96093eaa51eacfbc65c352ce5bced2aa8a23f69f1b817fe";

    # Usual home-manager setup: 
    # url = "github:nix-community/home-manager";
    # inputs.nixpkgs.follows = "nixpkgs";
  };
  # home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${homeManagerVersion}.tar.gz";
  # home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
in
{
  home-manager.useGlobalPkgs = true;
  home-manager.backupFileExtension = "hm-backup"
  # home-manager.useUserPackages = true;
  imports = [
    (import "${home-manager}/nixos")
    ./developer.nix
    ./gamer.nix
  ];
}
