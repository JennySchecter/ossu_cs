// polymorphism/PrivateOverride.java
// (c)2021 MindView LLC: see Copyright.txt
// We make no guarantees that this code is fit for any purpose.
// Visit http://OnJava8.com for more book information.
// Trying to override a private method
// {java polymorphism.PrivateOverride}
package polymorphism;

public class PrivateOverride {
  private void f() {
    System.out.println("private f()");
  }

  public void f2() {
    System.out.println("PrivateOverride f2()");
  }
  public static void main(String[] args) {
    Derived po = new Derived();
    po.f();
  }
}

class Derived extends PrivateOverride {
  public void f() { System.out.println("public f()"); }
  
  public void f2() {
    System.out.println("Derived f2()");
  }
}
/* Output:
private f()
*/
