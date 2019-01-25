package postite.geom;
  import postite.geom.CoolPoint;
  import haxe.ds.Vector;
   class Simplify {
    public function new() {
    }
    
    public static function getSquareDistance(p1:Point, p2:Point):Float { // square distance between 2 points
      
      var dx:Float = p1.x - p2.x, dy:Float = p1.y - p2.y;
      return dx * dx + dy * dy;
    }
    
    public static function getSquareSegmentDistance(p:Point, p1:Point, p2:Point):Float { // square distance from a point to a segment
      
      var x:Float = p1.x;
      var y:Float = p1.y;
      var dx:Float = p2.x - x;
      var dy:Float = p2.y - y;
      var t:Float;
      
      if (dx != 0 || dy != 0) {
        
        t = ((p.x - x) * dx + (p.y - y) * dy) / (dx * dx + dy * dy);
        
        if (t > 1) {
          x = p2.x;
          y = p2.y;
          
        } else if (t > 0) {
          x += dx * t;
          y += dy * t;
        }
      }
      
      dx = p.x - x;
      dy = p.y - y;
      
      return dx * dx + dy * dy;
    }
    
    // the rest of the code doesn't care for the point format
    
    
    public static function simplifyRadialDistance(points:Array<Point>, sqTolerance:Float):Array<Point> { // distance-based simplification
      
      var i;
      var len = points.length;
      var point:Point=null;
      var prevPoint:Point = points[0];
      var newPoints:Array<Point> = null;
      newPoints = [prevPoint];
      
      //for (i = 1; i < len; i++) {
      for (i in 0... len) {
        point = points[i];
        
        if (getSquareDistance(point, prevPoint) > sqTolerance) {
          newPoints.push(point);
          prevPoint = point;
        }
      }
      
      if (prevPoint != point) {
        newPoints.push(point);
      }
      
      return newPoints;
    }
    
    
    // simplification using optimized Douglas-Peucker algorithm with recursion elimination
    
    public static function simplifyDouglasPeucker(points:Array<Point>, sqTolerance:Float):Array<Point> {
      
      var len = points.length;
      
      var markers:Array<Int> = null;
      markers = new Array();
      var first = 0;
      var last = len - 1;
      
      var i:Int;
      var maxSqDist:Float;
      var sqDist:Float;
      var index:Int=0;
      
      var firstStack:Array<Int> = null;
      firstStack = new Array();
      var lastStack:Array<Int> = null;
      lastStack = new Array<Int>();
      
      var newPoints:Array<Point> = null;
      newPoints = new Array();
      
      markers[first] = markers[last] = 1;
      
      while (last!=null) {
        
        maxSqDist = 0;
        
       // for (i = first + 1; i < last; i++) {
        for (i in first ... last ) {
          sqDist = getSquareSegmentDistance(points[i], points[first], points[last]);
          
          if (sqDist > maxSqDist) {
            index = i;
            maxSqDist = sqDist;
          }
        }
        
        if (maxSqDist > sqTolerance) {
          markers[index] = 1;
          
          firstStack.push(first);
          lastStack.push(index);
          
          firstStack.push(index);
          lastStack.push(last);
        }
        
        first = firstStack.pop();
        last = lastStack.pop();
      }
      
     // for (i = 0; i < len; i++) {
      for (i in 0 ... len) {
        if (markers[i]!=null) {
          newPoints.push(points[i]);
        }
      }
      
      return newPoints;
    }
    
    public static function simplify(points:Array<Point>, tolerance:Float = 1, highestQuality:Bool =
      false):Array<Point> {
      
      var sqTolerance:Float = tolerance * tolerance;
      
      if (!highestQuality) {
        points = simplifyRadialDistance(points, sqTolerance);
      }
      points = simplifyDouglasPeucker(points, sqTolerance);
      
      return points;
    }
  }


