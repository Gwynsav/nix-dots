{ config, nixpkgs, overlays, inputs, home-manager, system, ... }: with nixpkgs;

lib.nixosSystem rec {
  inherit system;
  
  modules = [
    ./configuration.nix
    {
      nixpkgs = {
        inherit overlays config;
      };
    }
  ];
}
