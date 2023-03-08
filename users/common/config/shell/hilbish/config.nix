_:
''
  -- Imports
  ----------
  local lunacolors = require('lunacolors')
  local bait       = require('bait')
  local promptua   = require('promptua')

  -- Prompt
  ---------
  promptua.setConfig {
    prompt = {
      icon    = "→",
      success = "",
      fail    = ""
    }
  }

  promptua.setTheme {
    -- Dir and Git repo.
    {
      provider  = "dir.path",
      style     = "grayBg white",
      separator = "",
      format    = "@style @icon@info "
    },
    { provider = "git.branch",  style = "yellow",   separator = "", icon = "  " },
    { provider = "git.dirty",   style = "bold red", separator = "", icon = " [!] " },
    { separator = "\n" },
    -- Actual prompt thing.
    {
      provider  = "prompt.icon",
      style     = "blue",
      separator = " "
    }
  }
  promptua.init()

  -- Aliases
  ----------
  hilbish.alias("sudo", "doas")
  hilbish.alias("ls",   "exa -l")
  hilbish.alias("vi",   "nvim")
  hilbish.alias("vim",  "nvim")
  hilbish.alias("nix-pkgs", "nix --extra-experimental-features 'nix-command flakes' search nixpkgs")

  -- Misc
  -------
  hilbish.opts.greeting = false
  hilbish.opts.motd     = false
  hilbish.runnerMode("hybridRev")
  hilbish.prependPath("~/.local/bin/")

  -- Autorun
  ----------
  hilbish.run("fetch")
''
