package vendingmachine;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Scanner;

public class VendingMachine {

    private HashMap<String, Item> vmHash = new HashMap<>();
    private final String FILE = "ItemList.txt", DELIMITER = "::";

    public void save() {
        PrintWriter out = null;

        try {
            out = new PrintWriter(FILE);
            Collection<Item> col = vmHash.values();
            Iterator<Item> itr = col.iterator();

            while (itr.hasNext()) {
                Item curItem = itr.next();
                out.println(curItem.getName() + "::"
                        + curItem.getPrice() + "::"
                        + curItem.getLocation() + "::"
                        + curItem.getQty());
                out.flush();

            }
        } catch (IOException e) { //handles the error but it doesn't do anything with it if left open
            System.out.println("Error: " + e.getMessage());

        } finally {
            out.close();
        }
    }

    public void load() {
        PrintWriter out = null;
        Scanner sc = null;

        try {
            File inputFile = new File(FILE);
            sc = new Scanner(inputFile);
            while (sc.hasNextLine()) {
                Item curItem = new Item();
                //ordered as such 0:name, 1:price, 2:location,3:quantity
                String[] currentItem = sc.nextLine().split("::");
                curItem.setName(currentItem[0]);
                curItem.setPrice(Integer.parseInt(currentItem[1]));
                curItem.setLocation(currentItem[2]);
                curItem.setQty(Integer.parseInt(currentItem[3]));
                vmHash.put(currentItem[2], curItem);

            }
            sc.close();
        } catch (FileNotFoundException ex) {
            System.out.println("Error: " + ex.getMessage());
        }

    }

    public void add(Item item) {
        vmHash.put(item.getLocation(), item);
    }
    public Item getItem(String key){
        return vmHash.get(key);
    }

    //removed the Item attached to inputed key
    public void remove(String key) {
        vmHash.remove(key);
    }

    public void reduce(String key) {
        vmHash.get(key).setQty(vmHash.get(key).getQty() - 1);
    }

    public Item[] getList() {

        Collection<Item> col = vmHash.values();

        return col.toArray(new Item[col.size()]);
    }
}