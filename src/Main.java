import java.util.Scanner;

public class Main {
    public static void main(String[] args) {
        Scanner in = new Scanner(System.in);

        System.out.println("1. Какая самая быстрая плавающая рептилия?");
        System.out.println("\t1. Крокодил\n\t2. Комодосский варан\n\t3. Плавающая черепаха");

        int a = in.nextInt(), b = 0;
        switch (a) {
            case 1, 2:
                System.out.println("Не правильно!\nПравильный ответ 3. Плавающая черепаха");
                break;
            case 3:
                System.out.println("Правильно! Ты получаешь 1 балл!");
                b++;
                break;
        }

        System.out.println("2. Крокодилы жили бок о бок с динозаврами и мало изменились за");
        System.out.println("\t1. 3 млн. лет\n\t2. 65 млн. лет\n\t3. 300 млн. лет");

        a = in.nextInt();
        switch (a) {
            case 1, 3:
                System.out.println("Не правильно!\nПравильный ответ 2. 65 млн. лет");
                break;
            case 2:
                System.out.println("Правильно! Ты получаешь 1 балл!");
                b++;
                break;
        }

        System.out.println("3. Самая оперенная птица (свыше 25000 перьев)");
        System.out.println("\t1. Лебедь\n\t2. Голубь\n\t3. Воробей");

        a = in.nextInt();
        switch (a) {
            case 2, 3:
                System.out.println("Не правильно!\nПравильный ответ 1. Лебедь");
                break;
            case 1:
                System.out.println("Правильно! Ты получаешь 1 балл!");
                b++;
                break;
        }

        System.out.printf("Ты набрал %d баллов", b);
    }
}