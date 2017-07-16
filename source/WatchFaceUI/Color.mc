using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Application as App;

class Color {
    static function getPrimaryColor() {
    	var invert = App.getApp().getProperty("id_invert");
    	if (!invert) {
			return Gfx.COLOR_WHITE;
		}
		
    	return Gfx.COLOR_BLACK; 
    }
    
    static function getSecondaryColor() {
    	var secondaryColor = App.getApp().getProperty("id_color");
    	if (secondaryColor == null) {
			secondaryColor = Gfx.COLOR_RED;  
		}
		secondaryColor = checkConflictingColors(secondaryColor); 
		
    	return secondaryColor; 
    }
    
    static function checkConflictingColors(color) {
    	var invert = App.getApp().getProperty("id_invert");
    	if (!invert && color == Gfx.COLOR_BLACK) {
    		return Gfx.COLOR_WHITE; 
    	} else if (invert && color == Gfx.COLOR_WHITE) {
    		return Gfx.COLOR_BLACK; 
    	} else {
    		return color; 
    	}
    }
    
    static function getTertiaryColor() {
    	var invert = App.getApp().getProperty("id_invert");
    	if (!invert) {
			return Gfx.COLOR_LT_GRAY;
		}
    	return Gfx.COLOR_DK_GRAY; 
    }
    
    static function getBackgroundColor() {
    	var invert = App.getApp().getProperty("id_invert");
    	if (!invert) {
			return Gfx.COLOR_BLACK;
		}
    	return Gfx.COLOR_WHITE; 
    }	
}