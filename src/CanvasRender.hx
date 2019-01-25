import js.html.CanvasRenderingContext2D;


class CanvasRender{
	var map:Map<IRenderable, Bool>;
	public var canvas:js.html.CanvasElement;
public var dims:{width:Int,height:Int};

	public function new(can:js.html.CanvasElement) {
		map = new Map();
		canvas = can;
		dims={width:canvas.width, height:canvas.height};
		this.ctx = can.getContext2d();
		this.ctx.save();
	}

	public function addRenderable(ir:IRenderable) {
		map.set(ir, true);
	}

	public function clear() {
		ctx.clearRect(0, 0, canvas.width, canvas.height);
	}

	public function render() {
		this.clear();
		for (renderable in map.keys()) {
			if (renderable.enabled) {
				// renderEngine.beforeEach();
			//	ctx.save();
				renderable.render(this);
				
			//	ctx.restore();
				// renderEngine.afterEach();
			}
		}
	}

	public var ctx:js.html.CanvasRenderingContext2D;
}

interface IRenderable {
	public var enabled:Bool;
	public function render(ctx:CanvasRender):Void;
}
