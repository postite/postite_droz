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


  @:op( -A ) inline public function negate() : Degree
    return -this;
  @:op( A+B) inline public function add(that : Degree) : Degree
    return this + that.toFloat();
  @:op( A-B) inline public function subtract(that : Degree) : Degree
    return this - that.toFloat();
  @:op( A*B) inline public function multiply(that : Float) : Degree
    return this * that;
  @:op( A/B) inline public function divide(that : Float) : Degree
    return this / that;
  @:op( A%B) inline public function modulo(that : Float) : Degree
  return this % that;


  @:op(A!=B)
  inline static public function notEquals(self : Degree, that : Degree) : Bool
    return self.toFloat() != that.toFloat();

  inline public function lessThan(that : Degree) : Bool
    return this < that.toFloat();
  @:op( A<B)
  inline static public function less(self : Degree, that : Degree) : Bool
    return self.toFloat() < that.toFloat();

  inline public function lessEqualsTo(that : Degree) : Bool
    return this <= that.toFloat();
  @:op(A<=B)
  inline static public function lessEquals(self : Degree, that : Degree) : Bool
    return self.toFloat() <= that.toFloat();

  inline public function greaterThan(that : Degree) : Bool
    return this > that.toFloat();
  @:op( A>B)
  inline static public function greater(self : Degree, that : Degree) : Bool
    return self.toFloat() >= that.toFloat();

  inline public function greaterEqualsTo(that : Degree) : Bool
    return this >= that.toFloat();
  @:op(A>=B)
  inline static public function greaterEquals(self : Degree, that : Degree) : Bool
return self.toFloat() >= that.toFloat();


    inline public function cos() : Float
    return toRadian().cos();

  inline public function sin() : Float
    return toRadian().sin();


  public function normalize() : Degree {
    var n = this % (turn : Float);
    return n < 0 ? (turn : Float) + n : n;
  }

  public function normalizeDirection() : Degree {
    var normalized = normalize();
    return normalized > (turn : Float) / 2 ? normalized - (turn : Float) : normalized;
}


 
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


    inline public function cos() : Float
    return Math.cos(this);

  inline public function sin() : Float
return Math.sin(this);

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



