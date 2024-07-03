import java.util.Scanner;

public class cake {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = scanner.nextInt();
        int m = scanner.nextInt();
        int ans = 0;

        if (m >= 3) {
            ans = Math.max(ans, n * m - 2 * n);
        }
        if (n >= 3) {
            ans = Math.max(ans, n * m - 2 * m);
        }
        if (n >= 2 && m >= 2) {
            ans = Math.max(ans, n * m - n - m + 1);
        }

        System.out.println(ans);
    }
}