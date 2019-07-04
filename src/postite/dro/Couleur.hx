package postite.dro;





/**
 * ...
 * @author P.J.Shand
 */
 enum abstract Couleur(UInt) from Int from UInt to UInt
{
    //public var Rouge=0x00CC3300;
    public var Rouge=0xCC3300;
    public var Bleu:Couleur=0x1B019B;
    public var Orange:Couleur=0xF4661B;
    public var Ombre:Couleur=0x3F2204;
    public var Jaune:Couleur=0xFFDE75;
    public var Ocre:Couleur=0xDFAF2C;
    public var Vert:Couleur=0x689D71;
	public var Prusse:Couleur=0x004567;
	public var Olive:Couleur=0x808000;

    public var Noir:Couleur=0x000000;
    public var Blanc:Couleur=0xFFFFFF;
    public var Gris:Couleur=0x7F7F7F;

    public static var allColors(get,never):Array<Couleur>;

     static function get_allColors():Array<Couleur>{
        return [Rouge,Ocre,Bleu,Orange,Jaune,Ombre,Vert];
    }

	public var red(get, set):UInt;
	public var green(get, set):UInt;
	public var blue(get, set):UInt;
	public var alpha(get, set):UInt;
	
	public function new(value:UInt) {
		this = value;
	}
	
	inline function get_red():UInt 
	{
		return (this & 0x00ff0000) >>> 16;
	}
	
	inline function get_green():UInt 
	{
		return (this & 0x0000ff00) >>> 8;
	}
	
	inline function get_blue():UInt 
	{
		return this & 0x000000ff;
	}
	
	inline function get_alpha():UInt 
	{
		return this >>> 24;
	}
	
	inline function set_red(value:UInt):UInt 
	{
		this = (alpha << 24) | (value << 16) | (green << 8) | blue;
		return value;
	}
	
	inline function set_green(value:UInt):UInt 
	{
		this = (alpha << 24) | (red << 16) | (value << 8) | blue;
		return value;
	}
	
	inline function set_blue(value:UInt):UInt 
	{
		this = (alpha << 24) | (red << 16) | (green << 8) | value;
		return value;
	}
	
	inline function set_alpha(value:UInt):UInt 
	{
		this = (value << 24) | (red << 16) | (green << 8) | blue;
		return value;
	}
	
	static public function random(alpha:Null<Int>=null, red:Null<Int>=null, green:Null<Int>=null, blue:Null<Int>=null):Couleur
	{
		var randomCouleur:Couleur = 0x0;
		if (alpha == null) randomCouleur.alpha = Math.round(0xFF * Math.random());
		else randomCouleur.alpha = alpha;
		
		if (red == null) randomCouleur.red = Math.round(0xFF * Math.random());
		else randomCouleur.red = red;
		
		if (green == null) randomCouleur.green = Math.round(0xFF * Math.random());
		else randomCouleur.green = green;
		
		if (blue == null) randomCouleur.blue = Math.round(0xFF * Math.random());
		else randomCouleur.blue = blue;
		
		return randomCouleur;
	}

    static public function randomInRange(range:Array<Couleur>){
        return range[Std.random(range.length)];
    }

	@:from
	static public function fromString(s:String) {
		if (s.indexOf("#") == 0)		return new Couleur(Std.parseInt("0x" + s.substring(1, s.length)));
		else if (s.indexOf("0x") == 0)	return new Couleur(Std.parseInt(s));
		// unable to parse
		return new Couleur(0);
	}
	@:to
	static public function toFloat(n:Couleur):Float{
		return n*1.0;
	}
	@:from
	 static inline public function fromFloat(n:Float):Couleur{
		 return new Couleur(Std.int(n));
	}

	public function mix(color:Couleur, strength:Float):Couleur
	{
		var output:Couleur = new Couleur(0);
		output.red = Math.floor((red * (1 - strength)) + (color.red * strength));
		output.green = Math.floor((green * (1 - strength)) + (color.green * strength));
		output.blue = Math.floor((blue * (1 - strength)) + (color.blue * strength));
		output.alpha = Math.floor((alpha * (1 - strength)) + (color.alpha * strength));
		return output;
	}

    public function add(color:Couleur):Couleur
	{
        return this+color;
		// var output:Couleur = new Couleur(0);
		// output.red = Math.floor((red * (1 - strength)) + (color.red * strength));
		// output.green = Math.floor((green * (1 - strength)) + (color.green * strength));
		// output.blue = Math.floor((blue * (1 - strength)) + (color.blue * strength));
		// output.alpha = Math.floor((alpha * (1 - strength)) + (color.alpha * strength));
		// return output;
	}

    public function darken(strength:Float):Couleur{
        return mix(Noir,strength);
    }

    public function lighten(strength:Float):Couleur{
        return mix(Blanc,strength);
    }

	public function withAlpha(perc:Int):Couleur{
		return set_alpha(perc);
	}

    @:to
    public static function toHex(c:Couleur):String{
        return "#" + StringTools.hex(c);
    }   

	public function toString()
	{
		return "0x" + StringTools.hex(this, 8);
	}
}