package postite.geom;

class Calc{


    public static function getRandomInt(min:Float, max:Float) :Float{
		min = Math.ceil(min);
		max = Math.floor(max);
		return Math.floor(Math.random() * (max - min + 1)) + min;
	}
}