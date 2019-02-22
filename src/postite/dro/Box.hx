package postite.dro;




import postite.dro.Couleur;
import postite.geom.CoolPoint.Rect;



class Box{
    public var x:Float=.0;
    public var y:Float=.0;
    public var width:Float=.0;
    public var height:Float=.0;
    public var color:Couleur=0;

    public function new(?rect:Rect){

        if(rect!=null){
        this.x=rect.x;
        this.y=rect.y;
        this.width= rect.width;
        this.height=rect.height;
        }
    }
    public static function create(?couleur:Couleur):Box{
        couleur=(couleur!=null)? couleur : Couleur.Rouge;
        var box= new Box({x:0.,y:0.,width:100., height:100.,});
        box.color=couleur;
        
        return box;
    }

}