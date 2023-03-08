# ---------------------------------- #
# -- Terminal Shell Configuration -- #
# ---------------------------------- #

{ config, ... }:

{
  programs.zsh = {
    enable                   = true;
    enableAutosuggestions    = true;
    enableSyntaxHighlighting = true;
    enableCompletion         = true;
    dotDir                   = ".config/zsh";

    shellAliases = {
      sudo     = "doas";
      ls       = "exa -l";
      nix-pkgs = "nix --extra-experimental-features 'nix-command flakes' search nixpkgs";
    };
    history   = {
      expireDuplicatesFirst = true;
      save                  = 512;
    };
    initExtra = "
      export PATH=${config.home.homeDirectory}/.local/bin:$PATH
      fetch
    ";
  };

  programs.starship = {
    enable   = true;
    settings = {
      format = "$directory$git_branch$git_status$cmd_duration\n[ ](fg:blue) ";
      git_branch.format = "via [$symbol$branch(:$remote_branch)]($style) ";
      command_timeout   = 1000;
    };
  };
}
