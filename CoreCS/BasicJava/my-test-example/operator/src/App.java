import java.util.*;

class Value {
    int i;
}
public class App {
    public static void main(String[] args) {
        Random rand = new Random(47);
        int c = rand.nextInt(26) + 'a';
        System.out.println(c);
    }

    static void printBinaryInt(String s, int i) {
        System.out.println(
                s + ", int: " + i + ", binary:\n " +
                        Integer.toBinaryString(i));
    }

    static void printBinaryLong(String s, long l) {
        System.out.println(
                s + ", long: " + l + ", binary:\n " +
                        Long.toBinaryString(l));
    }
}

class Cup {
    Cup(int marker) {
        System.out.println("Cup(" + marker + ")");
    }

    void f(int marker) {
        System.out.println("f(" + marker + ")");
    }
}

class Cups {
    static Cup cup1;
    static Cup cup2;
    static {
        cup1 = new Cup(1);
        cup2 = new Cup(2);
    }

    Cups() {
        System.out.println("Cups()");
    }
}

class OverloadingVarargs2 {
    static void f(float i, Character... args) {
        System.out.println("first");
    }

    static void f(Character... args) {
        System.out.println("second");
    }

    public static void main(String[] args) {
        f(1, 'a');
    }
}
