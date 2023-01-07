-- Decay Colorscheme
--------------------
local asst_dir  = require('gears.filesystem').get_configuration_dir() .. "themes/assets/"
local clrs = {}
  clrs.nbg   = "#0d0f18"
  clrs.lbg   = "#151720"
  clrs.blk   = "#1c1e27"
  clrs.gry   = "#2b2d36"
  clrs.wht   = "#5c6d87"
  clrs.dfg   = "#7c8da6"
  clrs.nfg   = "#a5b6cf"

  clrs.red   = "#e26c7c"
  clrs.red_d = "#dd6777"
  clrs.grn   = "#95d3af"
  clrs.grn_d = "#90ceaa"
  clrs.ylw   = "#f1d8a5"
  clrs.ylw_d = "#ecd3a0"
  clrs.blu   = "#8baff1"
  clrs.blu_d = "#86aaec"
  clrs.mag   = "#c79bf0"
  clrs.mag_d = "#c296eb"
  clrs.cya   = "#98d3ee"
  clrs.cya_d = "#93cee9"

  clrs.wall   = asst_dir .. "default/walls/decay.png"
  clrs.player = asst_dir .. "default/player/decay.png"
return clrs
