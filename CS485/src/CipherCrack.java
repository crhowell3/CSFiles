import java.util.*;

public class CipherCrack {
    public static void main(String[] args){
        // Prompt user for a cipher code to crack
        Scanner scan = new Scanner(System.in);
        System.out.print("Welcome to CipherCrack!\nThis program will crack a Vigenere-enciphered ciphertext that has a known key period of 3.\nEnter a ciphertext to crack: ");
        String ciphertext = scan.next();
        crack(ciphertext.toUpperCase());
    }

    static void crack(String text){
        ArrayList<Character> arr1 = new ArrayList<>(), arr2 = new ArrayList<>(), arr3  = new ArrayList<>();
        for (int i = 0; i < text.length(); i++){
            if (i % 3 == 2) {
                arr1.add(text.charAt(i));
            } else if (i % 3 == 1) {
                arr2.add(text.charAt(i));
            } else {
                arr3.add(text.charAt(i));
            }
        }

    }
}
