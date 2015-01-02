public abstract class Characters {
  String name;
  char symbol;
  PVector loc;
  int HP;
  public Characters() {
    this("Adventurer", '@', 20, 0, 0);
  }
  public Characters(String name, char symbol, int HP, int x, int y) {
    this.name = name;
    this.symbol = symbol;
    this.HP = HP;
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
  public void spawn(Terrain[][] map) {
    int x;
    int y;
    while (true) {
      x = int(random(map.length-1)+1);
      y = int(random(map[x].length-1)+1);
      if (map[x][y].getType() != '#') {
        addLoc(x, y);
        break;
      }
    }
    map[x][y].setEmpty(false);
  }
  boolean detectWall(Terrain[][] map, int x, int y) {
    return map[getX()+x][getY()+y].getType() == '#';
  }
  boolean detectMonster(Terrain[][]map, int x, int y) {
    return !map[getX()+x][getY()+y].isEmpty();
  }
  int getMonster(Terrain[][]map, int x, int y) {
    return map[getX()+x][getY()+y].getMonster();
  }
  public int getHP() {
    return HP;
  }
  public void damage(int dmg) {
    HP -= dmg;
  }
}

public class PC extends Characters {
  public PC(String name) {
    super(name, '@', 20, 0, 0);
  }
  public void move(Terrain[][] map, ArrayList<Monster> Monsters, char k) {
    switch(k) {
    case '1':
      moveHelper(map, Monsters, -1, 1);
      break;
    case '2':
      moveHelper(map, Monsters, 0, 1);
      break;
    case '3':
      moveHelper(map, Monsters, 1, 1);
      break;
    case '4':
      moveHelper(map, Monsters, -1, 0);
      break;
    case '5':
      break;
    case '6':
      moveHelper(map, Monsters, 1, 0);
      break;
    case '7':
      moveHelper(map, Monsters, -1, -1);
      break;
    case '8':
      moveHelper(map, Monsters, 0, -1);
      break;
    case '9':
      moveHelper(map, Monsters, 1, -1);
      break;
    }
  }
  public void moveHelper(Terrain[][] map, ArrayList<Monster> Monsters, int x, int y) {
    if (detectMonster(map, x, y))
      Monsters.get(getMonster(map, x, y)).damage(map, 20);
    else if (!detectWall(map, x, y))
      Player.addLoc(x, y);
  }
}

public class Monster extends Characters {
  boolean dead;
  public Monster(String name, char symbol) {
    super(name, symbol, 20, 0, 0);
    dead = false;
  }
  public void spawn(Terrain[][] map, int i) {
    super.spawn(map);
    map[getX()][getY()].setEmpty(false);
    map[getX()][getY()].setMonster(i);
  }
  public void damage(Terrain[][] map, int dmg) {
    super.damage(dmg);
    if (getHP() <= 0) {
      map[getX()][getY()].setEmpty(true);
      dead = true;
    }
  }
  public boolean isDead() {
    return dead;
  }
}

