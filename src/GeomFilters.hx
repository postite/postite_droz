//import com.nodename.delaunay.Voronoi;
//import com.nodename.geom.LineSegment;
import hxClipper.Clipper;
import CoolPoint;

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

	public static function clipOff(segs:Array<Point>,scale:Float=10.0) {
		//var scale = 10.0;
		var dist=1.0;
		 var ints = [];
		segs.map(function(seg) {
			ints.push(cast Std.int(seg.x));
			ints.push(cast Std.int(seg.y));
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
		return solution;
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


}
