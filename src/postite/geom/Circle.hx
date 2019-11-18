package postite.geom;

// package h2d.col;
// import hxd.Math;
import postite.math.Matools;
import postite.geom.CoolPoint;
import postite.geom.units.Degree;
import postite.geom.units.Radian;
class Circle  {

	public var x : Float;
	public var y : Float;
	public var ray : Float;

	public inline function new( x : Float, y : Float, ray : Float ) {
		this.x = x;
		this.y = y;
		this.ray = ray;
	}

	public inline function distanceSq( p : Point ) {
		var dx = p.x - x;
		var dy = p.y - y;
		var d = dx * dx + dy * dy - ray * ray;
		return d < 0 ? 0 : d;
	}

	public inline function side( p : Point ) {
		var dx = p.x - x;
		var dy = p.y - y;
		return ray * ray - (dx * dx + dy * dy);
	}

	public inline function collideCircle( c : Circle ) {
		var dx = x - c.x;
		var dy = y - c.y;
		return dx * dx + dy * dy < (ray + c.ray) * (ray + c.ray);
	}

	// public inline function collideBounds( b : Rect ) {
	// 	if( x < b.xMin - ray ) return false;
	// 	if( x > b.xMax + ray ) return false;
	// 	if( y < b.yMin - ray ) return false;
	// 	if( y > b.yMax + ray ) return false;
	// 	if( x < b.xMin && y < b.yMin && Matools.distanceSq(x - b.xMin, y - b.yMin) > ray*ray ) return false;
	// 	if( x > b.xMax && y < b.yMin && Matools.distanceSq(x - b.xMax, y - b.yMin) > ray*ray ) return false;
	// 	if( x < b.xMin && y > b.yMax && Matools.distanceSq(x - b.xMin, y - b.yMax) > ray*ray ) return false;
	// 	if( x > b.xMax && y > b.yMax && Matools.distanceSq(x - b.xMax, y - b.yMax) > ray*ray ) return false;
	// 	return true;
	// }

	public inline function lineIntersect(p1 : Point, p2:Point) {
		var dx = p2.x - p1.x;
		var dy = p2.y - p1.y;
		var a = dx * dx + dy * dy;
		if (a < 1e-8) return null;
		var b = 2 * (dx * (p1.x - x) + dy * (p1.y - y));
		var c = Matools.distanceSq(p1.x - x, p1.y - y) - ray * ray;
		var d = b * b - 4 * a * c;

		if(d < 0) return null;
		if(d == 0) {
			var t = -b / (2 * a);
			return [new Point(p1.x + t * dx, p1.y + t * dy)];
		}

		var t1 = (-b - Math.sqrt(d)) / (2 * a);
		var t2 = (-b + Math.sqrt(d)) / (2 * a);
		return [new Point(p1.x + t1 * dx, p1.y + t1 * dy), new Point(p1.x + t2 * dx, p1.y + t2 * dy)];
	}

	public function toString() {
		return '{${Matools.fmt(x)},${Matools.fmt(y)},${Matools.fmt(ray)}}';
	}

	public function contains( p : Point ) : Bool {
		return distanceSq(p) == 0;
	}


   public function pointInCircle(t:Radian):RPoint{
		var  _x = ray*Math.cos(t) + x;
		var  _y = ray*Math.sin(t) + y;
		return {x:x, y:y, rotation:(t:Degree)};

	}

}