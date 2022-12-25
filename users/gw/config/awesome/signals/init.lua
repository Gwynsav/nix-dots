------------------
-- signal files --
------------------

require('signals.volume')
require('signals.network')
require('signals.bluetooth')

-- If the user has enabled brightness metrics,
-- then emit brightness signal.
if brightness then
    require('signals.brightness')
end

-- If the user has enabled battery metrics,
-- then emit battery signal.
if battery then
    require('signals.battery')
end
