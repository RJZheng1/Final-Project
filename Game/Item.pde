public class Item {
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
}
public class Weapon extends Item {
  public Weapon(String name, int min, int max) {
    super(name, min, max );
  }
}
public class Armor extends Item { 
  public Armor(String name, int min, int max ) {
    super(name, min, max );
  }
}

