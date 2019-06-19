package postite.dro;
import js.html.CanvasRenderingContext2D;
import postite.geom.CoolPoint;
import hxClipper.Clipper;
import postite.geom.Segment;
import postite.dro.Box;
import com.nodename.geom.*;
class Dro{

  static var fill="#ooaaff";

  public function new(){
  }



   public static function droPoint(ctx:CanvasRenderingContext2D,_point:PressPoint,?col:Couleur,?opacity:Float=1.0){
      
        ctx.beginPath();
        ctx.arc(_point.x,_point.y, _point.press/2, 0, 2 * Math.PI, true);
		ctx.fillStyle=col.toHex();
       
        ctx.fill();

  }

  public static function droBox(ctx:CanvasRenderingContext2D,?box:Box):Box{
	   box= (box != null)? box : Box.create();  
	  ctx.beginPath();
		ctx.rect(box.x,box.y,box.width,box.height);
		

		ctx.fillStyle=box.color.toHex();
        ctx.fill();
		return box;
  }

  public static function drawPoly(ctx:js.html.CanvasRenderingContext2D,poly:Array<Point>,?col:String="#000"):Void
	{
        var scale=1;
		var p0 = poly[0];
        ctx.strokeStyle=col;
		
		ctx.moveTo(p0.x / scale, p0.y / scale);
		for (i in 1...poly.length) {
			var p = poly[i];
			ctx.lineTo(p.x / scale, p.y / scale);
		}
		ctx.lineTo(p0.x / scale, p0.y / scale);	// close path
        ctx.stroke();
		ctx.lineWidth = 1;
  		ctx.strokeStyle = '#000';
	}

	public static function drawPath(ctx:js.html.CanvasRenderingContext2D,poly:Array<Point>,?col:String="#000"):Void
	{
        var scale=1;
		var p0 = poly[0];
        ctx.strokeStyle=col;
		
		ctx.moveTo(p0.x / scale, p0.y / scale);
		for (i in 1...poly.length) {
			var p = poly[i];
			ctx.lineTo(p.x / scale, p.y / scale);
		}
		//ctx.lineTo(p0.x / scale, p0.y / scale);	// close path
        ctx.stroke();
		ctx.lineWidth = 1;
  		ctx.strokeStyle = '#000';
	}

    public static function droSegments(ctx:js.html.CanvasRenderingContext2D,segments:Array<Segment>, col:String="#000", ?fillColor:Int = null,?opacity:Float=1.0) {
		
		ctx.strokeStyle= col;
		ctx.lineWidth = 3;
		//if (fillColor != null) ctx.beginFill(fillColor, opacity);
		//else ctx.beginFill(0, 0);
		for (segment in segments) {
			
			ctx.moveTo(segment.x, segment.y);
			ctx.lineTo(segment.dx+segment.x, segment.dy+segment.y);
		}
         ctx.stroke();

		
	}

	public static function droRect(ctx:js.html.CanvasRenderingContext2D,rect:Rect,col:String="#000"){
		ctx.strokeRect(rect.x,rect.y,rect.width,rect.height);
		ctx.stroke();
	}
public static function droPaths(ctx:js.html.CanvasRenderingContext2D,paths:hxClipper.Clipper.Paths,?col:String="#000"){
	
	ctx.strokeStyle= col;
		//if (fillColor != null) ctx.beginFill(fillColor, opacity);
		//else ctx.beginFill(0, 0);
		ctx.lineWidth = 5;
		for (path in paths){
			ctx.moveTo(path[0].x, path[0].y);
		for (point in path) {
			
			ctx.lineTo(point.x, point.y);
		}
		ctx.lineTo(path[0].x, path[0].y);	// close path
		}
         ctx.stroke();
	
		
}
    
}