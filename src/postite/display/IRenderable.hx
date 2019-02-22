package postite.display;
import postite.display.*;
interface IRenderable<TRender : IRender> {
  public var enabled : Bool;
  public function render(render : TRender) : Void;
}