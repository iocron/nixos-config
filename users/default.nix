{ config, pkgs, lib, ... }:
let
  homeManagerVersion = "23.05";
  home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${homeManagerVersion}.tar.gz";
  # home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  # url = "github:nix-community/home-manager";
  # inputs.nixpkgs.follows = "nixpkgs";
in
{
  home-manager.useGlobalPkgs = true;
  # home-manager.useUserPackages = true;
  imports = [
    (import "${home-manager}/nixos")
    ./developer.nix
    ./gamer.nix
  ];
}
