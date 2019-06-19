package postite.geom.units;

typedef Angle ={}
//import thx.Floats;

abstract Degree(Float) {
  static var ofUnit : Float = 1.0/360.0; 
  public static var turn(default, null) : Degree = 360.0;

  @:from inline static public function fromFloat(value : Float) : Degree
    return new Degree(value);

  @:from inline static public function fromInt(value : Int) : Degree 
    return fromFloat(value);
  
   @:to
 inline public function toFloat() : Float
    return this;

  inline function new(value : Float)
    this = value;


 
  static var dividerRadian : Float = 1.0/6.283185307179586;
  @:to inline public function toRadian() : Radian
      return (this * ofUnit) / dividerRadian;

  public static inline var symbol : String = "°";

 @:to inline public function toString() : String
    return "" + this + symbol;



}



abstract Radian(Float) {
  static var ofUnit : Float = 1.0/6.283185307179586; 
  public static var turn(default, null) : Radian = 6.283185307179586;

  @:from inline static public function fromFloat(value : Float) : Radian
    return new Radian(value);

  @:from inline static public function fromInt(value : Int) : Radian 
    return fromFloat(value);
  

  inline function new(value : Float)
    this = value;

  static var dividerDegree : Float = 1.0/360.0;
  @:to inline public function toDegree() : Degree
      return (this * ofUnit) / dividerDegree;
 
   
    
  @:to inline public function toString() : String
    return "" + this + symbol;

  public static inline var symbol : String = "rad";

   @:to
 inline public function toFloat() : Float
    return this;
}



