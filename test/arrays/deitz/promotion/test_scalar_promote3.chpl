def foo(i : int) {
  return i**2;
}

var s : seq of int = _seq( 1, 2, 3, 4 );

writeln(foo(s));
