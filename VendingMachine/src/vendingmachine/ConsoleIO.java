package vendingmachine;

import java.util.Scanner;

public class ConsoleIO {
    
    Scanner sc = new Scanner (System.in);
    
    public int promptInt(String prompt) {
        
    int input = 0;
    boolean doOver;
    
            do {
                System.out.println(prompt);
            try {
                input = Integer.parseInt(sc.nextLine());
                doOver = false;
            } catch (NumberFormatException e) {
                doOver = true;
                System.out.println("Only integers, please.");
            }

            } while (doOver);

        return input;

    }
    
        public int promptInt(String prompt, int min, int max) {
            int a;

        do {
            a = promptInt(prompt);
        } while (a < min || a > max);
            return a;
    }

    public String promptString(String prompt) {
        System.out.println(prompt);
        return sc.nextLine();
    }
    
        public float promptFloat(String prompt) {

        float input = 0;
        boolean doOver;

        do {
            System.out.println(prompt);
            try {
                input = Float.parseFloat(sc.nextLine());
                doOver = false;
            } catch (NumberFormatException e) {
                doOver = true;
                System.out.println("Please enter a Float");
            }

        } while (doOver);

        return input;
    }

    public float promptFloat(String prompt, float min, float max) {
        float a;

        do {
            
            a = promptFloat(prompt);

        } while (a < min || a > max);
        return a;
    }

    public double promptDouble(String prompt) {
        double input = 0;
        boolean doOver;

        do {
            System.out.println(prompt);
            try {
                input = Double.parseDouble(sc.nextLine());
                doOver = false;
            } catch (NumberFormatException e) {
                doOver = true;
                System.out.println("Please enter a double");
            }

        } while (doOver);

        return input;

    }

    public double promptDouble(String prompt, double min, double max) {
        double a;

        do {
            
            a =  promptDouble(prompt);

        } while (a < min || a > max);
        return a;
    }

    public void toConsole(String prompt) {
        System.out.println(prompt);
    }
}