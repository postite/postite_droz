import postite.geom.CoolPoint;
using tink.CoreApi;
class Hit{


public var mousePoint:CoolPoint;
public var clickSign:tink.core.Signal<CoolPoint>;
public var pointSign:Signal<CoolPoint>;
var outTrig:SignalTrigger<CoolPoint>;
var el:js.html.Element;
var inited:Bool=false;
 static var _inst:Hit;
public static var instance(get,never):Hit;
 static function get_instance():Hit{
    if (_inst==null)_inst= new Hit();
    return _inst;
}

public function init(el:js.html.Element){
    this.el=el;
    var trig=Signal.trigger();
    outTrig=Signal.trigger();
    el.addEventListener('click',function(e) {
     mousePoint = {
    x: e.clientX,
    y: e.clientY
     };
    trig.trigger(mousePoint);
    }
    );
    clickSign=trig.asSignal();
    pointSign=outTrig.asSignal();
    inited=true;
}


public function new(){
    
    //outSign.handle(point->trace( "popol"));
}

public function observe(point:CoolPoint){
    if(!inited) throw 'not inited';
    
    clickSign.handle( function (mouse){
      //  trace( "moooose"+mouse + "point="+point);
    if (isIntersect(mousePoint, point)) {
       // trace( "interc" +point);
        outTrig.trigger(point);
    }
    });
    
    
}

   public function isIntersect(point:CoolPoint, circle:CoolPoint) {
   var pow=Math.sqrt(
      Math.pow((point.x-circle.x),2)
       + 
       Math.pow((point.y - circle.y), 2)
       );
       
       return pow < circle.press*2;

 
}
public function clear(){
    el.removeEventListener('click',function(e) {
     mousePoint = {
    x: e.clientX,
    y: e.clientY
     };
    });
   
}






}