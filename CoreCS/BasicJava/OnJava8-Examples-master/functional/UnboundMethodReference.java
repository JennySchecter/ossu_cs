// functional/UnboundMethodReference.java
// (c)2021 MindView LLC: see Copyright.txt
// We make no guarantees that this code is fit for any purpose.
// Visit http://OnJava8.com for more book information.
// Method reference without an object

class X {
  String f(String s) { return "X::f("+s+")"; }
}

interface MakeString {
  String make();
}

interface TransformX {
  String transform(X x,String s);
}

public class UnboundMethodReference {
  public static void main(String[] args) {
    // MakeString ms = X::f;                // [1]
    TransformX sp = X::f;
    X x = new X();
    System.out.println(sp.transform(x,"s"));    // [2]
    System.out.println(x.f("s")); // Same effect
  }
}
/* Output:
X::f()
X::f()
*/
