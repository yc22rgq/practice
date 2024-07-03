import java.util.Scanner;

public class spavochka {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        final int MAX_N = 100010;
        int n, t;
        n = scanner.nextInt();
        t = scanner.nextInt();
        int[] a = new int[MAX_N];
        int[] nx = new int[MAX_N], pr = new int[MAX_N];
        int st = 0, fi;

        for (int i = 0; i < t; i++) {
            a[i] = scanner.nextInt() - 1;
        }

        fi = n - 1;
        for (int i = 0; i < n; i++) {
            pr[i] = i - 1;
            nx[i] = i + 1;
        }
        nx[fi] = -1;

        for (int i = 0; i < t; i++) {
            if (a[i] == fi) continue;
            if (nx[a[i]] != -1) pr[nx[a[i]]] = pr[a[i]];
            if (pr[a[i]] != -1) nx[pr[a[i]]] = nx[a[i]];
            if (a[i] == st && n > 1) st = nx[a[i]];
            nx[fi] = a[i];
            pr[a[i]] = fi;
            nx[a[i]] = -1;
            fi = a[i];
        }

        int i = st;
        while (i != -1) {
            System.out.print((i + 1) + " ");
            i = nx[i];
        }
        System.out.println();
    }
}