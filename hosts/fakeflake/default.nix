{ config, nixpkgs, overlays, inputs, ... }: with nixpkgs;

lib.nixosSystem rec {
  
  system  = "x86_64-linux";
  modules = [
    ./configuration.nix
    {
      nixpkgs = { inherit config overlays; };
    }
  ];
}
