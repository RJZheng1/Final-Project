public abstract class Characters {
  private String name;
  private char symbol;
  private PVector loc;
  private int HP;
  private boolean dead;
  private float speed;
  private float turnCounter;
  public Characters() {
    this("Adventurer", '@', 20, 1, 0, 0);
  }
  public Characters(String name, char symbol, int HP, float speed, int x, int y) {
    this.name = name;
    this.symbol = symbol;
    this.HP = HP;
    this.speed = speed;
    turnCounter = 0;
    loc = new PVector(x, y);
    dead = false;
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
        loc.set(x, y);
        break;
      }
    }
  }
  public void setLoc(int x, int y) {
    loc.set(x, y);
  }
  public boolean detectWall(Terrain[][] map, int x, int y) {
    return map[getX()+x][getY()+y].getType() == '#';
  }
  public boolean detectMonster(Terrain[][]map, int x, int y) {
    return !map[getX()+x][getY()+y].isEmpty();
  }
  public int getMonster(Terrain[][]map, int x, int y) {
    return map[getX()+x][getY()+y].getMonster();
  }
  public int getHP() {
    return HP;
  }
  public void setHP(int HP) {
    this.HP = HP;
  }
  public String getName() {
    return name;
  }
  public void setDead(boolean dead) {
    this.dead = dead;
  }
  public boolean isDead() {
    return dead;
  }
  public String attack(Terrain[][] map, Characters other, int dmg) {
    other.setHP(other.getHP()-dmg);
    if (other.getHP() <= 0) {
      other.setDead(true);
      map[other.getX()][other.getY()].setEmpty(true);
    }
    return name + " did " + dmg + " damage to " + other.getName() + ". ";
  }
  public void turnUp(float x) {
    turnCounter += speed/x;
  }
  public void turnDown() {
    turnCounter -= 1.0;
  }
  public float getTurnCounter() {
    return turnCounter;
  }
  public float getSpeed() {
    return speed;
  }
  public void setSpeed(float speed) {
    this.speed=speed;
  }
}

public class PC extends Characters {
  Item weapon;
  Item armor;
  public PC(String name) {
    super(name, '@', 20, 1, 0, 0);
    weapon = new Item("Fists", 0, 20);
    armor = new Item("Rags", 1, 0);
  }
  public String move(Terrain[][] map, ArrayList<Monster> Monsters, char k) {
    turnUp(1);
    if (getTurnCounter() < 1)
      return "";
    switch(k) {
    case '1':
      return moveHelper(map, Monsters, -1, 1);
    case '2':
      return moveHelper(map, Monsters, 0, 1);
    case '3':
      return moveHelper(map, Monsters, 1, 1);
    case '4':
      return moveHelper(map, Monsters, -1, 0);
    case '5':
      return "";
    case '6':
      return moveHelper(map, Monsters, 1, 0);
    case '7':
      return moveHelper(map, Monsters, -1, -1);
    case '8':
      return moveHelper(map, Monsters, 0, -1);
    case '9':
      return moveHelper(map, Monsters, 1, -1);
    }
    return "";
  }
  public String moveHelper(Terrain[][] map, ArrayList<Monster> Monsters, int x, int y) {
    turnDown();
    if (detectMonster(map, x, y) && !Monsters.get(getMonster(map, x, y)).isDead()) {
      return attack(map, Monsters.get(getMonster(map, x, y)), weapon.getNum());
    } else if (!detectWall(map, x, y)) {
      Player.addLoc(x, y);
      if (map[getX()][getY()].getType() == '>')
        return "You see the ladder to the next level. Would you like to go down? Press 'y' to do so.";
      return "";
    }
    return "";
  }
  public int defense() {
    return armor.getNum();
  }
}

public class Monster extends Characters {
  private boolean display;
  int num;
  public Monster(String name, char symbol, float speed, int num) {
    super(name, symbol, 20, speed, 0, 0);
    display=false;
    this.num = num;
  }
  public void display() {
    super.display();
    display = true;
  }
  public void setDisplay(boolean i) {
    display=i;
  }
  public boolean getDisplay() {
    return display;
  }
  public void spawn(Terrain[][] map) {
    super.spawn(map);
    map[getX()][getY()].setEmpty(false);
    map[getX()][getY()].setMonster(num);
  }
  public String move(Terrain[][] map, PC player) {
    turnUp(player.getSpeed());
    if (getTurnCounter() < 1)
      return "";
    turnDown();
    int x = int(Math.signum(float(player.getX()-getX())));
    int y =  int(Math.signum(float(player.getY()-getY())));
    if (!detectWall(map, x, y) && map[getX()+x][getY()+y].isEmpty()) {
      if (player.getX() == getX() + x && player.getY() == getY() + y)
        return attack(map, player, 1);
      else {
        map[getX()][getY()].setEmpty(true);
        addLoc(x, y);
        map[getX()][getY()].setEmpty(false);
        map[getX()][getY()].setMonster(num);
      }
    }
    return "";
  }
  public String attack(Terrain[][] map, PC player, int dmg) {
    dmg -= player.defense();
    System.out.println(player.defense());
    if (dmg < 0)
      dmg = 0;
    player.setHP(player.getHP()-dmg);
    if (player.getHP() <= 0)
      player.setDead(true);
    return getName() + " did " + dmg + " damage to " + player.getName() + ". ";
  }
}

