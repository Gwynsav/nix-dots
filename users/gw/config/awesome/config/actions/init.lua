------------------------
-- lua action scripts --
------------------------
-- 'Actions' are scripts that produce notifications whenever a change in 
-- their associated signal is detected. However, they are limited to the
-- same rate at which the signal is produced. In other words, you cannot
-- produce an action more often than the signal associated to it is emitted.

require('config.actions.volume')
require('config.actions.playerctl')
require('config.actions.network')
require('config.actions.language')
if bluetoothctl then
    require('config.actions.bluetooth')
end
if brightness then
    require('config.actions.brightness')
end
