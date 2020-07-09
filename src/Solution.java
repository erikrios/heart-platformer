import java.util.Scanner;

public class Solution {

    public static void main(String[] args) {

        Scanner scanner = new Scanner(System.in);

        int number = 1;

        do {
            String input = scanner.nextLine();
            System.out.println(number + " " + input);
            number++;
        } while (scanner.hasNext());
    }
}
