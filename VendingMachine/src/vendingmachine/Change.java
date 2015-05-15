package vendingmachine;

public class Change {
    
    private int quarters, dimes, nickels, pennies;
    
    public Change convert(int money) {
        Change myChange = new Change();
        
        quarters = money/25;
        money = money%25;
        
        dimes = money/10;
        money = money%10;
        
        nickels = money/5;
        money = money%5;
        
        pennies = money;
        
        return this;
    }

    public int getQuarters() {
        return quarters;
    }

    public void setQuarters(int quarters) {
        this.quarters = quarters;
    }

    public int getDimes() {
        return dimes;
    }

    public void setDimes(int dimes) {
        this.dimes = dimes;
    }

    public int getNickels() {
        return nickels;
    }

    public void setNickels(int nickels) {
        this.nickels = nickels;
    }

    public int getPennies() {
        return pennies;
    }

    public void setPennies(int pennies) {
        this.pennies = pennies;
    }
    
}
