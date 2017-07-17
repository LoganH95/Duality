using Toybox.Graphics as Gfx;
using Toybox.Application as App;

class Color {

    static function getPrimaryColor() {
    	return App.getApp().getProperty("id_invert") ? Gfx.COLOR_BLACK : Gfx.COLOR_WHITE;
    }
    
    static function getSecondaryColor() {
    	var secondaryColor = App.getApp().getProperty("id_color");
    	return secondaryColor ? secondaryColor : Gfx.COLOR_RED;
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
    	return App.getApp().getProperty("id_invert") ? Gfx.COLOR_DK_GRAY : Gfx.COLOR_LT_GRAY;
    }
    
    static function getBackgroundColor() {
    	return App.getApp().getProperty("id_invert") ? Gfx.COLOR_WHITE : Gfx.COLOR_BLACK;
    }
}