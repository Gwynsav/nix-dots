# ------------------- #
# -- good_luck.nix -- #
# ------------------- #

{
  description = "gw doesn't know flakes";

  inputs = {
    # Package sources.
    master.url                 = "github:nixos/nixpkgs/master";
    stable.url                 = "github:nixos/nixpkgs/nixos-22.11";
    unstable.url               = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url           = "github:nix-community/home-manager";
    nixpkgs-f2k.url            = "github:fortuneteller2k/nixpkgs-f2k";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    nur.url                    = "github:nix-community/NUR";

    # Channel to follow.
    nixpkgs.follows                               = "stable";
    nixpkgs-f2k.inputs.nixpkgs.follows            = "nixpkgs";
    home-manager.inputs.nixpkgs.follows           = "nixpkgs";
    neovim-nightly-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, home-manager, ... } @inputs:
    with nixpkgs.lib; let
      config   = {
        allowUnfree = true;
        allowBroken = true;
      };

      # handle nix files
      filterNixFiles = k: v: v == "regular" && hasSuffix ".nix" k;
      importNixFiles = path:
        (lists.forEach (mapAttrsToList (name: _: path + ("/" + name))
          (filterAttrs filterNixFiles (builtins.readDir path)))) import;

      # package overlays
      overlays = with inputs; [
        (final: _:
          let inherit (final) system;
          in (with nixpkgs-f2k.packages.${system}; {
            awesome = awesome-git;
            picom   = picom-dccsillag;
            wezterm = wezterm-git;
          }) // {
            master      = import master   { inherit config system; };
            stable      = import stable   { inherit config system; };
            unstable    = import unstable { inherit config system; };
          }
        )
        neovim-nightly-overlay.overlay
        nixpkgs-f2k.overlays.default
        nur.overlay
      ] ++ (importNixFiles ./overlays);
    in {
      # host configurations
      nixosConfigurations = {
        fakeflake =
          import ./hosts/fakeflake
          { inherit config nixpkgs overlays inputs; };
        winterborne = 
          import ./hosts/winterborne
          { inherit config nixpkgs overlays inputs; };
      };
      # user configurations
      homeConfigurations  = {
        gw =
          import ./users/gw
          { inherit config nixpkgs overlays inputs home-manager lib; };
      };
      fakeflake   = self.nixosConfigurations.fakeflake.config.system.build.toplevel;
      winterborne = self.nixosConfigurations.winterborne.config.system.build.toplevel;
    };
}
