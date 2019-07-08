package postite.math;

class Matools{
  public static inline var PI = 3.14159265358979323;
	public static inline var EPSILON = 1e-10;

    /**
		Linear interpolation between two values. When k is 0.0 a is returned, when it's 1.0, b is returned.

	**/
	public inline static function lerp(a:Float, b:Float, k:Float) {
		return a + k * (b - a);
}
    public inline static function inverseLerp(min:Float, max:Float,  value:Float) {
   if(Math.abs(max - min) < EPSILON) return min;
   return (value - min) / (max - min);
 }

     public static function  scale( old:Array<Int>,neo:Array<Int>, OldValue){
         var OldRange = (old[1] - old[0]);
         var NewRange = (neo[1] - neo[0]);
         var NewValue = (((OldValue - old[0]) * NewRange) / OldRange) + neo[0];
     
        return(NewValue);
    }

    // modulo plus negative
      public static inline function wrap(x:Float, n:Float):Float
    {
        if (x < 0)
        {
            // To avoid ambiguity with modulo sign conventions (some use the divisor's sign, others
            // use dividend's, etc) force the dividend to be positive.
            return n - (-x % n);
        }
        else
        {
            return x % n;
        }
    }

    /**
    * "Clamps" a value to boundaries [min, max].
    * Example:
    * clamp(2, 1, 5) == 2;
    * clamp(0, 1, 5) == 1;
    * clamp(6, 1, 5) == 5;
    */
    public static inline function clamp( f : Float, min = 0., max = 1. ) {
		return f < min ? min : f > max ? max : f;
    }


    public static function getRandomInt(min:Float, max:Float) :Float{
		min = Math.ceil(min);
		max = Math.floor(max);
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}



  /**
  thx.Floats
Return the maximum value between two integers or floats.
**/
  inline public static function max<T : Float>(a : T, b : T) : T
    return a > b ? a : b;

/**
thx.Floats
Return the minimum value between two integers or floats.
**/
  inline public static function min<T : Float>(a : T, b : T) : T
    return a < b ? a : b;

/**
thx.Floats
Float numbers can sometime introduce tiny errors even for simple operations.
`nearEquals` compares two floats using a tiny tollerance (last optional
argument). By default it is defined as `EPSILON`.
**/
  public static function nearEquals(a : Float, b : Float, ?tollerance = EPSILON) {
    if(Math.isFinite(a)) {
      #if (php || java)
      if(!Math.isFinite(b))
        return false;
      #end
      return Math.abs(a - b) <= tollerance;
    }
    if(Math.isNaN(a))
      return Math.isNaN(b);
    if(Math.isNaN(b))
      return false;
    if(!Math.isFinite(b))
      return (a > 0) == (b > 0);
    // a is Infinity and b is finite
    return false;
}

/**
`sign` returns `-1` if `value` is a negative number, `1` otherwise.
*/
  inline public static function sign<T : Float>(value : T) : Int
    return value < 0 ? -1 : 1;


} 