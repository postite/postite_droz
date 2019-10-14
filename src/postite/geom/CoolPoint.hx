package postite.geom;

typedef _Point = {
	x:Float,
	y:Float 
}
typedef IntPoint={
	x:Int,
	y:Int
}

typedef PressPoint={
	>_Point,
	?press:Float
}

typedef Rect={
	x:Float,
	y:Float,
	width:Float,
	height:Float
}

@:forward
abstract Points(Array<Point>) from Array<Point> to Array<Point>{

		@:from
	public static function fromArrayInt(a:Array<IntPoint>):Points {
		return  cast a;
	}
		@:from
	public static function fromArrayPress(a:Array<CoolPoint>):Points {
		return  cast a;
	}
	@:to 
	public static function toPoly(a:Array<Point>):PolyGon{
		return cast a;
	}	
}

@:forward
abstract Point(_Point) from _Point to _Point{

	public function new(?x:Float=0,?y:Float=0){
		//if( x!=null && y!=null)
		this= {x:x, y:y};
	}

	public inline function add( p : Point ):Point {
		return new Point(this.x + p.x, this.y + p.y);
	}
	
@:from
	public static function fromAnonInt(a:{x:Int,y:Int}):Point {
		return new Point(a.x*1.0, a.y*1.0);
	}

@:from public static function fromPress(p:PressPoint):Point{
	return new Point(p.x,p.y);
}
@:to public  function toPress():PressPoint{
	return {x:this.x, y:this.y, press:10};
}
}

@:forward
abstract CoolPoint(PressPoint) from PressPoint to PressPoint {
	public function new(x,y,?p) {
		this = {x:x,y:y,press:p}

	}
	
	@:from
	public static function fromArray(a:Array<Float>):CoolPoint {
		return new CoolPoint( a[0], a[1], a[2]);
	}

	@:from
	public static function fromAnon(a:{x:Float,y:Float}):CoolPoint {
		return new CoolPoint( a.x, a.y);
	}
	@:from
	public static function fromAnonInt(a:{x:Int,y:Int}):CoolPoint {
		return new CoolPoint(a.x*1.0, a.y*1.0);
	}
	@:from
	public static function fromAnonIntPress(a:{x:Int,y:Int,press:Int}):CoolPoint {
		return new CoolPoint(a.x*1.0, a.y*1.0);
	}

	@:to
	public static function toPoint(p:CoolPoint):Point{
		return {x:p.x,y:p.y};
	}
}