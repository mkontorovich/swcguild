package vendingmachine;

import java.util.HashMap;

public class ConsoleUI {

    ConsoleIO io = new ConsoleIO();
    VendingMachine vend = new VendingMachine();

    public static void main(String[] args) {
        ConsoleUI ui = new ConsoleUI();
        

        boolean quit = false;

        ui.load();

        do {
            ui.showItems();

            int choice = ui.displayChoices();

            switch (choice) {
                case 1:
                    ui.save();
                    quit = true;
                    break;
                case 2:
                    ui.vendItem();
                    break;
                case 3:
                    ui.askAddItem();
                    ui.save();
                    break;
            }
        } while (!quit);
    }
    public void load(){
        vend.load();
    }

    public void save(){
        vend.save();
    }
    
    public void showItems() {
        Item[] items = vend.getList();
        System.out.println("");
        for (int i = 0; i < items.length; i++) {
            io.toConsole("Name: " + items[i].getName() + "\t"
                    + "Location: " + items[i].getLocation() + "\t"
                    + "Price: " + items[i].getPrice() + "\t"
                    + "Quantity: " + items[i].getQty());
        }
        System.out.println("");
    }

    public void askAddItem() {
        Item it = new Item();
        it.setName(io.promptString("Item name: "));
        it.setLocation(io.promptString("Item coordinates: "));
        it.setPrice((int) (io.promptFloat("Price of item: $", 0, 100) * 100));
        it.setQty(io.promptInt("Quantity of item: ", 0, 100));
        vend.add(it);

    }

    public int displayChoices() {
        return io.promptInt("Please select an option\n"
                + "1 - Quit program\n"
                + "2 - Item Coordinates\n"
                + "3 - Add Item", 1, 3);
    }

    public void vendItem() {
        Item pick = new Item();
        int money = 0;
        boolean enoughMoney = true;

        do {
            String choice = io.promptString("Please enter Order Number: ");
            pick = vend.getItem(choice);
            money += (int) (io.promptFloat("How much money was entered? $", 1, 1000) * 100);
            if (money - pick.getPrice() >= 0) {
                enoughMoney = true;
            } else {
                enoughMoney = false;
                io.toConsole("Please pick another item or insert more money\n");
            }
        } while (!enoughMoney);
        pick.setQty(pick.getQty() - 1);
        money = money - pick.getPrice();
        Change cha = new Change();
        cha = cha.convert(money);
        io.toConsole("The user receives " + cha.getQuarters() + " quarters " + cha.getDimes() + " dimes "
                + cha.getNickels() + " nickels " + cha.getPennies() + " pennies");
    }
}