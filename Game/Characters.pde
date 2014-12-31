public abstract class Characters {
  String name;
  char symbol;
  PVector loc;
  public Characters() {
    this("Adventurer", '@', 0, 0);
  }
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
    text(symbol, loc.x*16, loc.y*16+16);
  }
  public void spawn(char[][] map) {
    int x;
    int y;
    while (true) {
      x = int(random(map.length-1)+1);
      y = int(random(map.length-1)+1);
      if (map[x][y] != '#') {
        addLoc(x, y);
        break;
      }
    }
  }
}

public class PC extends Characters {
  public PC(String name) {
    super(name, '@', 0, 0);
  }
}
