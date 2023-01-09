# -------------------------------- #
# -- Home Manager Configuration -- #
# -------------------------------- #

{ config, nixpkgs, home-manager, lib, overlays, inputs, ... }:

let system = "x86_64-linux";
in home-manager.lib.homeManagerConfiguration {
  modules = [ 
    ./home.nix
    {
      home = {
        username      = "gw";
        homeDirectory = "/home/gw";
        stateVersion  = "22.11";
      };
    }
  ];
  pkgs = import inputs.nixpkgs {
    system = "${system}";
    config.allowUnfree = true;
    inherit overlays;
  };
  extraSpecialArgs = { inherit inputs system; };
}
