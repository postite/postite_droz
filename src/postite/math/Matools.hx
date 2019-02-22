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


} 