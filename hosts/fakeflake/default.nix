{ config, nixpkgs, overlays, inputs, ... }: with nixpkgs;

lib.nixosSystem rec {
  
  system  = "x86_64-linux";
  modules = [
    ./configuration.nix
    {
      nixpkgs = { inherit config overlays; };
    }
    home-manager.nixosModules.home-manager {
      home-manager.useGlobalPkgs   = false;
      home-manager.useUserPackages = true;
      home-manager.users.gw = {
        imports = [ ../../users/gw/home.nix ];
      };
    };
  ];
}
