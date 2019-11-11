package tests;
import utest.Test;
import postite.dro.Coords;
import postite.geom.PolyGon;
import utest.Assert;
import postite.geom.CoolPoint;
using postite.geom.GeomFilters;

class TestGeomFilters extends Test{

   var poly:PolyGon;
   var closed:PolyGon;
   function setup(){
      poly=Coords.small;
   }

   public function testSetup(){
      Assert.notNull(poly);
   }
   public function testIsCLosed(){
      closed=cast Coords.closed;
      trace (poly);
      var t=poly.isClosedAt(true);
      trace(t);
     Assert.isFalse( switch (t) {
         case Some(v):
         v.x==2;
         case None: 
         false;
      });

      var t=closed.isClosedAt(true);
      trace(t);
     Assert.isTrue( switch (t) {
         case Some(v):
         (v.x!=null || v.y!=null);
         case None: 
         false;
      });
   }  

   public function testClose(){
         
   }

   public function testRandomInCircle(){
      var p:Point= GeomFilters.randomInCircle(15,{x:15,y:15});
      Assert.isTrue(GeomFilters.pointIsInCircle(15,{x:15,y:15},{x:15,y:15}) );
      Assert.isTrue(GeomFilters.pointIsInCircle(15,{x:15,y:15},{x:16,y:17}) );
      Assert.isFalse(GeomFilters.pointIsInCircle(15,{x:15,y:15},{x:40,y:40}) );
   }

}