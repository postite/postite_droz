import utest.Runner;
import utest.ui.Report;

class TestAll {


  public static function main() {
    //the long way
    var runner = new Runner();
    runner.addCase(new TestGesteStatics());
   runner.addCase(new TestResample());
    runner.addCase(new TestGeste());
    //runner.addCase(new TestCase2());
    Report.create(runner);
    runner.run();

    // //the short way in case you don't need to handle any specifics
    // utest.UTest.run([new TestCase1(), new TestCase2()]);
  }

}