// reuse/Lisa.java
// (c)2021 MindView LLC: see Copyright.txt
// We make no guarantees that this code is fit for any purpose.
// Visit http://OnJava8.com for more book information.
// {WillNotCompile}
class Mill {
  protected int f1() {
    return 1;
  }
}

public class Lisa {
  public static void main(String[] args) {
    Mill m = new Mill();
    System.out.println(m.f1());
  }
}
