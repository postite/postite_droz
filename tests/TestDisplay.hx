package tests;
import pst.It;
class TestDisplay extends utest.Test{

    var Opp:CanvasDisplay;  
    public function setup(){
        Opp= new CanvasDisplay();
        display.addRenderable(new tests.IRenderMock());
		display.enterframe(12);
    }
    public function testigTested(){
        
    }
    public function testPause(){

    }


}