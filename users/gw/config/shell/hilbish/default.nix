# ---------------------- #
# -- Lua shell!11!!!1 -- #
# ---------------------- #

_:
''
  -- Imports
  ----------
  local lunacolors = require('lunacolors')
  local bait       = require('bait')

  -- Prompt
  ---------
  local function doPrompt(fail)
    hilbish.prompt(lunacolors.format(
      ' \n' .. (fail and '{redBg}' or '{cyanBg}') .. ' {black}∇ {grayBg} {white}{italic}%d {blackBg} '
    ))
  end
  doPrompt()
  bait.catch('command.exit', function(code)
    doPrompt(code ~= 0)
  end)

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
  hilbish.run("bash -e fetch")
''
