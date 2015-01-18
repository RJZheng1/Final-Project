public class Item {
  String name;
  int range;
  int min;
  public Item(String name, int range, int min) {
    this.name = name;
    this.range = range;
    this.min = min;
  }
  public int getNum() {
    return int(random(range+1))+min;
  }
  public String getName(){
    return name;
  }
  public int getMin() {
    return min;
  }
  public int getMax() {
    return min+range;
  }
}
public class Weapon extends Item {
  public Weapon(String name , int range , int min) {
    super(name , range , min );
  }
}
public class Armor extends Item { 
  public Armor(String name, int range , int min ){
    super(name , range , min );
  }
}

