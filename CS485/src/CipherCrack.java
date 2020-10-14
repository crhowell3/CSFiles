import java.util.*;
import java.io.FileWriter;
import java.io.IOException;


public class CipherCrack {
    /**
     * Main function that controls all decryption processes
     * @param args default parameter for taking command line arguments
     */
    public static void main(String[] args) throws IOException {
        // Prompt user for a cipher code to crack
        Scanner scan = new Scanner(System.in);
        System.out.print("Welcome to CipherCrack!\nThis program will brute-force a Vigenere-enciphered ciphertext that has a known key period of 3.\nEnter a ciphertext to crack: ");
        String ciphertext = scan.next();
        crack(ciphertext.toUpperCase());
    }

    /**
     * This function runs through all possible decryption with keys of period length 3
     * @param text the enciphered text to be deciphered
     */
    static void crack(String text) throws IOException {
        FileWriter writer = new FileWriter("results.txt");

        String clearText;
        // Create a list of possible keys of period 3
        ArrayList<String> keyList = keyGenerator();
        writer.write("KEY : CLEARTEXT\n");
        for (String s : keyList) {
            clearText = decrypt(text, s);
            writer.write(s + " : " + clearText + "\n");
        }
        writer.close();
        System.out.println("Results have been written to results.txt!");
    }

    /**
     * Decrypt the ciphertext with a provided key, then print the result
     * @param text encrypted text to be cracked
     * @param key the key to be tested
     * @return the string produced by the decryption attempt
     */
    static String decrypt(String text, String key){
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
        return deciphered_text.toString();
    }

    /**
     * Method for creating an ArrayList of all possible keys of period 3
     * @return the generated ArrayList of possible keys
     */
    static ArrayList<String> keyGenerator() {
        char first = 'A';
        char second = 'A';
        char third = 'A';
        ArrayList<String> keys = new ArrayList<>();

        for (int i = 0; i < 26; i++){
            for (int j = 0; j < 26; j++){
                for (int k = 0; k < 26; k++){
                    String temp = String.valueOf(first) + second + third;
                    keys.add(temp);
                    third++;
                }
                third = 'A';
                second++;
            }
            second = 'A';
            first++;
        }

        return keys;
    }
}
