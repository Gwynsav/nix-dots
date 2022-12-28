# ---------------------------------- #
# -- Terminal Shell Configuration -- #
# ---------------------------------- #

{ pkgs, config, ... }:

{
  programs.zsh = {
    enable                   = true;
    enableAutosuggestions    = true;
    enableSyntaxHighlighting = true;
    enableCompletion         = true;

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
      command_timeout   = 5;
    };
  };
}
