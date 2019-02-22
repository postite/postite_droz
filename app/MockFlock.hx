package app;


import postite.geom.CoolPoint;
import postite.geom.GeomFilters;
import postite.geom.PolyGon;
import postite.geom.Simplify;
import postite.display.canvas.CanvasRender;
import postite.math.Matools;
import postite.geom.Geste;
using postite.dro.Dro;
import postite.dro.Coords;
import postite.dro.*;

class MockFlock implements postite.display.canvas.CanvasDisplay.IRenderCan {
	static var offseting:Bool = false;
	static var bounding:Bool = false;

	var can:js.html.CanvasElement;

	static var coolPoints:Array<CoolPoint>;
	static var points:Array<Point>;

	public var enabled = true;

	var rect:Rect;
	var listen:Hit;
	var hullPol:Polygon;

	public function new(dims, can) {
		this.can = can;
		init();
	}

	public function init() {
		coolPoints = [for (a in 0...100) {x: Std.random(600) *1.0, y: Std.random(300) + 100.0, press: 10.0}];

		// points=coolPoints.map(cp->(cp:Point));

		listen = Hit.instance;
		listen.init(can);
		listen.clickSign.handle(mouse -> {
			trace("inside rect " + GeomFilters.isInsideRect(mouse, rect));
			// trace( "inside poly" + GeomFilters.inPoly(hull.length,GeomFilters.toPoints(hull),mouse));

			//	trace( "isinside polymouse" + GeomFilters.pnPoly(mouse,{x:0.0,y:0.0},rectarray));
			// trace( "isinside poly" + GeomFilters.pnPoly(mouse,{x:0.0,y:0.0},GeomFilters.toPoints(hull)));
			// trace('pol='+Pol.contains(mouse));
			// trace('polo='+Polo.contains(mouse,true));
			trace('pulo=' + hullPol.contains(mouse, true));
		});

		listen.pointSign.handle(cpoint -> trace('oui ma point $cpoint'));
		for (cpoint in coolPoints) {
			listen.observe(cpoint);
		}
		update();
	}

	public function update() {
		coolPoints = coolPoints.map(cp -> {
			x: cp.x + Matools.getRandomInt(-5, 5),
			y: cp.y + Matools.getRandomInt(-5, 5),
			press: cp.press
		});

		points = coolPoints.map(cp -> (cp : Point));
		rect = GeomFilters.boundRectForPoly(points);

		/// hullconvex
		var poto:Polygon = points;
		var hull = poto.convexHull();
		hullPol = hull;
	}

	public function render(_render:CanvasRender) {
		/*for (point in coolPoints)
			_render.ctx.droPoint(point, "#cc3300");
*/
		if (offseting) {
			var offset = GeomFilters.clipOff(hullPol, 30);
			_render.ctx.droPaths(cast offset, "#cc3300");
		}

		if (bounding)
			_render.ctx.droRect(rect);

		/*
		var rectarray = GeomFilters.rectToArray(rect);
		_render.ctx.drawPoly(rectarray, "#00aaff");
		*/
		// render.ctx.drawPoly(hulo,"#cc3300");
		
		var path = Coords.path;
		 var pathPoints:Array<Point>=path.map(a->{x:a.x*1.0,y:a.y*1.0});
		//var simple=Simplify.simplify(pathPoints,40);
		var sim1=GeomFilters.isClosed(pathPoints);
		_render.ctx.drawPoly(pathPoints);
		trace(sim1);
		 if( sim1!=null)
		 _render.ctx.droPoint(new CoolPoint(sim1.x,sim1.y,10),"#00AAFF");
		
		//_render.ctx.drawPoly(pathPoints,"#cc3300");
		//_render.ctx.drawPoly(simple,"#00AAFF");

		var closed=Coords.closed.map(a->{x:a.x*1.0,y:a.y*1.0});
		var sim:PressPoint=GeomFilters.isClosed(closed);
		
		_render.ctx.drawPoly(closed);
		//_render.ctx.drawPoly(sim,"#00AAFF");
		_render.ctx.droPoint(new CoolPoint(sim.x,sim.y,10),"#00AAFF");
		/*
		var simplePol=Simplify.simplify(hullPol,40);
		_render.ctx.drawPoly(hullPol,"#cc3300");
		*/

		/*
		_render.ctx.drawPoly(simplePol,"#00AAFF");
		var offset2 = GeomFilters.clipOff(simplePol, 40);
			_render.ctx.droPaths(cast offset2, "#cc3300");
		*/
		_render.clear();
		var con:Points=[{x: 100,y: 200},{x: 600,y: 400},{x: 300,y: 500},{x: 400,y: 700}];
		_render.ctx.drawPoly(con);
		var tra=Geste.TranslateTo(con,{x:400,y:200});
		_render.ctx.drawPoly(tra,"#00aaff");

		var centr= Geste.Centroid(tra);
		_render.ctx.droPoint(centr);

		var centro= Geste.Centroid(con);
		_render.ctx.droPoint(centro);

		_render.ctx.droPoint({x:400,y:200,press:10},Couleur.Rouge);

		//update();
	}

	
}
