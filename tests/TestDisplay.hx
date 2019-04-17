package tests;
import pst.It;
import utest.Assert;
class TestDisplay extends utest.Test{
    var counter=0;
    var Opp:CanvasDisplay; 
    var display:pst.It.CanvasDisplay;
    function setupClass():Void{
        
    }
    public function setup(){
        display= new pst.It.CanvasDisplay();
        Opp= new CanvasDisplay();
        counter=0;
        display.addRenderable(new tests.IRenderMock());
		display.enterframe(12);
        display.onFrame=function(frame:Int){
           counter=frame;
        }
    }
    @:timeout(2500)
    public function testigTested(async:utest.Async){
        
        haxe.Timer.delay(function(){
            Assert.equals(24,counter); // enterframe 12 delay 3seconds so 24 !
            async.done();
        },2000);
    }
    @:timeout(1200)
    public function testPause(async:utest.Async){
        display.togPause();
        haxe.Timer.delay(function(){
           // display.togPause();
            Assert.equals(0,counter); // enterframe 12 delay 3seconds so 24 !
            async.done();
        },1000);
    }
    @:timeout(1200)
    public function testAfterPause(async:utest.Async){
        display.togPause();
        haxe.Timer.delay(function(){
            display.togPause();
            Assert.equals(12,counter); // enterframe 12 delay 3seconds so 24 !
            async.done();
        },1000);
    }

    function teardown(){
        display.remove();
    }


}