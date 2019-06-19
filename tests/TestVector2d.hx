package tests;
import utest.Assert;
import geom.Vector2d;
class TestVector2d extends utest.Test{

    public function testTest(){
        Assert.isTrue(1==1);
    }

    public function testVector(){
        var vec:geom.Vector2d =new Vector2d(10,20);
        var magn=vec.magnitude;
        Assert.equals(10,magn);
    }

}

