import java.util.*;

public class Vigenere {
    /**
     * Main method for controlling the execution of the cipher functions
     * @param args default parameter for taking command line arguments
     */
    public static void main(String[] args) {
        // Prompt user to choose a cipher functionality
        Scanner scan = new Scanner(System.in);
        System.out.println("Would you like to encrypt a string or decrypt a code? Enter 1 for encrypt, 2 for decrypt: ");
        String input = scan.next();
        // Test for valid input
        if (input.equals("1")) {
            // Make call to the encryption function
            encryption(scan);
        } else if (input.equals("2")) {
            // Make call to the decryption function
            decryption(scan);
        } else {
            // Notify the user that they have provided an invalid key
            System.out.println("Invalid input!");
        }
    }

    /**
     * Encrypts a user-provided string with a user-provided key
     * @param scan the Scanner object for reading in the user's string and key
     */
    static void encryption(Scanner scan){
        // Get raw string for encryption
        System.out.println("Please enter text to be encrypted: ");
        String text = scan.next();
        text = text.toUpperCase();
        // Get key to encrypt string
        System.out.println("Now enter a key of length 3 for encoding: ");
        String key = scan.next();
        // Create a StringBuilder that creates the encrypted text incrementally
        StringBuilder cipher_text = new StringBuilder();
        // Create a key of the same length as the provided text
        StringBuilder keyBuilder = new StringBuilder(key);
        // Incrementally increase the length of the key
        for (int i = 0; ; i++){
            if (text.length() == i){
                i = 0;
            }
            if (text.length() == keyBuilder.length()){
                break;
            }
            keyBuilder.append(keyBuilder.charAt(i));
        }
        key = keyBuilder.toString().toUpperCase();

        // Create the cipher text with the user-provided string and key
        for (int i = 0; i < text.length(); i++){
            int mod = (text.charAt(i) + key.charAt(i)) % 26;
            mod += 'A';
            cipher_text.append((char) (mod));
        }
        // Print out the cipher text to the user
        System.out.println("Your encrypted text is: " + cipher_text.toString().toLowerCase());
        // Destruct the scanner object after use
        scan.close();
    }

    /**
     * Decrypts a user-provided cipher text with a user-provided key
     * @param scan the Scanner object for reading in the user's string and key
     */
    static void decryption(Scanner scan){
        // Get encrypted string for decryption
        System.out.println("Please enter text to be decrypted: ");
        String text = scan.next();
        text = text.toUpperCase();
        // Get a key from the user
        System.out.println("Now try a key of length 3 to decipher this text: ");
        String key = scan.next();
        // Create a StringBuilder that creates the encrypted text incrementally
        StringBuilder deciphered_text = new StringBuilder();
        // Create a key of the same length as the provided text
        StringBuilder keyBuilder = new StringBuilder(key);
        // Incrementally increase the length of the key
        for (int i = 0; ; i++){
            if (text.length() == i){
                i = 0;
            }
            if (text.length() == keyBuilder.length()){
                break;
            }
            keyBuilder.append(keyBuilder.charAt(i));
        }
        key = keyBuilder.toString().toUpperCase();

        // Create the cipher text with the user-provided string and key
        for (int i = 0; i < text.length(); i++){
            int mod = (text.charAt(i) - key.charAt(i) + 26) % 26;
            mod += 'A';
            deciphered_text.append((char) (mod));
        }
        // Print out the deciphered text to the user
        System.out.println("Your deciphered text is: " + deciphered_text.toString().toLowerCase());
        // Destruct the Scanner object after use
        scan.close();
    }
}
