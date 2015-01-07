PC Player;
Terrain[][] map;
ArrayList<Monster> Monsters;

void setup() {
  noLoop();
  size(800, 800);
  map = new Terrain[50][50];
  generateMap();
  Player = new PC("Player");
  Player.spawn(map);
  Monsters = new ArrayList<Monster>();
  for (int i = 0; i < 10; i++) {
    Monsters.add(new Monster("Zombie", 'Z'));
    Monsters.get(i).spawn(map, i);
  }
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

void generateMap() {
  int[][] count1 = new int[50][50];
  int[][] count2 = new int[50][50];
  for (int x = 0; x < map.length; x++) {
    for (int y = 0; y < map[x].length; y++) {
      map[x][y] = new Terrain();
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
}

//void fov(int x, int y, int r) {
//  for (int a = -r; a <= r; a++) {
//    for (int b = -r; b<=r; b++) {
//      if (inBounds(a, b) && a*a+b*b<=r*r)
//        los(x, y, a, b);
//    }
//  }
//}

void keyPressed() {
  if (key >= '0' && key <= '9')
    Player.move(map, Monsters, key);
  redraw();
}

void draw() {
  background(0);
  textSize(16);
  for (int x = 0; x < map.length; x++) {
    for (int y = 0; y < map[x].length; y++) {
      if (map[x][y].isEmpty() && (x != Player.getX() || y != Player.getY()))
        text(map[x][y].getType(), x*16, y*16 + 16);
    }
  }
  Player.display();
  for (Monster m : Monsters) {
    if (!m.isDead())
      m.display();
  }
}

