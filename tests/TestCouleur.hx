package tests;
import utest.Assert;
import postite.dro.Couleur;
class TestCouleur extends utest.Test{
    
        var pureRed:Couleur=0xFF0000;
        var pureGreen:Couleur=0x00FF00;
        var pureBlue:Couleur=0x0000FF;
        var pureYellow=0xFFFF00;
   
    public function testNoir(){
        Assert.equals(0xCC3300,Rouge);
        Assert.equals("#CC3300",Rouge.toHex());
    }

    public function testDarken(){
        Assert.equals(Gris,Blanc.darken(.5));
    }
    public function testLighten(){
        Assert.equals(Gris,Noir.lighten(.5));
    }

    public function testMix(){
        
        var middleColor=new Couleur(0);
        middleColor.red=Math.floor(255/2);
        middleColor.green=Math.floor(255/2);
        Assert.equals(middleColor,pureRed.mix(pureGreen,.5));
        // rgb complementary
        Assert.equals(Gris,("#00007F":Couleur).add(middleColor));
         
    }

    public function testAdd(){
        Assert.equals(pureYellow,pureRed.add(pureGreen));
       
    }

}



