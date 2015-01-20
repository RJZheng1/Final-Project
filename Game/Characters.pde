public abstract class Characters {
  private String name;
  private char symbol;
  private PVector loc;
  private int HP;
  private boolean dead;
  private float speed;
  private float turnCounter;
  private int exp;
  private int skill;
  private int maxHP;
  public Characters() {
    this("Adventurer", '@', 20, 1, 0, 0);
  }
  public Characters(String name, char symbol, int HP, float speed, int x, int y) {
    this.name = name;
    this.symbol = symbol;
    this.HP = HP+skill;
    maxHP=this.HP;
    this.speed = speed;
    turnCounter = 0;
    loc = new PVector(x, y);
    dead = false;
    exp=0;
    skill=0;
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
  public int getExp() {
    return exp;
  }
  public void setExp(int i) {
    exp=i;
  }
  public int getSkill() {
    return skill;
  }
  public void setSkill(int i) {
    skill=i;
  }
  public int getMaxHP() {
    return maxHP;
  }
  public void setMaxHP(int i) {
    maxHP=i;
  }
  public int roll() {
    return int(random(20));
  }
}

public class PC extends Characters {
  Weapon weapon;
  Armor armor;
  public PC(String name) {
    super(name, '@', 20, 1, 0, 0);
    weapon = new Weapon("Sword", 3, 4, 0);
    armor = new Armor("Breastplate", 0, 0, 0);
  }
  public void reset() {
    setHP(20);
    setSpeed(1.0);
    setSkill(0);
    setExp(0);
    weapon = new Weapon("Sword", 3, 4, 0);
    armor = new Armor("Breastplate", 0, 0, 0);
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
  public String attack(Terrain[][] map, Monster other, int dmg) {
    other.setHP(other.getHP()-dmg);
    if (other.getHP() <= 0) {
      setExp(getExp()+1);
      if (getExp()==10+getSkill()) {
        setSkill(getSkill()+1);
        setMaxHP(getMaxHP()+getSkill());
        setHP(getMaxHP());
        setExp(0);
      }
      other.drop(map);
      other.setDead(true);
      map[other.getX()][other.getY()].setEmpty(true);
    }
    return "You did " + dmg + " damage to " + other.getName() + ". ";
  }
  public String moveHelper(Terrain[][] map, ArrayList<Monster> Monsters, int x, int y) {
    if (getHP()+1>getMaxHP()) {
      setHP(getMaxHP());
    } else {
      setHP(getHP()+1);
    }
    turnDown();
    if (detectMonster(map, x, y) && !Monsters.get(getMonster(map, x, y)).isDead()) {
      if (roll(true) < Monsters.get(getMonster(map, x, y)).roll())
        return "You missed. ";
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
  public int roll(boolean atk) {
    if (atk)
      return roll() + weapon.getDEX();
    return roll() + armor.getDEX();
  }
}

public class Monster extends Characters {
  private boolean display;
  int num;
  int dmg;
  public Monster(String name, char symbol, int HP, float speed, int num, int dmg) {
    super(name, symbol, HP, speed, 0, 0);
    display=false;
    this.num = num;
    this.dmg = dmg;
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
  public int getDmg() {
    return dmg;
  }
  public String move(Terrain[][] map, PC player, int dmg) {
    turnUp(player.getSpeed());
    if (getTurnCounter() < 1)
      return "";
    turnDown();
    int x = int(Math.signum(float(player.getX()-getX())));
    int y =  int(Math.signum(float(player.getY()-getY())));
    if (!detectWall(map, x, y) && map[getX()+x][getY()+y].isEmpty()) {
      if (player.getX() == getX() + x && player.getY() == getY() + y)
        return attack(map, player, dmg);
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
    if (player.roll(false) > roll())
      return getName() + " missed. ";
    dmg -= player.defense();
    if (dmg < 0)
      dmg = 0;
    player.setHP(player.getHP()-dmg);
    if (player.getHP() <= 0)
      player.setDead(true);
    return getName() + " did " + dmg + " damage to you. ";
  }
  public void drop(Terrain[][] map) {
    float rand = random(100);
    if (rand < 25)
      map[getX()][getY()].loot.add(new Weapon("Sword", int(random(0.5*dmg, 1*dmg))+4, int(random(1.5*dmg, 2*dmg))+4, int(random(-dmg/2, dmg*1.5))));
    else if (rand < 50)
      map[getX()][getY()].loot.add(new Armor("Breastplate", int(random(0.5*dmg, 1*dmg)), int(random(1.5*dmg, 2*dmg)), int(random(-dmg/2, dmg*1.5))));
  }
  public int roll() {
    return super.roll() + dmg;
  }
}

