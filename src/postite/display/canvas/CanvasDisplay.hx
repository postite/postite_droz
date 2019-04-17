package postite.display.canvas;

import js.Browser.document as doc;
import js.html.*;
import postite.display.*;

typedef IRenderCan = IRenderable<CanvasRender>;

class CanvasDisplay {
	var _can:CanvasElement;
	var raf:(Float->Void)->Void;
	var paused:Bool=false;
	public var onFrame:Int->Void;
	public var canvas(get, never):CanvasElement;

	public function get_canvas():CanvasElement {
		if (_can == null)
			this.createCanvas();
		return _can;
	}

	var display:Display<CanvasRender>;

	public function new() {
		display = new Display(new CanvasRender(createCanvas()));
	}

	// animating stuff
	public function enterframe(fps) {
		// var fps, fpsInterval, startTime, now, then, elapsed;
		var elapsed;
		var fpsInterval = 1000 / fps;
		var then = Date.now();
		var now;
		var startTime = then;
		trace(startTime);
	var frame:Int=0;
		var frameCount = 0;
		raf = js.Browser.window.requestAnimationFrame;
		var stop = false;

		function animate(?timestamp:Float) {
			if (paused) {
				return;
			}
			
			raf(animate);

			now = Date.now();
			elapsed = now.getTime() - then.getTime();

			if (elapsed > fpsInterval) {
				// Get ready for next frame by setting then=now, but...
				// Also, adjust for fpsInterval not being multiple of 16.67
				then = Date.fromTime(now.getTime() - (elapsed % fpsInterval));
				onFrame(Std.int(++frame));
				display.render();
			}
		}
		onFrame=function(f){
			
		}
		raf(animate);
	}

	public function togPause(){
		trace( "paused="+paused);
		paused=!paused;
		if( !paused )
		raf(null);

		
	}



	// composition
	public function clearRenderables()
		display.clearRenderables();

	public function addRenderable(renderable:IRenderCan)
		display.addRenderable(renderable);

	public function removeRenderable(renderable:IRenderCan)
		display.removeRenderable(renderable);

	public function render(){
		display.render();
	}

	function createCanvas():CanvasElement {
		trace("create canvas");
		_can = doc.createCanvasElement();
		_can.width = js.Browser.window.innerWidth;
		_can.height = js.Browser.window.innerHeight;
		doc.body.appendChild(_can);
		return _can;
	}
	public function remove(){
		_can.remove();
		_can=null;
	}
}
