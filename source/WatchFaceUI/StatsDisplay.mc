using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Calendar;
using Toybox.Application as App;
using Toybox.ActivityMonitor;

class StatsDisplay {

	static function drawDate(dc, x, y, font, justification) {
		var date = Calendar.info(Time.now(), Time.FORMAT_MEDIUM);
		var dateFormat = App.getApp().getProperty("dateFormat");
		var dateString; 
		if (!dateFormat) {
			dateString = Lang.format("$1$ $2$ $3$" , [date.day_of_week, date.month, date.day]);
		  	if (date.day_of_week.equals("Thurs") || date.day_of_week.equals("Thur")) {
				dateString = Lang.format("$1$ $2$ $3$" , ["Thu", date.month, date.day]);
			}
		} else {
			dateString = Lang.format("$1$ $2$ $3$" , [date.day_of_week, date.day, date.month]);
		  	if (date.day_of_week.equals("Thurs") || date.day_of_week.equals("Thur")) {
				dateString = Lang.format("$1$ $2$ $3$" , ["Thu", date.day, date.month]);
			}
		}
		dc.drawText(x, y, font, dateString, justification);
	}
	
	static function drawBattery(dc, x, y, font, justification) {
		var batteryString = Lang.format("$1$%", [Sys.getSystemStats().battery.toNumber()]);
		dc.drawText(x, y, font, batteryString, justification);
	}
	
	static function drawSteps(dc, x, y, font, justification) {
		var stepString = Lang.format("$1$", [ActivityMonitor.getInfo().steps]);
		dc.drawText(x, y, font, stepString, justification);
	}
	
	static function drawStepsGoal(dc, x, y, font, justification) {
		var stepString = Lang.format("$1$/$2$", [ActivityMonitor.getInfo().steps, ActivityMonitor.getInfo().stepGoal]);
		dc.drawText(x, y, font, stepString, justification);
	}
	
	static function drawDistance(dc, x, y, font, justification) {
		var distanceString; 
		if (Sys.getDeviceSettings().distanceUnits == Sys.UNIT_METRIC) {
			var distance = ActivityMonitor.getInfo().distance.toDouble() / 100000.toFloat(); 
			distanceString = Lang.format("$1$ km", [distance.format("%.2f")]);
		}
		else {
			var distance = ActivityMonitor.getInfo().distance.toDouble() * .0000062137119.toFloat();
			distanceString = Lang.format("$1$ mi", [distance.format("%.2f")]);
		}
		dc.drawText(x, y, font, distanceString, justification);
	}
	
	static function drawConnected(dc, x, y, font, justification) {
		var connection; 
		if (Sys.getDeviceSettings().phoneConnected) {
			connection = "connected"; 
		} else {
			connection = "disconnected"; 
		}
		dc.drawText(x, y, font, connection, justification);
	}
	
	static function drawMessages(dc, x, y, font, justification) {
		var message = "messages"; 
		if (Sys.getDeviceSettings().notificationCount == 1) {
			message = "message"; 
		}
		var messageString =  Lang.format("$1$ $2$", [Sys.getDeviceSettings().notificationCount, message]);
		dc.drawText(x, y, font, messageString, justification);
	}
	
	static function drawCalories(dc, x, y, font, justification) {
		var calorieString = Lang.format("$1$ C" , [ActivityMonitor.getInfo().calories]);
		dc.drawText(x, y, font, calorieString, justification);
	}
}