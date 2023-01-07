{ config, nixpkgs, overlays, inputs, ... }: with nixpkgs;

lib.nixosSystem rec {
  
  system  = "x86_64-linux";
  modules = [
    {
      nixpkgs = { inherit config overlays; };
    }
    ./configuration.nix
  ];
}
