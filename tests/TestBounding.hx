package tests;
import postite.dro.Coords;
using postite.geom.GeomFilters;
import postite.geom.CoolPoint;
import postite.geom.PolyGon;
import utest.Assert;

class TestBounding extends utest.Test{

   var rect:Rect;
   var rectPoints:Points;
   var poly:PolyGon;
   function setup(){
      rect= {x:0,y:0,width:200,height:100};
      rectPoints=[
            new Point(rect.x,rect.y),
            new Point(rect.width,rect.y),
            new Point(rect.width,rect.height),
            new Point(rect.x,rect.height),
            new Point(rect.x,rect.y)
      ];
   }  
   function testBound(){
     var b= rectPoints.boundingBox();
      Assert.same(rect,b);
   }
   function testGrow(){
      var b= rectPoints.boundingBox();
      b.growRect(10);
      var grown= {x:-10,y:-10, width:220,height:120}
      Assert.same(rect,b);
   }

   function testScale(){
      var small=Coords.small;
      var smallbound= small.boundingBox();
      var growRect=smallbound.growRect(123);
      var scaled= small.clipOff(123)[0];
      var scaledBound=scaled.boundingBox();
      Assert.same(growRect,scaledBound);
   }

   function testScaleUniform(){

   }



}