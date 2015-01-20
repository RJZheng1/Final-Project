public abstract class Item {
  String name;
  int min, max;
  public Item(String name, int min, int max) {
    this.name = name;
    this.min = min;
    this.max = max;
  }
  public int getNum() {
    return int(random(min, max+1));
  }
  public String getName() {
    return name;
  }
  public int getMin() {
    return min;
  }
  public int getMax() {
    return max;
  }
  public abstract void equip(PC Player, Terrain tile, int x);
}
public class Weapon extends Item {
  public Weapon(String name, int min, int max) {
    super(name, min, max );
  }
  public void equip(PC Player, Terrain tile, int x) {
    tile.loot.remove(x);
    tile.loot.add(Player.weapon);
    Player.weapon = this;
  }
}
public class Armor extends Item { 
  public Armor(String name, int min, int max ) {
    super(name, min, max );
  }
  public void equip(PC Player, Terrain tile, int x) {
    tile.loot.remove(x);
    tile.loot.add(Player.armor);
    Player.armor = this;
  }
}

