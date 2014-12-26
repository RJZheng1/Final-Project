public class Characters {
  String name;
  char symbol;
  PVector loc;
  public Characters(String name, char symbol, int x, int y) {
    this.name = name;
    this.symbol = symbol;
    loc = new PVector(x, y);
  }
  public void addLoc(int x, int y) {
    loc.add(x, y, 0);
  }
  public int getX() {
    return int(loc.x);
  }
  public int getY() {
    return int(loc.y);
  }
  public void display() {
    text(symbol, loc.x, loc.y);
  }
}

