package postite.math;

class Matools {
	public static inline var PI = 3.14159265358979323;
	public static inline var EPSILON = 1e-10;

	/**
		Linear interpolation between two values. When k is 0.0 a is returned, when it's 1.0, b is returned.

	**/
	public inline static function lerp(a:Float, b:Float, k:Float) {
		return a + k * (b - a);
	}

	public inline static function inverseLerp(_min:Float, max:Float, value:Float) {
		if (Math.abs(max - _min) < EPSILON)
			return _min;
		return (value - _min) / (max - _min);
	}

	public static function scale(old:Array<Int>, neo:Array<Int>, OldValue) {
		var OldRange = (old[1] - old[0]);
		var NewRange = (neo[1] - neo[0]);
		var NewValue = (((OldValue - old[0]) * NewRange) / OldRange) + neo[0];

		return (NewValue);
	}

	// modulo plus negative
	public static inline function wrap(x:Float, n:Float):Float {
		if (x < 0) {
			// To avoid ambiguity with modulo sign conventions (some use the divisor's sign, others
			// use dividend's, etc) force the dividend to be positive.
			return n - (-x % n);
		} else {
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
	public static inline function clamp(f:Float, min = 0., max = 1.) {
		return f < min ? min : f > max ? max : f;
	}

	public static function getRandomInt(min:Float, max:Float):Float {
		min = Math.ceil(min);
		max = Math.floor(max);
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}

	/**
		thx.Floats
		Return the maximum value between two integers or floats.
	**/
	inline public static function max<T:Float>(a:T, b:T):T
		return a > b ? a : b;

	/**
		thx.Floats
		Return the minimum value between two integers or floats.
	**/
	inline public static function min<T:Float>(a:T, b:T):T
		return a < b ? a : b;

	/**
		thx.Floats
		Float numbers can sometime introduce tiny errors even for simple operations.
		`nearEquals` compares two floats using a tiny tollerance (last optional
		argument). By default it is defined as `EPSILON`.
	**/
	public static function nearEquals(a:Float, b:Float, ?tollerance = EPSILON) {
		if (Math.isFinite(a)) {
			#if (php || java)
			if (!Math.isFinite(b))
				return false;
			#end
			return Math.abs(a - b) <= tollerance;
		}
		if (Math.isNaN(a))
			return Math.isNaN(b);
		if (Math.isNaN(b))
			return false;
		if (!Math.isFinite(b))
			return (a > 0) == (b > 0);
		// a is Infinity and b is finite
		return false;
	}

	//from heaps.hxd.Math
	//A function to calculate the square of the distance between two points.
	public static inline function distanceSq( dx : Float, dy : Float, dz = 0. ) {
		return dx * dx + dy * dy + dz * dz;
	}

	public static inline function distance( dx : Float, dy : Float, dz = 0. ) {
		return Math.sqrt(distanceSq(dx,dy,dz));
	}

	// round to 4 significant digits, eliminates < 1e-10
	public static function fmt( v : Float ) {
		var neg;
		if( v < 0 ) {
			neg = -1.0;
			v = -v;
		} else
			neg = 1.0;
		if( Math.isNaN(v) || !Math.isFinite(v) )
			return v;
		var digits = Std.int(4 - Math.log(v) / Math.log(10));
		if( digits < 1 )
			digits = 1;
		else if( digits >= 10 )
			return 0.;
		var exp = Math.pow(10,digits);
		return Math.ffloor(v * exp + .49999) * neg / exp;
}

	/**
		`sign` returns `-1` if `value` is a negative number, `1` otherwise.
	 */
	inline public static function sign<T:Float>(value:T):Int
		return value < 0 ? -1 : 1;
}
