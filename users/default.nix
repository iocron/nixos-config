{ config, pkgs, lib, ... }:
let
  homeManagerVersion = "23.05";
  home-manager = builtins.fetchTarball {
    url = "https://github.com/nix-community/home-manager/archive/release-${homeManagerVersion}.tar.gz";
    # Get Hash Example: nix-hash --flat --base32 --type sha256 release-23.05.tar.gz # does not always work
    sha256 = "sha256:0rwzab51hnr6cmm1w5zmfh29gbkg6byv8jnr7frcv5kd6m8kna41";

    # Usual home-manager setup: 
    # url = "github:nix-community/home-manager";
    # inputs.nixpkgs.follows = "nixpkgs";
  };
  # home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/release-${homeManagerVersion}.tar.gz";
  # home-manager = builtins.fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
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
