// ../tanh.chpl
// 
// AUTO-GENERATED, DO NOT EDIT.  See gen/ directory.
// 
config param n = 10;
var D = {0..n};
var A : [D] real;
var B : [D] real;
var s = (3.0 - -3.0) / n;
var m = -3.0;
A = [i in D] s * i + m;
B = tanh(A);
writeln(A);
writeln(B);
