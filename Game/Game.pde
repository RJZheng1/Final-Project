PC Player;
char[][] map;

void setup() {
  noLoop();
  size(800, 800);
  map = new char[50][50];
  generateMap();
  Player = new PC("Player");
  Player.spawn(map);
}

boolean inBounds(int x, int y) {
  return x >= 0 && x < map.length && y >= 0 && y < map[x].length;
}

int checkWalls(int x, int y, int range) {
  int count = 0;
  if (map[x][y] == '#')
    count++;
  for (int i = 1; i <= range; i++) {
    int xstart1 = x - i;
    int xstart2 = x - i;
    int xend = x + i;
    int ystart1 = y - i;
    int ystart2 = y - i;
    int yend = y + i;
    if (inBounds(xstart1, ystart1) && map[xstart1][ystart1] == '#')
      count++;
    if (inBounds(xend, yend) && map[xend][yend] == '#')
      count--;
    while (xstart1 != xend || ystart1 != yend) {
      if (xstart1 != xend) {
        xstart1++;
        ystart2++;
      } else {
        ystart1++;
        xstart2++;
      }
      if (inBounds(xstart1, ystart1) && map[xstart1][ystart1] == '#')
        count++;
      if (inBounds(xstart2, ystart2) && map[xstart2][ystart2] == '#')
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
      if (x==0 || x==map[x].length-1 || y==0 || y==map.length-1 || random(100)<40)
        map[x][y] = '#';
      else
        map[x][y] = '.';
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
          map[x][y] = '#';
        else
          map[x][y] = '.';
      }
    }
  }
}

boolean detectWall(int x, int y) {
  return map[Player.getX()+x][Player.getY()+y] == '#';
}

void keyPressed() {
  switch(key) {
  case '1':
    if (!detectWall(-1, 1))
      Player.addLoc(-1, 1);
    break;
  case '2':
    if (!detectWall(0, 1))
      Player.addLoc(0, 1);
    break;
  case '3':
    if (!detectWall(1, 1))
      Player.addLoc(1, 1);
    break;
  case '4':
    if (!detectWall(-1, 0))
      Player.addLoc(-1, 0);
    break;
  case '5':
    break;
  case '6':
    if (!detectWall(1, 0))
      Player.addLoc(1, 0);
    break;
  case '7':
    if (!detectWall(-1, -1))
      Player.addLoc(-1, -1);
    break;
  case '8':
    if (!detectWall(0, -1))
      Player.addLoc(0, -1);
    break;
  case '9':
    if (!detectWall(1, -1))
      Player.addLoc(1, -1);
    break;
  }
  redraw();
}

void draw() {
  background(0);
  textSize(16);
  for (int x = 0; x < map.length; x++) {
    for (int y = 0; y < map[x].length; y++) {
      if (x != Player.getX() || y != Player.getY()) {
        text(map[x][y], x*16, y*16 + 16);
      }
    }
  }
  Player.display();
}

