import utest.Assert;
import Coords.Coords;
import postite.geom.CoolPoint;
import postite.geom.Geste;

using TestGesteStatics;
using Lambda;

class TestGesteStatics extends utest.Test {
	static var path:Points;
	static var p1:Point = {x: 100, y: 200};
	static var p2:Point = {x: 300, y: 400};
	static var seg = [p1, p2];
	static var rec = [{x: 0, y: 0}, {x: 100, y: 0}, {x: 100, y: 100}, {x: 0, y: 100}, {x: 0, y: 0},];

	// synchronous setup
	public function setup() {
		var field = "some";
		path = Coords.small;
	}

	function testTest() {
		Assert.isTrue(1 == 1);
	}

	function testDeg2Rad() {
		var p = Geste.Deg2Rad(45.0);
		Assert.floatEquals(0.785398, p);
	}

	function testDistance() {
		var d = Geste.Distance(p1, p2);
		Assert.floatEquals(282.84, d, 1e-2);
	}

	function testPathLength() {
		var p = Geste.PathLength([p1, p2]);
		Assert.floatEquals(282.84, p, 1e-2);
	}

	function testPathDistance() {
		var p = Geste.PathDistance([p1, p2], Geste.TranslateTo(seg,{x:400,y:400}));
		Assert.floatEquals(223.60679774997897, p, 1e-2);
	}

	function testBound() {
		var r = Geste.BoundingBox(cast rec);
		Assert.same({
			x: 0,
			y: 0,
			width: 100,
			height: 100
		}, r);
	}

	function testCentroid() {
		var p = Geste.Centroid([p1, p2]);
		Assert.same({x: 200, y: 300}, p);
	}

	function testDistanceAtAngle() {
		var dis = Geste.DistanceAtAngle(seg, {Points: seg}, 45);
		Assert.equals(137.79376055283058, dis);
	}

	function testBestDistanceAtAngle() {
		var r = Geste.DistanceAtBestAngle(seg, {Points: seg}, 45.0, 90.0, 1.0);
		Assert.equals(7.265398696948875, r);
	}

	function testRotateBy() {
		var r = Geste.RotateBy(seg, 45.0);
		Assert.same(r[0], {
			x: 232.55815357163885,
			y: 162.37744866481518
		});
	}

	function testOptimalCosineDistance() {
		var o = Geste.OptimalCosineDistance([0, 1], [1, 0]);
		Assert.floatEquals(0, o);
	}

	function testVectorize() {
		var v = Geste.Vectorize(seg);
		Assert.isTrue(v.length > 1);
	}

	function testTranslateTo() {
		var t = Geste.TranslateTo(seg, {x: 350, y: 350});
		Assert.same([{
			x: 250,
			y: 250
		},{
				x: 450,
				y: 450
			}], t);
	}

	function testScaleTo() {
		var s = Geste.ScaleTo(rec, 300);

		var upPoint = getMaxPoint(s);
		var up = Math.min(upPoint.x, upPoint.y);
		Assert.equals(300, up);
	}

	function testIndicativeAngle() {
		var ind = Geste.IndicativeAngle(seg);
		Assert.floatEquals(0.7853981633974483, ind);
	}

	function testresample() {
		var t = seg.copy();
		var r = Geste.Resample(t, 3);
		Assert.equals(3, r.length);
	}

	function testresamplebiggerArray() {
		var v = seg.copy();
		v = Geste.TranslateTo(v, {x: 700, y: 600});
		var t = seg.copy();
		var con = t.concat(v);

		var r = Geste.Resample(con, 3);

		Assert.equals(4, con.length);
		Assert.equals(3, r.length);
	}

	public function testResampleSimple() {
		var dix = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10].toPoints();
		var n = Geste.Resample(dix, 20);
		Assert.equals(20, n.length);
		Assert.equals(dix[0], n[0]);
		// Assert.equals(n[n.length-1],dix[dix.length-1]);
	}

	static function getMaxPoint(rr:Points):Point {
		var getMax = function(a:Point, b:Point) {
			if (a.x > b.x || a.y > b.y)
				return a;

			return b;
		}
		return rr.fold(getMax, rr[0]);
	}

	public static function toPoints(val:Array<Int>)
		return val.map(p -> {x: p, y: p});
}
