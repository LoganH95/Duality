using Toybox.System as Sys;
using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class Symbol {
	hidden var bluetooth, invertedBluetooth, notifications, invertedNotifications;
	
	function initialize() {
		bluetooth = Ui.loadResource(Rez.Drawables.bluetooth_ID);
        invertedBluetooth = Ui.loadResource(Rez.Drawables.invertedBluetooth_ID);
        notifications = Ui.loadResource(Rez.Drawables.notifications_ID);
        invertedNotifications = Ui.loadResource(Rez.Drawables.invertedNotifications_ID);
	}
	
	function drawBluetooth(dc, x, y, inverter) {
		if (Sys.getDeviceSettings().phoneConnected && !inverter) {
			dc.drawBitmap(x, y, bluetooth);
		} else if (Sys.getDeviceSettings().phoneConnected && inverter) {
			dc.drawBitmap(x + 2, y + 1, invertedBluetooth);
		}
	}
	
	function drawNotification(dc, x, y, inverter) {
		if (Sys.getDeviceSettings().notificationCount >= 1 && !inverter) {
			dc.drawBitmap(x, y, notifications);
		} else if (Sys.getDeviceSettings().notificationCount >= 1 && inverter) {
			dc.drawBitmap(x, y + 4, invertedNotifications);
		}
	}
}