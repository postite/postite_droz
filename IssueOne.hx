using IssueOne.Tools;

class IssueOne {
  
  static var mAllPolys=[1,2,3];
  static function main() {
    trace("Haxe is great!");
    clear();
    trace(mAllPolys.length);
    
    
    
  }
  static public function clear():Void {
		for (i in 0...mAllPolys.length) {
			mAllPolys[i] = null;
		}
		mAllPolys.clear();
		
	}
}

class Tools{
  
  /** Empties an array of its contents. */
	static inline public function clear<T>(array:Array<T>)
	{
#if (cs || cpp || php || python || eval)
		array.splice(0, array.length);
#else
		untyped array.length = 0;
#end
	}
}