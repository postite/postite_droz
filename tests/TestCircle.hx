package tests;

import postite.geom.Circle;
import utest.Assert;
import postite.geom.CoolPoint;
import postite.geom.Circle;
import postite.geom.units.Degree;

class TestCircle extends utest.Test {
	function testcreateCircle() {
		var circ = new Circle(0, 0, 10);
		Assert.equals(10, circ.ray);
	}

	function testCollideCircle() {
		var circ = new Circle(0, 0, 10);
		var circ2 = new Circle(5, 5, 10);
		var circ3 = new Circle(100, 100, 10);
		Assert.isTrue(circ.collideCircle(circ2));
		Assert.isFalse(circ.collideCircle(circ3));
	}

	function testlineIntersectCircle() {
		var circ = new Circle(0, 0, 10);

		Assert.same([new Point(0, -10), new Point(0, 10)], circ.lineIntersect(new Point(0, -20), new Point(0, 20)));
	}

	function testContains() {
		var circ = new Circle(0, 0, 10);
		var pt = new Point(5, 8);
		Assert.isTrue(circ.contains(pt));
	}

	function testPointsInCircle() {
		var circ = new Circle(0, 0, 10);
		var r:Degree = 90;
		var rt = circ.pointInCircle(r);
		Assert.equals(90, rt.rotation);
	}
}
