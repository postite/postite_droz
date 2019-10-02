package tests;

import postite.math.Matools;
import utest.Assert;

class TestMatools extends utest.Test {
	public function testLerp() {
		Assert.equals(1., Matools.lerp(1., 1., 1.));
	}

	public function testInverseLerp() {
		Assert.equals(1., Matools.inverseLerp(1., 1., 1.));
	}

	public function testScale() {
        Assert.equals(30,Matools.scale([2,6],[20,60],3));
    }
    public function testwrap(){
        Assert.equals(0, Matools.wrap(0,0));
    }
    public function testClamp(){
        Assert.equals(0,Matools.clamp(0,0,0));
    }

    public function testMin(){
        Assert.equals(1,Matools.min(1,2));
    }
    public function testMax(){
        Assert.equals(2,Matools.max(1,2));
    }
     public function nearequals()
    {
       
    }
}
