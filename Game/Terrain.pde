public class Terrain {
  char type;
  boolean empty, filled;
  int monster;
  ArrayList<Item> loot = new ArrayList<Item>();
  public Terrain() {
    setEmpty(true);
    setFilled(false);
  }
  public char getType() {
    if (loot.size() > 0)
      return '*';
    return type;
  }
  public void setType(char t) {
    type = t;
  }
  public void setEmpty(boolean p) {
    empty = p;
  }
  public boolean isEmpty() {
    return empty;
  }
  public void setFilled(boolean p) {
    filled = p;
  }
  public boolean isFilled() {
    return filled;
  }
  public int getMonster() {
    return monster;
  }
  public void setMonster(int monster) {
    this.monster = monster;
  }
}

