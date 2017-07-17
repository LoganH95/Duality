using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;

class TimeDisplay {
	hidden var width; 
	hidden var height;
	
    function displayTime(dc) {
    	width = dc.getWidth();
    	height = dc.getHeight();
    	var layout = App.getApp().getProperty("layout");
    	var adjust = 20; 
    	switch (layout) {
    		case classic_type:
    		case classicBig_type:
    			adjust = 0;
    			break;
    		case corners_type:
    			adjust = 15;
    			break;
    		case line_type:
    			adjust = Sys.getDeviceSettings().screenShape == Sys.SCREEN_SHAPE_SEMI_ROUND ? -10 : -15;
    			break;
    	}
    	drawHours(dc, adjust);
    	drawMinutes(dc, adjust); 
    }
    
    hidden function hourString() {
    	var hourString = new [5]; 
    	var clockTime = Sys.getClockTime(); 
    	if (!Sys.getDeviceSettings().is24Hour) {
			for (var i = 0; i < 5; i++) {
				if ((clockTime.hour - 2 + i) > 12) {
					var time = (clockTime.hour - 2 + i - 12);
					if (time > 12) {
						time -= 12; 
					}
					hourString[i] = Lang.format("$1$", [time]);
				} else {
					var time = (clockTime.hour - 2 + i);
					if (time <= 0) {
						time += 12;
					}
					hourString[i] = Lang.format("$1$", [time]);
				}
			}
		} else {
			for (var i = 0; i < 5; i++){
				var time = clockTime.hour - 2 + i;
				if (time < 0) {
					time += 24; 
				} else if (clockTime.hour - 2 + i > 23) {
					time -= 24; 
				}
				hourString[i] = Lang.format("$1$", [time.format("%02d")]);
			}
		}
		return hourString; 
    }
    
    hidden function minString() {
    	var minString = new [5]; 
    	var clockTime = Sys.getClockTime(); 
    	for (var i = 0; i < 5; i++) {
			var time = clockTime.min - 2 + i;
			
			if (time > 59){
				time -= 60;
			} else if (time < 0) {
				time += 60;
			}
			minString[i] = Lang.format("$1$", [time.format("%02d")]);
		}
		return minString;  
    }
    
    hidden function drawHours(dc, adjust) {
    	var hourString = hourString(); 
    	dc.drawText(width/3 - 5, 25 + adjust, Gfx.FONT_MEDIUM, hourString[1], Gfx.TEXT_JUSTIFY_CENTER);
		dc.drawText(width/2, 15 + adjust, Gfx.FONT_NUMBER_HOT, hourString[2], Gfx.TEXT_JUSTIFY_CENTER);
		dc.drawText(2*width/3 + 5, 25 + adjust, Gfx.FONT_MEDIUM, hourString[3], Gfx.TEXT_JUSTIFY_CENTER);
		
		dc.setColor(Color.getTertiaryColor(), Gfx.COLOR_TRANSPARENT);
		dc.drawText(width/4 - 25, 25 + adjust, Gfx.FONT_MEDIUM, hourString[0], Gfx.TEXT_JUSTIFY_CENTER);
		dc.drawText(3*width/4 + 25, 25 + adjust, Gfx.FONT_MEDIUM, hourString[4], Gfx.TEXT_JUSTIFY_CENTER);
    }
    
    hidden function drawMinutes(dc, adjust) {
    	var minString = minString(); 
    	dc.drawText(width/4 - 25, 70 + adjust, Gfx.FONT_MEDIUM, minString[0], Gfx.TEXT_JUSTIFY_CENTER);
		dc.drawText(3*width/4 + 25, 70 + adjust, Gfx.FONT_MEDIUM, minString[4], Gfx.TEXT_JUSTIFY_CENTER);
		
		dc.setColor(Color.getPrimaryColor(), Gfx.COLOR_TRANSPARENT);
		dc.drawText(width/3 -5, 70 + adjust, Gfx.FONT_MEDIUM, minString[1], Gfx.TEXT_JUSTIFY_CENTER);
		dc.drawText(2*width/3 + 5, 70 + adjust, Gfx.FONT_MEDIUM, minString[3], Gfx.TEXT_JUSTIFY_CENTER);
		
        dc.setColor(Color.getSecondaryColor(), Gfx.COLOR_TRANSPARENT);
		dc.drawText(width/2, 60 + adjust, Gfx.FONT_NUMBER_HOT, minString[2], Gfx.TEXT_JUSTIFY_CENTER);
    }
}