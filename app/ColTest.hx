package app;
using postite.dro.Dro;
import postite.dro.*;

import postite.display.canvas.CanvasRender;
import js.Browser.document as doc;
import postite.dro.Couleur;
class ColTest implements postite.display.canvas.CanvasDisplay.IRenderCan{
public var enabled=true;
   var box:Box;
   var box2:Box;
   var count=0;
   var initboxColor:Couleur;
   var initboxColor2:Couleur;
   var randomBox:Box;
  public function new() {

    box= Box.create(Vert);
    initboxColor=box.color;
    box2= Box.create(Ocre);
    box2.x=200;
    initboxColor2=box2.color;
    
    randomBox=Box.create(Couleur.randomInRange(Couleur.allColors));
    randomBox.x=400;
  }
  
  
   public function render(cn:CanvasRender){
       // trace( "count="+count/100);
        count=++count%100;
        //box.color= initboxColor.mix(Couleur.Noir,count/100);
        box.color=initboxColor.darken(count/100);
        cn.ctx.droBox(box);

        box2.color=initboxColor2.lighten(count/100);
        cn.ctx.droBox(box2);

        cn.ctx.droBox(randomBox);


        
 
   }
}