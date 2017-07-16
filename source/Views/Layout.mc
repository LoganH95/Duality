using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Time as Time;
using Toybox.Time.Gregorian as Calendar;
using Toybox.Application as App;

class Layout {
	hidden var width, height; 
	hidden var stats = new StatsDisplay(); 
	
	enum { 
		classic_type,
		classicBig_type,
		minimal_type,
		minimalIcons_type,
		corners_type,
		minimalExpanded_type,
		minimalBattery_type,
		expanded_type,
		line_type
	}

	function initialize() {
    }
    
    function displayInfo(dc) {
    	width = dc.getWidth();
    	height = dc.getHeight();
    	var layout = App.getApp().getProperty("layout");
    	var inverter = App.getApp().getProperty("id_invert");
    	dc.setColor(Color.getPrimaryColor() , Gfx.COLOR_TRANSPARENT);
    	if (layout == classic_type) {
			classic(dc, inverter);
		} else if (layout == classicBig_type) {
			classicBig(dc, inverter); 
		} else if (layout == minimal_type) {
			minimal(dc);
		} else if (layout == minimalIcons_type) {
			minimal(dc); 
    		cornerIcons(dc, inverter);
		} else if (layout == corners_type) {
			corners(dc, inverter); 
		} else if (layout == minimalExpanded_type) {
    		minimalExpanded(dc, inverter); 
		} else if (layout == minimalBattery_type) {
			minimalBattery(dc); 
		} else if (layout == expanded_type) {
			expanded(dc, inverter); 
		} else if (layout == line_type) {
			line(dc); 
		}
    }
    
    function classic(dc, inverter) {
	  	var symbol = new Symbol(); 
	  	drawTable(dc);
    	stats.drawDate(dc, width/2, 3*height/4 - 13, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_CENTER);
		stats.drawBattery(dc, width/2 - 15, 3*height/4 + 12, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_RIGHT);
		stats.drawSteps(dc, width/2 - 2, 3*height/4 + 12, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_LEFT);
		symbol.drawBluetooth(dc, 3*width/4 + 1, 3*height/4 - 6, inverter);
		symbol.drawNotification(dc, 3*width/4 + 12, 3*height/4 - 8, inverter);
    }
    
    hidden function classicBig(dc, inverter) {
	  	var symbol = new Symbol(); 
		drawTableBig(dc); 
    	stats.drawDate(dc, width/2, 3*height/4 - 13, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_CENTER); 
		stats.drawBattery(dc, width/2 - 5, 3*height/4 + 12, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT);
		stats.drawSteps(dc, width/2 + 5, 3*height/4 + 12, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_LEFT);
		symbol.drawBluetooth(dc, 3*width/4 + 2, 3*height/4 - 7, inverter);
		symbol.drawNotification(dc, 3*width/4 + 13, 3*height/4 - 9, inverter);
    }
    
    hidden function minimal(dc) {
		if (Sys.getDeviceSettings().screenShape == 2) {
			stats.drawDate(dc, width/2, -2, Gfx.FONT_LARGE, Gfx.TEXT_JUSTIFY_CENTER);
		}
		else {
			stats.drawDate(dc, width/2, -3, Gfx.FONT_LARGE, Gfx.TEXT_JUSTIFY_CENTER);
		}
    }
    
    hidden function corners(dc, inverter) {
    	cornerIcons(dc, inverter); 
		if (Sys.getDeviceSettings().screenShape == 2) {
			stats.drawDate(dc, 192, 135, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT); 
			stats.drawBattery(dc, 192, 17, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT); 
			stats.drawSteps(dc, 20, 135, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_LEFT); 
		}
		else {
			stats.drawDate(dc, 203, 125, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT); 
			stats.drawBattery(dc, 203, -3, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT); 
			stats.drawSteps(dc, 0, 125, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_LEFT); 
		}
    }
    
    hidden function cornerIcons(dc, inverter) {
    	var symbol = new Symbol();
    	if (Sys.getDeviceSettings().screenShape == 2) {
    		symbol.drawBluetooth(dc, 20, 20, inverter);
    		symbol.drawNotification(dc, 31, 18, inverter);
    	}
       	else {
       		symbol.drawBluetooth(dc, -2, 0, inverter);
       		symbol.drawNotification(dc, 9, -2, inverter);
       	}
	}
	
	hidden function minimalExpanded(dc, inverter) {
		cornerIcons(dc, inverter); 
		minimalBattery(dc); 
	}
	
	hidden function minimalBattery(dc) {
	  	if (Sys.getDeviceSettings().screenShape == 2) {
			stats.drawDate(dc, width/2, -2, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_CENTER); 
			stats.drawBattery(dc, 195, 17, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT); 
		}
		else {
			stats.drawDate(dc, width/2, -3, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_CENTER); 
			stats.drawBattery(dc, 205, -3, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT); 
		}
	}
	
	hidden function expanded(dc, inverter) {
		minimalExpanded(dc, inverter);
	    if (Sys.getDeviceSettings().screenShape == 2) {
	    	stats.drawSteps(dc, width/2, height - 30, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_CENTER);
		} 
		else {
			stats.drawSteps(dc, width/2, height - 25, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_CENTER);
		}
	}
	
	hidden function line(dc) {
		var adjust = 0; 
		if (Sys.getDeviceSettings().screenShape == 2) {
			adjust = 6; 
		}
		dc.drawLine(width/2, height/2 + 25 + adjust, width/2, height/2 + 73 + adjust);
		stats.drawDate(dc, width/2, height/2 + 6 + adjust, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_CENTER); 
		stats.drawBattery(dc, width/2 - 7, height/2 + 22 + adjust, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_RIGHT); 
		stats.drawStepsGoal(dc, width/2 - 7, height/2 + 39 + adjust, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_RIGHT);
		stats.drawDistance(dc, width/2 - 7, height/2 + 56 + adjust, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_RIGHT);
		stats.drawCalories(dc, width/2 + 7, height/2 + 22 + adjust, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_LEFT);
		stats.drawMessages(dc, width/2 + 7, height/2 + 39 + adjust, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_LEFT);
		stats.drawConnected(dc, width/2 + 7, height/2 + 56 + adjust, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_LEFT);
	}
	
	hidden function drawTable(dc) {
    	dc.drawLine(width/4, 3*height/4 + 12, 3*width/4, 3*height/4 + 12);
		dc.drawLine(width/2 - 10, 3*height/4 + 12, width/2 - 10, 3*height/4 + 30);
    }
    
    hidden function drawTableBig(dc) {
    	dc.drawLine(width/4, 3*height/4 + 12, 3*width/4, 3*height/4 + 12);
		if (Sys.getDeviceSettings().screenShape == 2) {
			dc.drawLine(width/2, 3*height/4 + 12, width/2, height - 12);
		}
		else {
			dc.drawLine(width/2, 3*height/4 + 12, width/2, height);
		}
    }
}