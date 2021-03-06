package postite.geom;
import haxe.ds.Option;
import hxClipper.Clipper;
import postite.geom.CoolPoint;
import postite.geom.Segment;
using Lambda;
class GeomFilters {
	public function new() {}



    public static function rectToArray(rect:Rect):Array<Point>{
        var a:Array<Point>=[];
        a.push({x:rect.x,y:rect.y});
        a.push({x:rect.x+rect.width,y:rect.y});
        a.push({x:rect.x+rect.width,y:rect.y+rect.height});
        a.push({x:rect.x,y:rect.y+rect.height});
			a.push({x:rect.x,y:rect.y});
        return a;
    }
public static function growRect(r:Rect,offset:Float){
		var _x= r.x-offset;
		var _y= r.y-offset;
		var _width= r.width+offset*2;
		var _height=r.height+offset*2;
		return {x:_x,y:_y,width:_width,height:_height};
}

public static function boundingBox(points:Array<Point>):Rect
{
	var minX = Math.POSITIVE_INFINITY, maxX = Math.NEGATIVE_INFINITY, minY = Math.POSITIVE_INFINITY, maxY = Math.NEGATIVE_INFINITY;
	for (point in points) {
		minX = Math.min(minX, point.x);
		minY = Math.min(minY, point.y);
		maxX = Math.max(maxX, point.x);
		maxY = Math.max(maxY, point.y);
	}
    return {x:minX, y:minY, width:maxX - minX, height:maxY - minY}
	// return new Rectangle(minX, minY, maxX - minX, maxY - minY);
}
	 

	 public static function scaleTo(points:Points, size:Float) // non-uniform scale; assumes 2D gestures (i.e., no lines)
{
	var B = boundingBox(points);
	var newpoints = new Array();
	//for (var i = 0; i < points.length; i++) {
    for (point in points) {
		var qx = point.x * (size / B.width);
		var qy = point.y * (size / B.height);
		newpoints[newpoints.length] = new Point(qx, qy);
	}
	return newpoints;
}

	public static function clipOff(segs:Array<Point>,scale:Float=10.0):Array<Array<Point>> {
		//var scale = 10.0;
		var dist=1.0;
		 var ints = [];
		segs.map(function(seg) {
			ints.push(cast Std.int(seg.x));
			ints.push(cast Std.int(seg.y));
			return seg;
		});

		var paths = new hxClipper.Paths();
		// trace("ints="+ ints.length);
		var path = MakePolygonFromInts(ints);
		paths.push(path);

		var co = new hxClipper.Clipper.ClipperOffset();
		co.addPaths(paths, JT_MITER, ET_CLOSED_POLYGON);
		var solution = new hxClipper.Clipper.Paths();
		// solution.clear();
		co.executePaths(solution, dist * scale);
		// trace("solution="+ solution.length);
		return cast solution;
	}

	public static function unionTab(tab:Array<Points>):Array<Points>{
			var pft=PolyFillType.PFT_EVEN_ODD;
			var paths=[];
			for ( pol in tab){
					var polyint=[];
				pol.iter(function(seg){
					polyint.push(cast Std.int(seg.x));
					polyint.push(cast Std.int(seg.y));
				});
				paths.push(MakePolygonFromInts(polyint));
			}
			var c = new Clipper();

		c.addPaths(paths, PolyType.PT_SUBJECT, true);
		var solution = [];
		var res = c.executePaths(ClipType.CT_UNION, solution, pft, pft);
		return cast solution;

	}

	public static function union(PolyA:Points,PolyB:Points):Array<Points>{
		var tab=[PolyA,PolyB];
		return unionTab(tab);
	// 		 var pft=PolyFillType.PFT_EVEN_ODD;
	// 		 var PolyAInts = [];
	// 	PolyA.map(function(seg) {
			
	// 		return seg;
	// 	});

	// 		 var PolyBInts = [];
	// 	PolyB.map(function(seg) {
	// 		PolyBInts.push(cast Std.int(seg.x));
	// 		PolyBInts.push(cast Std.int(seg.y));
	// 		return seg;
	// 	});

	// 	var paths=[];
	// 	var path1= MakePolygonFromInts(PolyAInts);
	// 	var path2= MakePolygonFromInts(PolyBInts);
	// paths.push(path1);
	// paths.push(path2);
	// 	var c = new Clipper();


	// 	//c.addPaths(path1,path2.PT_SUBJECT,true);
	// 	c.addPaths(paths, PolyType.PT_SUBJECT, true);
	// 	//c.addPaths(path2, PolyType.PT_SUBJECT, true);

	// 	var solution = [];
	// 	trace( "solution");
	// 	var res = c.executePaths(ClipType.CT_UNION, solution, pft, pft);
	// 	return solution;
	}

