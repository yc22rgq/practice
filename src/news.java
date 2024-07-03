import java.util.Scanner;

public class news {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n, p;
        n = scanner.nextInt();
        p = scanner.nextInt();
        int[] a = new int[2 * n]; // Extend the array size to accommodate the append operation
        for (int i = 0; i < n; i++) {
            a[i] = scanner.nextInt();
            a[n + i] = a[i]; // Append operation
        }

        int bestLen = n + 1;
        int bestI = -1;
        if (p == 0) {
            bestLen = 0;
            bestI = 0;
        }

        for (int i = 0; i < n; i++) {
            int sum = 0;
            for (int len = 1; len <= n; len++) {
                sum += a[i + len - 1];
                if (sum >= p) {
                    if (len < bestLen || (len == bestLen && i < bestI)) {
                        bestI = i;
                        bestLen = len;
                    }
                    break; // Exit the loop early as we found a valid subarray
                }
            }
        }

        if (bestLen <= n) {
            System.out.println((bestI + 1) + " " + bestLen);
        } else {
            System.out.println(-1);
        }
    }
}