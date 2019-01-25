package postite.geom;

import postite.geom.CoolPoint;

@:forward
abstract Segment(Array<Point>){
    public var p1:Point;
    public var p2:Point;
    public function new(a:Array<Point>){
        if (a.length!=2) throw 'not a good segment';
        p1=a[0];
        p2=a[1];
        this=a;
    }
}