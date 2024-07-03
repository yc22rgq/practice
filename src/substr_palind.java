import java.util.Scanner;

public class substr_palind {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        int n = scanner.nextInt(); // Read the length of the string
        scanner.nextLine(); // Consume the newline
        String s = scanner.nextLine(); // Read the string
        int res = 0;

        for (int l = 0; l < n; l++) {
            for (int r = l; r < n; r++) {
                int cnt = 0;
                for (int i = l; i <= r; i++) {
                    // Check if characters at symmetric positions are different
                    if (s.charAt(i) != s.charAt(r - (i - l))) {
                        cnt++;
                    }
                }
                cnt /= 2; // Divide the count of differences by 2
                // Update result if the substring can be made palindrome by changing at most 1 character
                if (cnt <= 1) {
                    res = Math.max(res, r - l + 1);
                }
            }
        }
        System.out.println(res);
    }
}