// interfaces/Instantiable.java
// (c)2021 MindView LLC: see Copyright.txt
// We make no guarantees that this code is fit for any purpose.
// Visit http://OnJava8.com for more book information.

abstract class Uninstantiable {
  abstract void f();
  abstract int g();
}

public class Instantiable extends Uninstantiable {
  void f() { System.out.println("f()"); }
  int g() { return 22; }
  public static void main(String[] args) {
    Uninstantiable ui = new Instantiable();
  }
}
