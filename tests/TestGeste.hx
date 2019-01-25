import utest.Assert;
import postite.geom.Geste;
import postite.geom.CoolPoint;
class TestGeste extends utest.Test{
    var geste:Geste;
    var stroke:Points;
    function setup(){
        geste= new Geste();
        stroke=postite.geom.UnistrokePatterns.unimap.get("circle");
    }

    function testRecognise(){
        //trace( stroke);
       // trace("rec");
       var t= geste.Recognize(stroke,false);
       trace(t.Score);
       Assert.equals("circle",t.Name);
    }
    function testRecogniseCustom(){
        //trace( stroke);
        var clocl=Coords.clockcircle.map(p->({x:p.x,y:p.y}:CoolPoint));
       // trace( "recustom");
       var t= geste.Recognize(clocl,false);
       trace(t.Score);
       Assert.notEquals("circle",t.Name);
    }

    function testRecogniseCustomnotClock(){
        //trace( stroke);
        var clocl=Coords.notclockcircle.map(p->({x:p.x,y:p.y}:CoolPoint));
        //trace( "recustom");
       var t= geste.Recognize(clocl,false);
       trace(t.Score);
       trace( t.Name);
       Assert.equals("circle",t.Name);
    }

    function testRecogniseCustomnotClockProtactor(){
        //trace( stroke);
        var clocl=Coords.notclockcircle.map(p->({x:p.x,y:p.y}:CoolPoint));
       // trace( "recustom");
       var t= geste.Recognize(clocl,true);
       trace(t.Score);
       trace( t.Name);
       Assert.equals("circle",t.Name);
    }

}