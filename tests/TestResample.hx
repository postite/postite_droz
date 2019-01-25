import utest.Assert;
import Coords.Coords;
import postite.geom.CoolPoint;
import postite.geom.Geste;
using TestResample;
class TestResample extends utest.Test{
    static var path:Points;
    static var p1:Point={x:100,y:200};
    static var p2:Point={x:300,y:400};
    static var seg=[p1,p2];
    static var dix=[1,2,3,4,5,6,7,8,9,10];
    static var zig=   
        [ new Point(307,216),new Point(333,186),new Point(356,215),new Point(375,186),new Point(399,216),new Point(418,186)];

    // public function testfromBase()
    // {
    //    var t=dix.toPoints();
    //    trace( t);
    //    var n= Geste.resamplet(t,20);
    //  trace( n);
    //     Assert.equals(20, n.length);
    // }
    // public function testZig(){
    //    var n=Geste.Resample(zig,64);
    //     Assert.equals(64,n.length);
    // }

    public function testCircle(){
        trace( "circl");
        var circle=postite.geom.UnistrokePatterns.unimap.get("circle");
        var n=Geste.Resample(circle,64);
        Assert.equals(64,n.length);
    }
    // public function testZigt(){
    //    var n=Geste.resamplet(zig,64);
    //     Assert.equals(64,n.length);
    // }
//Resample([ new Point(307,216),new Point(333,186),new Point(356,215),new Point(375,186),new Point(399,216),new Point(418,186)]
//,24)

public static function toPoints(val:Array<Int>):Points
        return val.map(p->{x:p*10,y:p*10+100});

}