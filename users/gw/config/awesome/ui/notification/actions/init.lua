--------------------------
-- Action notifications --
--------------------------

require('ui.notification.actions.volume')
require('ui.notification.actions.playerctl')
if brightness then
    require('ui.notification.actions.brightness')
end
if bluetoothctl then
    require('ui.notification.actions.bluetooth')
end