	static private function MakePolygonFromInts(ints:Array<Int>, scale:Float = 1.0):Path {
		var i = 0;
		var p = new hxClipper.Clipper.Path();
		while (i < ints.length) {
			p.push(new hxClipper.Clipper.IntPoint(Std.int(ints[i] * scale), Std.int(ints[i + 1] * scale)));
			i += 2;
		}
		return p;
	}

	public static function boundRectForPoly(poly:Array<Point>):Rect {
		var minX = poly[0].x;
		var maxX = poly[0].y;
		var minY = poly[0].y;
		var maxY = poly[0].y;

		for (point in poly) {
			minX = Math.min(minX, point.x);
			maxX = Math.max(maxX, point.x);
			minY = Math.min(minY, point.y);
			maxY = Math.max(maxY, point.y);
		}

		var width = maxX - minX;
		var height = maxY - minY;

		return {
			x: minX,
			y: minY,
			width: width,
			height: height
		}
	}

	public static function close(pts:Array<Point>):Array<Point> {
		
		pts.push(pts[0]);
		return pts;
		//return 
		
	}

	//https://stackoverflow.com/questions/5837572/generate-a-random-point-within-a-circle-uniformly
	public static function randomInCircle(R:Float,center:Point):Point{
		var r = R * Math.sqrt(Math.random());
		var theta = Math.random() * 2 * Math.PI;


	var x = center.x + r * Math.cos(theta);
var y = center.y + r * Math.sin(theta);
return {x:x,y:y};
	}
//isPoint in circle
	public static function  pointIsInCircle( circleRadius:Float, center :Point, pt:Point):Bool
{
    return (Math.pow(pt.x - center.x, 2) + Math.pow(pt.y - center.y, 2)) < (Math.pow(circleRadius, 2));
}

	public function smoothing(){
		//https://www.codeproject.com/Articles/1093960/D-Polyline-Vertex-Smoothing
	}

	public static function isOpen(pts:Points):Bool{
		throw ' not implmented yet';
	}

