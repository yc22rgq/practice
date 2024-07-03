import java.util.ArrayList;
import java.util.Scanner;

public class candies {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n, s;
        n = scanner.nextInt();
        s = scanner.nextInt();
        ArrayList<Integer> a = new ArrayList<>();

        if (s == 0) {
            for (int i = 1; i <= n / 2; i++) {
                a.add(i);
                a.add(-i);
            }
            if (n % 2 == 1) {
                a.add(0);
            }
        } else {
            a.add(s);
            int i = 1;
            while (a.size() <= n - 2) {
                if (i != s && i != -s) {
                    a.add(i);
                    a.add(-i);
                }
                i++;
            }
            if (a.size() != n) {
                a.add(0);
            }
        }

        System.out.println("YES");
        for (int i = 0; i < a.size(); i++) {
            System.out.print(a.get(i) + " ");
        }
        System.out.println();
    }
}