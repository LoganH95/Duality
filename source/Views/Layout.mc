using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Application as App;

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

class Layout {
	hidden var width, height; 
	hidden var symbol;
	
	function initialize() {
		symbol = new Symbol();
    }
    
    function displayInfo(dc) {
    	width = dc.getWidth();
    	height = dc.getHeight();
    	var layout = App.getApp().getProperty("layout");
    	var inverter = App.getApp().getProperty("id_invert");
    	dc.setColor(Color.getPrimaryColor() , Gfx.COLOR_TRANSPARENT);
    	
        switch (layout) {
    		case classic_type:
    			classic(dc, inverter);
    			break;
    		
			case classicBig_type:
				classicBig(dc, inverter);
				break;
				
			case minimal_type:
				minimal(dc);
				break;
		
			case minimalIcons_type:
				minimal(dc); 
    			cornerIcons(dc, inverter);
				break;
			
			case corners_type:
				corners(dc, inverter);
				break;
			
			case minimalExpanded_type:
				minimalExpanded(dc, inverter); 
				break;
			
			case minimalBattery_type:
				minimalBattery(dc);
				break; 
				
			case expanded_type:
				expanded(dc, inverter); 
				break;
				
			case line_type:
				line(dc);
				break;
    	}
    }
    
    hidden function classic(dc, inverter) {
	  	drawTable(dc);
    	StatsDisplay.drawDate(dc, width/2, 3*height/4 - 13, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_CENTER);
		StatsDisplay.drawBattery(dc, width/2 - 15, 3*height/4 + 12, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_RIGHT);
		StatsDisplay.drawSteps(dc, width/2 - 2, 3*height/4 + 12, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_LEFT);
		symbol.drawBluetooth(dc, 3*width/4 + 1, 3*height/4 - 6, inverter);
		symbol.drawNotification(dc, 3*width/4 + 12, 3*height/4 - 8, inverter);
    }
    
    hidden function classicBig(dc, inverter) {
		drawTableBig(dc); 
    	StatsDisplay.drawDate(dc, width/2, 3*height/4 - 13, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_CENTER); 
		StatsDisplay.drawBattery(dc, width/2 - 5, 3*height/4 + 12, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT);
		StatsDisplay.drawSteps(dc, width/2 + 5, 3*height/4 + 12, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_LEFT);
		symbol.drawBluetooth(dc, 3*width/4 + 2, 3*height/4 - 7, inverter);
		symbol.drawNotification(dc, 3*width/4 + 13, 3*height/4 - 9, inverter);
    }
    
    hidden function minimal(dc) {
		if (Sys.getDeviceSettings().screenShape == 2) {
			StatsDisplay.drawDate(dc, width/2, -2, Gfx.FONT_LARGE, Gfx.TEXT_JUSTIFY_CENTER);
		}
		else {
			StatsDisplay.drawDate(dc, width/2, -3, Gfx.FONT_LARGE, Gfx.TEXT_JUSTIFY_CENTER);
		}
    }
    
    hidden function corners(dc, inverter) {
    	cornerIcons(dc, inverter); 
		if (Sys.getDeviceSettings().screenShape == 2) {
			StatsDisplay.drawDate(dc, 192, 135, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT); 
			StatsDisplay.drawBattery(dc, 192, 17, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT); 
			StatsDisplay.drawSteps(dc, 20, 135, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_LEFT); 
		}
		else {
			StatsDisplay.drawDate(dc, 203, 125, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT); 
			StatsDisplay.drawBattery(dc, 203, -3, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT); 
			StatsDisplay.drawSteps(dc, 0, 125, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_LEFT); 
		}
    }
    
    hidden function cornerIcons(dc, inverter) {
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
			StatsDisplay.drawDate(dc, width/2, -2, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_CENTER); 
			StatsDisplay.drawBattery(dc, 195, 17, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT); 
		}
		else {
			StatsDisplay.drawDate(dc, width/2, -3, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_CENTER); 
			StatsDisplay.drawBattery(dc, 205, -3, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_RIGHT); 
		}
	}
	
	hidden function expanded(dc, inverter) {
		minimalExpanded(dc, inverter);
	    if (Sys.getDeviceSettings().screenShape == 2) {
	    	StatsDisplay.drawSteps(dc, width/2, height - 30, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_CENTER);
		} 
		else {
			StatsDisplay.drawSteps(dc, width/2, height - 25, Gfx.FONT_MEDIUM, Gfx.TEXT_JUSTIFY_CENTER);
		}
	}
	
	hidden function line(dc) {
		var adjust = 0; 
		if (Sys.getDeviceSettings().screenShape == 2) {
			adjust = 6; 
		}
		dc.drawLine(width/2, height/2 + 25 + adjust, width/2, height/2 + 73 + adjust);
		StatsDisplay.drawDate(dc, width/2, height/2 + 6 + adjust, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_CENTER); 
		StatsDisplay.drawBattery(dc, width/2 - 7, height/2 + 22 + adjust, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_RIGHT); 
		StatsDisplay.drawStepsGoal(dc, width/2 - 7, height/2 + 39 + adjust, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_RIGHT);
		StatsDisplay.drawDistance(dc, width/2 - 7, height/2 + 56 + adjust, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_RIGHT);
		StatsDisplay.drawCalories(dc, width/2 + 7, height/2 + 22 + adjust, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_LEFT);
		StatsDisplay.drawMessages(dc, width/2 + 7, height/2 + 39 + adjust, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_LEFT);
		StatsDisplay.drawConnected(dc, width/2 + 7, height/2 + 56 + adjust, Gfx.FONT_SMALL, Gfx.TEXT_JUSTIFY_LEFT);
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