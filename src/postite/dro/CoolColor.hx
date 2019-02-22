package postite.dro;
using StringTools;


@:enum abstract CoolColor(String) from String to String{
    var ocre="#dbae27";
    var brique ="#e63a00";
    var prusse="#004567";
    var olive="#808000";
    var violet="#4e0b42";
    var orange="#ff7b00";

    public static function random():CoolColor{
        return "#"+Math.floor(Math.random()*16777215).hex();
    }

}

