import java.util.Scanner;

public class meteor {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n, m;
        n = scanner.nextInt();
        m = scanner.nextInt();
        int x, y, r;
        x = scanner.nextInt();
        y = scanner.nextInt();
        r = scanner.nextInt();

        int answer = 0;
        for (int houseX = 0; houseX < n; houseX++) {
            for (int houseY = 0; houseY < m; houseY++) {
                if (dist(houseX, houseY, x, y) <= r) {
                    answer++;
                }
            }
        }
        System.out.println(answer);
    }

    private static double dist(int x1, int y1, int x2, int y2) {
        return Math.sqrt(Math.pow(x1 - x2, 2) + Math.pow(y1 - y2, 2));
    }
}