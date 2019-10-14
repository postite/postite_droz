package app;


import js.Browser.document as doc;
import postite.display.canvas.CanvasDisplay;
import js.html.CanvasRenderingContext2D;

// import interact.KeyBoardManager;
// import interact.KeyCode as K;

// import croqmur.Croq;
// import croqmur.CoolPoint;
// import tablet.Tablet;


class App {
	
	var raf:(Float->Void)->Int;

	

	public function new() {
		trace( "new Appli");
		// "opo".log();
		// var can = doc.createCanvasElement();
		// can.width = 800;
		// can.height = 800;
		// doc.body.appendChild(can);
		// raf = js.Browser.window.requestAnimationFrame;

		var disp= new CanvasDisplay();
		disp.enterframe(12);
		var mock = new MockFlock(null,disp.canvas);
		mock.enabled=true;
		disp.addRenderable(mock);
		//mock.enabled=false;
		var colo=new ColTest();
		disp.addRenderable(colo);

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
		new App();
	}
}

