package postite.geom;
import postite.geom.CoolPoint;

class Geste{
    // DollarRecognizer constants
//
var  NumUnistrokes = 16;
public static var  NumPoints = 64;
public static var  SquareSize = 250.0;
public static var  Origin = new Point(0,0);
static var  Diagonal = Math.sqrt(SquareSize * SquareSize + SquareSize * SquareSize);
static var  HalfDiagonal = 0.5 * Diagonal;
static var  AngleRange = Deg2Rad(45.0);
static var  AnglePrecision = Deg2Rad(2.0);
static var  Phi = 0.5 * (-1.0 + Math.sqrt(5.0)); // Golden Ratio
//

var Unistrokes:Array<UniStroke>;
public function new(){
    Unistrokes= new Array();
    for( a in UnistrokePatterns.unimap.keys())
    Unistrokes.push(new UniStroke(a,UnistrokePatterns.unimap.get(a)));

}
public function Recognize(points:Points,useProtractor:Bool):Result{
        var t0 = Date.now();
		points = Resample(points, NumPoints);
		var radians = IndicativeAngle(points);
		points = RotateBy(points, -radians);
		points = ScaleTo(points, SquareSize);
		points = TranslateTo(points, Origin);
		var vector = Vectorize(points); // for Protractor


        var b = Math.POSITIVE_INFINITY;
        trace( Unistrokes.length);
		var u = -1;
        for( i in 0...Unistrokes.length)
		//for (var i = 0; i < this.Unistrokes.length; i++) // for each unistroke
		{
           
			var d:Float;
			if (useProtractor){ // for Protractor
           // trace("vect="+this.Unistrokes[i].Vector);
           // trace( "victor="+vector);
				d = OptimalCosineDistance(this.Unistrokes[i].Vector, vector);
			//trace( "d="+d);
            }else{ // Golden Section Search (original $1)
		//	trace('hep'+points[points.length-1]);
            d = DistanceAtBestAngle(points, this.Unistrokes[i], -AngleRange, AngleRange, AnglePrecision);
        //    trace("d="+d);
            }
			
			if (d < b) {
				b = d; // best (least) distance
				u = i; // unistroke index
			}
            
		}
       // trace("after loop");
        var t1 = Date.now();
        var newdate=DateTools.delta(t1,-t0.getTime());

		return if(u == -1){
             new Result("No match.", 0.0, newdate);
            }else{
            new Result(
                this.Unistrokes[u].Name, (useProtractor)? 1.0 / b : 1.0 - b / HalfDiagonal, newdate 
                );
            }

            

}
public function addGesture(name,points):Int{
this.Unistrokes[this.Unistrokes.length] = new UniStroke(name, points); // append new unistroke
		var num = 0;
        for(i in 0...this.Unistrokes.length){
		
			if (this.Unistrokes[i].Name == name)
				num++;
		}
		return num;
}
public function DeleteUserGestures():Int{
    this.Unistrokes=[]; // clear any beyond the original set
		return NumUnistrokes;
}

public static  function Resample(origpoints:Points, n:Int):Points
{
    //do not modify original
    var points=origpoints.copy();
	var I = PathLength(points) / (n - 1); // interval length
	var D = 0.0;
	var newpoints = [points[0]];
   // trace( "newpoints="+newpoints.length);
	//for (var i = 1; i < points.length; i++)
    var i=1;
    //trace( "points length"+points.length);
    var push=0;
    
    for( point in points)
    //for (i in 1...points.length)
	{
   // trace("i="+i);
    //trace("points.length="+ points.length);
   // trace(points[i]);
	var d = Distance(points[i-1], points[i]);
       
    //trace("distance="+d);
    // trace("D="+D);
    // trace("I="+I);
    
		if ((D + d) >= I)
		{
          //  trace( "push");
          //  push++;
			var qx = points[i-1].x + ((I - D) / d) * (points[i].x - points[i-1].x);
			var qy = points[i-1].y + ((I - D) / d) * (points[i].y - points[i-1].y);
			var q = new Point(qx, qy);
            newpoints.push(q);
			//newpoints[newpoints.length] = q; // append new point 'q'
           // points.splice(i,1);
           //untyped __js__('{0}.splice(i, 0, q)',points);
        points.slice(i);
        points.insert(i,q);
           // points.push(q);
            
           // points.splice(i,0);
			//points.splice(i, 0, q); // insert 'q' at position i in points s.t. 'q' will be the next i
			D = 0.0;
          
		}
		else D += d;
          if(i<points.length-1)
         i++;
        }
    
	
    //trace( newpoints.length);
   // trace("push="+push);
  // trace( i);
	if (newpoints.length == n - 1) // somtimes we fall a rounding-error short of adding the last point, so add it if so
		newpoints[newpoints.length] = new Point(points[points.length - 1].x, points[points.length - 1].y);
	return newpoints;
}



public static function IndicativeAngle(points:Points):Float
{
	var c = Centroid(points);
	return Math.atan2(c.y - points[0].y, c.x - points[0].x);
}
public static function RotateBy(points:Points, radians:Float):Points // rotates points around centroid
{
	var c = Centroid(points);
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

public static function ScaleTo(points:Points, size:Float) // non-uniform scale; assumes 2D gestures (i.e., no lines)
{
	var B = BoundingBox(points);
	var newpoints = new Array();
	//for (var i = 0; i < points.length; i++) {
    for (point in points) {
		var qx = point.x * (size / B.width);
		var qy = point.y * (size / B.height);
		newpoints[newpoints.length] = new Point(qx, qy);
	}
	return newpoints;
}

//translate polygon to be centered(centroid) on pt Point.
public static function TranslateTo(points:Points, pt:Point):Points // translates points' centroid
{
	var c = Centroid(points);
	var newpoints = new Array();
	for (point in points) {
		var qx = point.x + pt.x - c.x;
		var qy = point.y+ pt.y - c.y;
		newpoints[newpoints.length] = new Point(qx, qy);
	}
	return newpoints;
}
public static function Vectorize(points:Points):Array<Float> // for Protractor
{
	var sum = 0.0;
	var vector = [];
	for  (point in points) {
		vector[vector.length] = point.x;
		vector[vector.length] = point.y;
		sum += point.x * point.x + point.y * point.y;
	}
	var magnitude = Math.sqrt(sum);
	for (i in 0...vector.length)
		vector[i] /= magnitude;
	return vector;
}
public static function OptimalCosineDistance(v1:Array<Float>, v2:Array<Float>):Float // for Protractor
{
	var a:Float = 0.0;
	var b:Float = 0.0;
    //trace(v1.length +"-"+v2.length);
    for ( i in new postite.StepIterator(0,v1.length,2)){
       // trace(i);
        try{
         //   trace("i+1="+v1[i+1]);
           // trace("v2i+1="+v2[i+1]);
        a += v1[i] * v2[i] + v1[i+1] * v2[i+1];
		b += v1[i] * v2[i+1] - v1[i+1] * v2[i];
        }catch(msg:Dynamic){
            
            trace( "eer"+msg);
        }
       // trace("a="+a);
        //trace( "b="+b);
    }
	// for (var i = 0; i < v1.length; i += 2) {
	// 	a += v1[i] * v2[i] + v1[i+1] * v2[i+1];
	// 	b += v1[i] * v2[i+1] - v1[i+1] * v2[i];
	// }
	var angle = Math.atan(b / a);
    
	return Math.acos(a * Math.cos(angle) + b * Math.sin(angle));
}
public static function DistanceAtBestAngle<T:{Points:Points}>(points:Points, t:T, a:Float, b:Float, threshold:Float):Float
{
    //trace('$a $b $threshold' );
	var x1 = Phi * a + (1.0 - Phi) * b;
    //trace('x1= $x1');
    
	var f1 = DistanceAtAngle(points, t, x1);
	//trace( f1);
    var x2 = (1.0 - Phi) * a + Phi * b;
	var f2 = DistanceAtAngle(points, t, x2);
	//trace('$x1 $f1 $x2 $f2');
    while (Math.abs(b - a) > threshold)
	{
		if (f1 < f2) {
			b = x2;
			x2 = x1;
			f2 = f1;
			x1 = Phi * a + (1.0 - Phi) * b;
			f1 = DistanceAtAngle(points, t, x1);
		} else {
			a = x1;
			x1 = x2;
			f1 = f2;
			x2 = (1.0 - Phi) * a + Phi * b;
			f2 = DistanceAtAngle(points, t, x2);
		}
	}
	return Math.min(f1, f2);
}

public static function DistanceAtAngle<T:{Points:Points}>(points:Points,t:T, radians:Float):Float
{
	var newpoints = RotateBy(points, radians);
//     trace( 'new poits ${newpoints.length}');
//     var hack=[];
    
//     while(hack.length<23){
//     hack.push(newpoints[hack.length]);
    
// }
// trace( hack.length);
// 	return PathDistance(hack, t.Points);
	return PathDistance(newpoints, t.Points);
}
public static function Centroid(points:Points):Point
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

public static function BoundingBox(points:Array<Point>):Rect
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
public static function PathDistance(pts1:Array<Point>, pts2:Array<Point>):Float
{
	var d = 0.0;
	for (i in 0...pts1.length) // assumes pts1.length == pts2.length
		d += Distance(pts1[i], pts2[i]);
	return d / pts1.length;
}

public static function PathLength(points:Array<Point>)
{
	var d = 0.0;
	for ( i in 1...points.length)
		d += Distance(points[i - 1], points[i]);
	return d;
}
public static function Distance(p1:Point, p2:Point)
{
	var dx = p2.x - p1.x;
	var dy = p2.y - p1.y;
	return Math.sqrt(dx * dx + dy * dy);
}
public static function Deg2Rad(d:Float) { return (d * Math.PI / 180.0); }


}

class UniStroke{
   public var Name:String;
    public var Points:Array<Point>;
    var radians:Float;
    public var Vector:Array<Float>;

   public  function new(name,points){
    this.Name = name;
	this.Points = Geste.Resample(points, Geste.NumPoints);
	var radians = Geste.IndicativeAngle(this.Points);
	this.Points = Geste.RotateBy(this.Points, -radians);
	this.Points = Geste.ScaleTo(this.Points, Geste.SquareSize);
	this.Points = Geste.TranslateTo(this.Points, Geste.Origin);
	this.Vector = Geste.Vectorize(this.Points); // for Protractor
    }
}

class Result{
    public var Name:String;
   public  var Score:Float;
    public var Time:Date;

    public function new(name,score,ms)
    {
    this.Name = name;
	this.Score = score;
	this.Time = ms;
    }
}
