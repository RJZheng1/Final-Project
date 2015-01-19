public class Terrain {
  char type;
  boolean empty;
  int monster;
  ArrayList<Item> loot = new ArrayList<Item>();
  public Terrain() {
    setEmpty(true);
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
  public int getMonster() {
    return monster;
  }
  public void setMonster(int monster) {
    this.monster = monster;
  }
}

