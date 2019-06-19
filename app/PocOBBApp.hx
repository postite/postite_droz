package app;


import js.Browser.document as doc;
import postite.display.canvas.CanvasDisplay;
import js.html.CanvasRenderingContext2D;

// import interact.KeyBoardManager;
// import interact.KeyCode as K;

// import croqmur.Croq;
// import croqmur.CoolPoint;
// import tablet.Tablet;


class PocOBBApp
 {

	public function new() {
		trace( "new pocobapp");
		

		var disp= new CanvasDisplay();
		disp.enterframe(12);
		
		
		//mock.enabled=false;
		// var colo=new ColTest();
		// disp.addRenderable(colo);
		var obb = new OBB();
		disp.addRenderable(obb);
		// var display = new CanvasRender(can);
		// var mock = new MockFlock(null,can);
		// display.addRenderable(mock);

		// function step(timestamp:Float) {
		// 	// trace("hop");
		// 	display.render();
		// 	//raf(step);
		// }

		// raf(step);

       // KB.addListener(Shift,croc.memoize);

		//new interact.Keynote();
	}

	public static function main() {
		new PocOBBApp();
	}
}

