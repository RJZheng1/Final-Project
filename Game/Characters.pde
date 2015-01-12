import java.util.*;
public abstract class Characters {
  private String name;
  private char symbol;
  private PVector loc;
  private int HP;
  private boolean dead;
  Random r;
  public Characters() {
    this("Adventurer", '@', 20, 0, 0);
  }
  public Characters(String name, char symbol, int HP, int x, int y) {
    this.name = name;
    this.symbol = symbol;
    this.HP = HP;
    loc = new PVector(x, y);
    dead = false;
    r=new Random();
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
    return name + " did " + dmg + " damage to " + other.getName();
  }
}

public class PC extends Characters {
  public PC(String name) {
    super(name, '@', 20, 0, 0);
  }
  public String move(Terrain[][] map, ArrayList<Monster> Monsters, char k) {
    switch(k) {
    case '1':
      return moveHelper(map, Monsters, -1, 1);
      //break;
    case '2':
      return moveHelper(map, Monsters, 0, 1);
      //break;
    case '3':
      return moveHelper(map, Monsters, 1, 1);
      //break;
    case '4':
      return moveHelper(map, Monsters, -1, 0);
      //break;
    case '5':
      return "you wait";
      //break;
    case '6':
      return moveHelper(map, Monsters, 1, 0);
      //break;
    case '7':
      return moveHelper(map, Monsters, -1, -1);
      //break;
    case '8':
      return moveHelper(map, Monsters, 0, -1);
      //break;
    case '9':
      return moveHelper(map, Monsters, 1, -1);
      //break;
    }
    return "didn't move";
  }
  public String moveHelper(Terrain[][] map, ArrayList<Monster> Monsters, int x, int y) {
    if (detectMonster(map, x, y) && !Monsters.get(getMonster(map, x, y)).isDead()) {
      return attack(map,Monsters.get(getMonster(map, x, y)), 20);
    } else if (!detectWall(map, x, y)) {
      map[getX()][getY()].setEmpty(true);
      Player.addLoc(x, y);
      return "cant move";
    }
    return "you walked";
  }
}

public class Monster extends Characters {
  private boolean display;
  public Monster(String name, char symbol) {
    super(name, symbol, 20, 0, 0);
    display=false;
  }
  public void setDisplay(boolean i){
    display=i;
  }
  public boolean getDisplay(){
    return display;
  }
  public void spawn(Terrain[][] map, int i) {
    super.spawn(map);
    map[getX()][getY()].setEmpty(false);
    map[getX()][getY()].setMonster(i);
  }
  public void move4monsters(boolean display){
    if (display==true){
      move4monstersHelper(1,1);
    }else{
      move4monstersHelper(r.nextInt(3)-1,r.nextInt(3)-1);
    }
  }
  public void move4monstersHelper(int x, int y){
    addLoc(getX()+x,getY()+y);
  }
}

