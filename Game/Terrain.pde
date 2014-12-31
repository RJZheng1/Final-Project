public class Terrain() {
  char type;
  boolean empty;
  public Terrain() {
    empty = true;
  }
  public boolean getType(){
    return type; 
  }
  public void setWall(){
    type = '#';
  }
  public void setEmpty(){
    type = '.';
  }
  public void setEmpty(boolean p){
    empty = p; 
  }
  public boolean getEmpty(){
    return empty;
  }
}

