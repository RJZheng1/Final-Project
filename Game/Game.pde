PC Player;
Terrain[][] map;
ArrayList<Monster> Monsters;
int level=0;
String[] text = new String[3];

void setup() {
  noLoop();
  size(800, 800);
  map = new Terrain[45][45];
  Player = new PC("Player");
  Monsters = new ArrayList<Monster>();
  generateMap();
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
    x = int(random(map.length-1)+1);
    y = int(random(map[x].length-1)+1);
    if (map[x][y].getType() != '#' && map[x][y].getType() != '@') {
      map[x][y].setType('>');
      break;
    }
  }
}

void generateMap() {
  int[][] count1 = new int[45][45];
  int[][] count2 = new int[45][45];
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
  Player.spawn(map);
  for (int i = 0; i < 100; i++) {
    Monsters.add(new Monster("Zombie", 'Z', i));
    Monsters.get(i).spawn(map);
  }
  generateLadder();
  level++;
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
      Monsters.get(map[xstart][ystart].getMonster()).move(map, Player);
      Monsters.get(map[xstart][ystart].getMonster()).display();
    }
  }
}

void keyPressed() {
  if (key >= '1' && key <= '9')
    Player.move(map, Monsters, key);
  redraw();
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
}

