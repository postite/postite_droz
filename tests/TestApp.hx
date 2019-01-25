


import js.Browser.document as doc;
import CanvasRender;
import js.html.CanvasRenderingContext2D;

import postite.geom.CoolPoint;
import postite.geom.GeomFilters;
import postite.geom.PolyGon;
import postite.geom.Simplify;
import CanvasRender;
import postite.geom.Calc;
using Dro;
import postite.geom.Segment;



class TestVrac implements IRenderable{

	var can:js.html.CanvasElement;
	public var enabled=true;
	public function new(dims, can){
		this.can = can;

	}

	public function render(r:CanvasRender){
		var seg=new Segment({x:20.0,y:10.0},{x:210.0,y:220.0});
		r.ctx.droSegments([seg]);

		var pt=new CoolPoint(20, 130,10);
		r.ctx.droPoint(pt);
		trace(seg.side(pt));

	}
}

class TestApp{
    	var raf:(Float->Void)->Int;

	

	public function new() {
		trace( "new Appli");
		var can = doc.createCanvasElement();
		can.width = 800;
		can.height = 800;
		doc.body.appendChild(can);
		raf = js.Browser.window.requestAnimationFrame;

		

		var display = new CanvasRender(can);
		var mock = new TestVrac(null,can);
		display.addRenderable(mock);

		function step(timestamp:Float) {
			// trace("hop");
			display.render();
			//raf(step);
		}

		raf(step);

       // KB.addListener(Shift,croc.memoize);

		//new interact.Keynote();
	}

	public static function main() {
		new TestApp();
	}
}

