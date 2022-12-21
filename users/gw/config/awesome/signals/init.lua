------------------
-- signal files --
------------------

require('signals.volume')
require('signals.network')
require('signals.bluetooth')
require('signals.brightness')
-- If the user has enabled battery metrics,
-- then emit battery signal.
if battery then
    require('signals.battery')
end
