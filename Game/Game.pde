PC Player;
Terrain[][] map;
ArrayList<Monster> Monsters;
int level=0;
String text;
ArrayList<String> todisplay=new ArrayList<String>(10);
void setup() {
  noLoop();
  size(1200, 800);
  map = new Terrain[45][45];
  Player = new PC("Player");
  Monsters = new ArrayList<Monster>();
  for (int x = 0; x < map.length; x++) {
    for (int y = 0; y < map[x].length; y++)
      map[x][y] = new Terrain();
  }
  generateMap();
  text += "You begin your descent into the cave, hungry for the legendary treasure of the ruthless Baron. The walls are damp and slimy, but you are undaunted.";
}
boolean inBounds(int x, int y) {
  return x >= 0 && x < map.length && y >= 0 && y < map[x].length;
}

int checkWalls(int x, int y, int range) {
  int count = 0;
  if (map[x][y].getType() == '#')
    count++;
  for (int i = 1; i <= range; i++) {
    int xstart1 = x - i;
    int xstart2 = x - i;
    int xend = x + i;
    int ystart1 = y - i;
    int ystart2 = y - i;
    int yend = y + i;
    if (inBounds(xstart1, ystart1) && map[xstart1][ystart1].getType() == '#')
      count++;
    if (inBounds(xend, yend) && map[xend][yend].getType() == '#')
      count--;
    while (xstart1 != xend || ystart1 != yend) {
      if (xstart1 != xend) {
        xstart1++;
        ystart2++;
      } else {
        ystart1++;
        xstart2++;
      }
      if (inBounds(xstart1, ystart1) && map[xstart1][ystart1].getType() == '#')
        count++;
      if (inBounds(xstart2, ystart2) && map[xstart2][ystart2].getType() == '#')
        count++;
    }
  }
  return count;
}

void generateLadder() {
  int x;
  int y;
  while (true) {
    x = int(random(map.length));
    y = int(random(map[x].length));
    if (map[x][y].getType() != '#' && map[x][y].isEmpty()) {
      map[x][y].setType('>');
      break;
    }
  }
}

void generateMap() {
  level++;
  text = "You are on level " + level +".";
  if ( level != 1 ) {
    for (int x = 0; x < map.length; x++) {
      for (int y = 0; y < map[x].length; y++)
        map[x][y].setEmpty(true);
    }
    int[][] count1 = new int[45][45];
    int[][] count2 = new int[45][45];
    for (int x = 0; x < map.length; x++) {
      for (int y = 0; y < map[x].length; y++) {
        if (x==0 || x==map[x].length-1 || y==0 || y==map.length-1 || random(100)<40)
          map[x][y].setType('#');
        else
          map[x][y].setType('.');
      }
    }
    for (int i = 0; i < 7; i++) {
      for (int x = 1; x < map.length-1; x++) {
        for (int y = 1; y < map[x].length-1; y++) {
          count1[x][y] = checkWalls(x, y, 1);
          if (i < 4)
            count2[x][y] = checkWalls(x, y, 2);
        }
      }
      for (int x = 1; x < count1.length-1; x++) {
        for (int y = 1; y < count1[x].length-1; y++) {
          if ((count1[x][y]>=5) || (i<4 && count2[x][y]<=2))
            map[x][y].setType('#');
          else
            map[x][y].setType('.');
        }
      }
    }
    Player.spawn(map);
    Monsters.clear();
    for (int i = 0; i < 1; i++) {
      Monsters.add(new Monster("Zombie", 'Z', 0.5, i));
      Monsters.get(i).spawn(map);
    }
    generateLadder();
  } else {
    Player.setLoc(23, 23);
    while (true) {
      int a = 13;
      for ( int b = 0; b < map[a].length; b++) {
        map[a][b].setType('#');
      }
      break;
    }
    while (true) {
      int a = map.length-12;
      for ( int b = 0; b < map[a].length; b++) {
        map[a][b].setType('#');
      }
      break;
    }
    while (true) {
      int a = 13;
      for ( int b = 0; b < map[a].length; b++) {
        map[b][a].setType('#');
      }
      break;
    }
    while (true) {
      int a = map.length-12;
      for ( int b = 0; b < map[a].length; b++) {
        map[b][a].setType('#');
      }
      break;
    }
  }
  for ( int a = 0; a < map.length; a++ ) {
    for ( int b = 0; b < map[a].length; b++) {
      if ( map[a][b].getType()!= '#' ) {
        map[a][b].setType('.');
      }
    }
  }
}

void fov(int x, int y, int r) {
  for (int a = -r; a<=r; a++) {
    for (int b = -r; b<=r; b++) {
      if (inBounds(x+a, y+b) && a*a+b*b<=r*r)
        los(x, y, x+a, y+b);
    }
  }
}

void los(int xstart, int ystart, int xend, int yend) {
  float slope;
  if (xend == xstart)
    slope = 50*Math.signum(yend-ystart);
  else
    slope = float((yend - ystart))/(xend - xstart);
  int xchange = int(Math.signum(xend - xstart));
  int ychange = int(Math.signum(yend - ystart));
  float m = slope;
  int mturn = int(Math.signum(slope));
  while (xstart != xend || ystart != yend) {
    if (map[xstart][ystart].getType() == '#')
      break;
    if (Math.abs(m) > 1) {
      ystart += ychange;
      m -= mturn;
    } else if (Math.abs(m) == 1) {
      xstart += xchange;
      ystart += ychange;
      m = slope;
    } else {
      xstart += xchange;
      m += slope;
    }
    if (map[xstart][ystart].isEmpty()) {
      text(map[xstart][ystart].getType(), xstart*16, ystart*16+16);
    } else if (!Monsters.get(map[xstart][ystart].getMonster()).isDead() && !Monsters.get(map[xstart][ystart].getMonster()).getDisplay()) {
      text += Monsters.get(map[xstart][ystart].getMonster()).move(map, Player);
      Monsters.get(map[xstart][ystart].getMonster()).display();
    }
  }
}

void keyPressed() {
  if (key >= '1' && key <= '9')
    text = Player.move(map, Monsters, key);
  else if (key == 'y' && map[Player.getX()][Player.getY()].getType() == '>')
    generateMap();
  redraw();
}
void inMenu() {
  todisplay.clear();
  todisplay.add("Player");
  todisplay.add("HP: "+Player.getHP());
  todisplay.add("Speed: "+Player.getSpeed());
}
void playerMenu(int xstart, int ystart) {
  for ( int i = 0; i < todisplay.size (); i++) {
    text(todisplay.get(i), xstart+4, ystart+i*32+16);
  }
}
void draw() {
  background(0);
  textSize(16);
  for (Monster m : Monsters)
    m.setDisplay(false);
  fov(Player.getX(), Player.getY(), 10);
  Player.display();
  fill(255, 255, 255);
  rect(0, 735, 800, 3);
  text(text, 0, 736, 800, 56);
  rect(800, 0, 3, 800);
  rect(800, 600, 1200, 3);
  inMenu();
  playerMenu(800, 0);
}

