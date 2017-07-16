using Toybox.Graphics as Gfx;
using Toybox.WatchUi as Ui;

class DualityView extends Ui.WatchFace {
	var time  = new TimeDisplay();
	var layout = new Layout(); 
	
    function initialize() {
        WatchFace.initialize();
    }

    //! Load your resources here
    function onLayout(dc) {
        
    }

    //! Called when this View is brought to the foreground. Restore
    //! the state of this View and prepare it to be shown. This includes
    //! loading resources into memory.
    function onShow() {
    }

    //! Update the view
    function onUpdate(dc) {
    	resetScreen(dc);
    	time.displayTime(dc);
    	layout.displayInfo(dc);
    }
    
    function resetScreen(dc) {
    	dc.setColor(Color.getBackgroundColor(), Color.getBackgroundColor());
		dc.clear();
		dc.setColor(Color.getPrimaryColor(), Gfx.COLOR_TRANSPARENT);
    }

    //! Called when this View is removed from the screen. Save the
    //! state of this View here. This includes freeing resources from
    //! memory.
    function onHide() {
    }

    //! The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep() {
    }

    //! Terminate any active timers and prepare for slow updates.
    function onEnterSleep() {
    }

}