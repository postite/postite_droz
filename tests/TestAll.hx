package tests;
import utest.Runner;
import utest.ui.Report;
import tests.*;
class TestAll {


  public static function main() {
    //the long way
   'op'.log();
    //Log.debug("popo");
    trace( "hop");
    
    var runner = new Runner();
    
    runner.addCase(new TestGesteStatics());
   runner.addCase(new TestResample());
    runner.addCase(new TestGeste());
    runner.addCase(new TestCouleur());
    #if js
    runner.addCase(new TestApp());
    runner.addCase(new TestDisplay());
    #end
    runner.addCase(new TestVector2d());
    runner.addCase(new TestMatools());
    runner.addCase(new TestGeomFilters());
    runner.addCase(new TestCircle());
    //runner.addCase(new TestCase2());
    Report.create(runner);
    
    runner.run();
    
    // //the short way in case you don't need to handle any specifics
    // utest.UTest.run([new TestCase1(), new TestCase2()]);
  }

}