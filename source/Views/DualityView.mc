using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class DualityView extends Ui.WatchFace {
	hidden var time  = new TimeDisplay();
	hidden var layout = new Layout(); 
	
    function initialize() {
        WatchFace.initialize();
    }

    //! Update the view
    function onUpdate(dc) {
    	resetScreen(dc);
    	time.displayTime(dc);
    	layout.displayInfo(dc);
    }
    
    hidden function resetScreen(dc) {
    	dc.setColor(Color.getBackgroundColor(), Color.getBackgroundColor());
		dc.clear();
		dc.setColor(Color.getPrimaryColor(), Gfx.COLOR_TRANSPARENT);
    }
}