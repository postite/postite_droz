package app;
import postite.geom.PolyGon;
import postite.dro.Couleur;

import postite.geom.GeomFilters;
import postite.dro.Dro;
import postite.geom.CoolPoint;
import postite.geom.CoolPoint.Points;
import postite.display.canvas.CanvasRender;
import postite.geom.Geste;

class OBB implements postite.display.canvas.CanvasDisplay.IRenderCan{
    public var enabled= true;
    var points:Points;
    var poly:postite.geom.PolyGon;
    var bb:Rect;
    var opty:PolyGon;
    public function new(){
        drawBox();
    }
    public function drawBox(){
        points=[
            new CoolPoint(10,10),
            new CoolPoint(30,10),
            new CoolPoint(30,200),
            new CoolPoint(20,250),
            new CoolPoint(20,250),
            new CoolPoint(10,200),
            new CoolPoint(10,10),
        ];

        points= GeomFilters.rotateBy(points,(-30:postite.geom.units.Angle.Degree));
        points= GeomFilters.translateTo(points,{x:300,y:100});

         poly=new postite.geom.PolyGon(points);
         opty= poly.optimize(.9);
       //  trace( postite.geom.Geste.IndicativeAngle(points));
     bb=Geste.BoundingBox(points);
    }
    public function render(can:CanvasRender)
    {
       // Dro.drawPath(can.ctx,points);
       // trace( detectAngle (points));
        Dro.drawPoly(can.ctx,poly,Couleur.Ocre);
        Dro.droRect(can.ctx,bb,Couleur.Rouge);
        Dro.drawPoly(can.ctx,opty,Couleur.Jaune);
    }

    function detectAngle(pts:Points){
        
    }

}