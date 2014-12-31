public class Terrain {
  char type;
  boolean empty;
  public Terrain() {
    setEmpty(true);
  }
  public char getType() {
    return type;
  }
  public void setType(char t) {
    type = t;
  }
  public void setEmpty(boolean p) {
    empty = p;
  }
  public boolean getEmpty() {
    return empty;
  }
}

