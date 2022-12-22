{
  description = "I'm NO LONGER scared >:)";

  inputs = {
    master.url   = "github:nixos/nixpkgs/master";
    stable.url   = "github:nixos/nixpkgs/nixos-22.11";
    nixos-unstable.url   = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixpkgs-f2k = {
      url = "github:fortuneteller2k/nixpkgs-f2k";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-f2k, ... } @inputs:
    let
      system   = "x86_64-linux";
      config   = {
        allowUnfree = true;
        allowBroken = true;
      };
      lib      = nixpkgs.lib;
      overlays = with inputs; [
        (final: _:
          let inherit (final) system;
          in (with nixpkgs-f2k.packages.${system}; {
            awesome = awesome-git;
            picom   = picom-git;
          }) // {
            master   = import master { inherit config system; };
            unstable = import unstable { inherit config system; };
            stable   = import stable { inherit config system; };
          }
        )
	neovim-nightly-overlay.overlay
        nixpkgs-f2k.overlays.default
      ];
    in {
      nixosConfigurations = {
        fakeflake = import ./hosts/fakeflake {
          inherit config nixpkgs overlays home-manager inputs;
        };
      };
    };
}
