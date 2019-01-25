package postite.geom;
import postite.geom.CoolPoint;

//borowed from heaps.h2d.PolyGon

@:forward(push, remove, insert, copy)
abstract Polygon(Array<Point>) from Array<Point> to Array<Point> {
	@:noDebug
	public var points(get, never):Array<Point>;
	public var length(get, never):Int;

	inline function get_length()
		return this.length;

	inline function get_points()
		return this;

	public inline function new(?points) {
		this = points == null ? [] : points;
	}

	// public inline function iterator() {
	// 	return new hxd.impl.ArrayIterator(this);
	// }

    //see Monotone_chain convex hull algorithm
	public function convexHull() {
		var len = points.length;
		if( points.length < 3 )
			return points;

		points.sort(xSort);

		var hull = [];
		var k = 0;
		for (p in points) {
			while (k >= 2 && side(hull[k - 2], hull[k - 1], p) <= 0)
				k--;
			hull[k++] = p;
		}

	   var i = points.length - 2;
	   var len = k + 1;
	   while(i >= 0) {
			var p = points[i];
			while (k >= len && side(hull[k - 2], hull[k - 1], p) <= 0)
				k--;
			hull[k++] = p;
			i--;
	   }

	   while( hull.length >= k )
			hull.pop();
	   return hull;
}
inline function xSort(a : Point, b : Point) {
		if(a.x == b.x)
			return a.y < b.y ? -1 : 1;
		return a.x < b.x ? -1 : 1;
}
	public function contains(p:Point, isConvex = false) {
		if (isConvex) {
			var p1 = points[points.length - 1];
			for (p2 in points) {
				if (side(p1, p2, p) < 0)
					return false;
				p1 = p2;
			}
			return true;
		} else {
			var w = 0;
			var p1 = points[points.length - 1];
			for (p2 in points) {
				if (p2.y <= p.y) {
					if (p1.y > p.y && side(p2, p1, p) > 0)
						w++;
				} else if (p1.y <= p.y && side(p2, p1, p) < 0)
					w--;
				p1 = p2;
			}
			return w != 0;
		}
	}

	inline function side(p1:Point, p2:Point, t:Point) {
		return (p2.x - p1.x) * (t.y - p1.y) - (p2.y - p1.y) * (t.x - p1.x);
	}
}
