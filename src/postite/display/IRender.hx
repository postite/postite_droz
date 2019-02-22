package postite.display;

interface IRender {
  public function clear() : Void;
  public function beforeEach() : Void;
  public function afterEach() : Void;
}