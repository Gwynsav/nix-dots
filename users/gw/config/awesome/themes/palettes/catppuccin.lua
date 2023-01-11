-- Catppuccin Colorscheme
-------------------------
local asst_dir  = require('gears.filesystem').get_configuration_dir() .. "themes/assets/"
local clrs = {}
   clrs.nbg   = "#24273a"
   clrs.lbg   = "#2d3146"
   clrs.blk   = "#3d4158"
   clrs.gry   = "#494d64"
   clrs.wht   = "#939ab7"
   clrs.dfg   = "#a5adcb"
   clrs.nfg   = "#cad3f5"

   clrs.red   = "#ed8796"
   clrs.red_d = "#ba6370"
   clrs.grn   = "#a6da95"
   clrs.grn_d = "#88bf80"
   clrs.ylw   = "#eed49f"
   clrs.ylw_d = "#dfbf7d"
   clrs.blu   = "#8aadf4"
   clrs.blu_d = "#7690c5"
   clrs.mag   = "#f5bde6"
   clrs.mag_d = "#dda1cd"
   clrs.cya   = "#8bd5ca"
   clrs.cya_d = "#76bbb1"

   clrs.wall   = asst_dir .. "default/walls/catppuccin.png"
   clrs.player = asst_dir .. "default/player/catppuccin.png"
return clrs
