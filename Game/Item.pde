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
}

