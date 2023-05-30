// functional/TransformFunction.java
// (c)2021 MindView LLC: see Copyright.txt
// We make no guarantees that this code is fit for any purpose.
// Visit http://OnJava8.com for more book information.
import java.util.function.*;

class I {
  @Override public String toString() { return "I"; }
}

class O {

  @Override public String toString() { return "O"; }
}

class M {

  @Override
  public String toString() {
    return "M";
  }
}

public class TransformFunction {
  static Function<I, M> transform(Function<I, O> in) {
    return in.andThen(o -> {
      System.out.println(o);
      return new M();
    });
  }

  public static void main(String[] args) {
    String s = "GO HOME";
    System.out.println(s.substring(3));
    Function<I, M> f2 = transform(i -> {
      System.out.println(i);
      return new O();
    });
    M m = f2.apply(new I());
  }
}
/* Output:
I
O
*/