	// renvoie l'intersection
	public static function isClosedAt(pts:Array<Point>,?simplify:Bool=true):Option<Point>{
		//trace( pts.length);
		if (simplify){
		var simplepts=postite.geom.Simplify.simplify(pts,5);
		var begin:Segment=new Segment(simplepts[0],simplepts[1]);

		var end:Ray= new Ray(simplepts[simplepts.length-1],simplepts[simplepts.length-2]);
		
		//trace( "begin="+begin);
		//trace(" end="+end);

		var inter=begin.lineIntersection(end);
			if (inter!=null){
				//trace(inter);
				//trace("side="+ begin.side(inter));
				return Some(inter); 
			}
		return None;
		
		}
		return None;
	}
/*
	public function segmentsIntersects(seg1:Segment,seg2:Segment):Bool{
		var a1=seg1.p1;
		var a2=seg1.p2;
		var b1=seg2.p1;
		var b2=seg2.p2;
		//function doLinesIntersect(a1:Point, a2:Point, b1:Point, b2:Point):Bool {
    // Return false if either of the lines have zero length
    if (a1.x == a2.x && a1.y == a2.y ||
        b1.x == b2.x && b1.y == b2.y){
        return false;
    }
    // Fastest method, based on Franklin Antonio's "Faster Line Segment Intersection" topic "in Graphics Gems III" book (http://www.graphicsgems.org/)
    var ax = a2.x-a1.x;
    var ay = a2.y-a1.y;
    var bx = b1.x-b2.x;
    var by = b1.y-b2.y;
    var cx = a1.x-b1.x;
    var cy = a1.y-b1.y;

    var alphaNumerator = by*cx - bx*cy;
    var commonDenominator = ay*bx - ax*by;
    if (commonDenominator > 0){
        if (alphaNumerator < 0 || alphaNumerator > commonDenominator)
            return false;
    } else if (commonDenominator < 0){
        if (alphaNumerator > 0 || alphaNumerator < commonDenominator)
            return false;
    }
    var betaNumerator = ax*cy - ay*cx;
    if (commonDenominator > 0){
        if (betaNumerator < 0 || betaNumerator > commonDenominator)
            return false;
    }else if (commonDenominator < 0){
        if (betaNumerator > 0 || betaNumerator < commonDenominator)
            return false;
    }
    if (commonDenominator == 0){
        // This code wasn't in Franklin Antonio's method. It was added by Keith Woodward.
        // The lines are parallel.
        // Check if they're collinear.
        var y3LessY1 = b1.y-a1.y;
        var collinearityTestForP3 = a1.x*(a2.y-b1.y) + a2.x*(y3LessY1) + b1.x*(a1.y-a2.y);   // see http://mathworld.wolfram.com/Collinear.html
        // If p3 is collinear with p1 and p2 then p4 will also be collinear, since p1-p2 is parallel with p3-p4
        if (collinearityTestForP3 == 0){
            // The lines are collinear. Now check if they overlap.
            if (a1.x >= b1.x && a1.x <= b2.x || a1.x <= b1.x && a1.x >= b2.x ||
                a2.x >= b1.x && a2.x <= b2.x || a2.x <= b1.x && a2.x >= b2.x ||
                b1.x >= a1.x && b1.x <= a2.x || b1.x <= a1.x && b1.x >= a2.x){
                if (a1.y >= b1.y && a1.y <= b2.y || a1.y <= b1.y && a1.y >= b2.y ||
                    a2.y >= b1.y && a2.y <= b2.y || a2.y <= b1.y && a2.y >= b2.y ||
                    b1.y >= a1.y && b1.y <= a2.y || b1.y <= a1.y && b1.y >= a2.y){
                    return true;
                }
            }
        }
        return false;
    }
    return true;
//}
	}
*/

public static function isInsideRect(p:Point, rect:Rect):Bool {
	var minX = rect.x;
	var minY = rect.y;
	var maxX = rect.width + minX;
	var maxY = rect.height + minY;

	if (p.x < minX || p.x > maxX || p.y < minY || p.y > maxY) {
		return false;
	}
	return true;
}

// https://stackoverflow.com/questions/217578/how-can-i-determine-whether-a-2d-point-is-within-a-polygon
/*
	Arguments

	nvert: Number of vertices in the polygon. Whether to repeat the first vertex at the end has been discussed in the article referred above.
	vertx, verty: Arrays containing the x- and y-coordinates of the polygon's vertices.
	testx, testy: X- and y-coordinate of the test point.

 */
//port by underdiscovery
public static function pnPoly(pt:Point, pos:Point, verts:Array<CoolPoint>) : Bool {
	
    var c : Bool = false;
    var nvert : Int = verts.length;
    var j : Int = nvert - 1;

    for(i in 0 ... nvert) {            
        
        if ((( (verts[i].y+pos.y) > pt.y) != ((verts[j].y+pos.y) > pt.y)) &&
           (pt.x < ( (verts[j].x+pos.x) - (verts[i].x+pos.x)) * (pt.y - (verts[i].y+pos.y)) / ( (verts[j].y+pos.y) - (verts[i].y+pos.y)) + (verts[i].x+pos.x)) ) {
            c = !c;
        }

        j = i;
    }

    return c;
}

public static function centroid(points:Array<Point>):Point
{
	
	var x = 0.0, y = 0.0;
	
	for (point in  points) {
		x += point.x;
		y += point.y;
	}
	x /= points.length;
	y /= points.length;
	return new Point(x, y);
}

public static function rotateBy(points:Points, radians:postite.geom.units.Radian):Points // rotates points around centroid
{
	
	var c = centroid(points);
	var cos = Math.cos(radians);
	var sin = Math.sin(radians);
	var newpoints:Points = [];
	for (point in points) {
		var qx = (point.x - c.x) * cos - (point.y - c.y) * sin + c.x;
		var qy = (point.x - c.x) * sin + (point.y - c.y) * cos + c.y;
		newpoints[newpoints.length] = new Point(qx, qy);
	}
	return newpoints;
}

//translate polygon to be centered(centroid) on pt Point.
public static function translateTo(points:Points, pt:Point):Points // translates points' centroid
{
	
	var c = centroid(points);
	var newpoints = new Array();
	for (point in points) {
		var qx = point.x + pt.x - c.x;
		var qy = point.y+ pt.y - c.y;
		newpoints[newpoints.length] = new Point(qx, qy);
	}
	return newpoints;
}


}
