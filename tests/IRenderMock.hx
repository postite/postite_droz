package tests;
class IRenderMock implements pst.it.IRenderCan{
    public var enabled=true;
    public function new()
    {
       
    }
    public function render(r:postite.display.canvas.CanvasRender) {
        trace("ohé");
    }
}