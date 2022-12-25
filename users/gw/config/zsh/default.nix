{ config, pkgs, ... }:

{
  programs.zsh = {
    enable                   = true;
    enableAutosuggestions    = true;
    enableSyntaxHighlighting = true;
    initExtra = 
    "
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
