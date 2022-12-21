{
  description = "I'm scared T.T";

  inputs = {
    nixpkgs.url  = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-f2k, ... } @inputs:
    let
      lib      = nixpkgs.lib;
      overlays = with inputs; [
        (final: _:
          let inherit (final) system;
          in (with nixpkgs-f2k.packages.${system}; {
            awesome = awesome-git;
            picom   = picom-git;
          })
        )
        nixpkgs-f2k.overlays.default
      ];
    in {
      nixosConfigurations = {
        fakeflake = import ./hosts/fakeflake {
          inherit config nixpkgs overlays inputs system home-manager;
        };
      };
    }
}
