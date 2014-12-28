Characters Player;
char[][] map;

void setup() {
  noLoop();
  size(800, 800);
  Player = new Characters("Player", '@', 400, 400);
  map = generateMap();
  ;
}

boolean inBounds(char[][] m, int x, int y) {
  return x >= 0 && x < m.length && y >= 0 && y < m[0].length;
}

int checkWalls(char[][] m, int x, int y, int range) {
  int count = 0;
  if (m[x][y] == '#')
    count++;
  for (int i = 1; i <= range; i++) {
    int xstart1 = x - i;
    int xstart2 = x - i;
    int xend = x + i;
    int ystart1 = y - i;
    int ystart2 = y - i;
    int yend = y + i;
    if (inBounds(m, xstart1, ystart1) && m[xstart1][ystart1] == '#')
      count++;
    if (inBounds(m, xend, yend) && m[xend][yend] == '#')
      count--;
    while (xstart1 != xend || ystart1 != yend) {
      if (xstart1 != xend) {
        xstart1++;
        ystart2++;
      } else {
        ystart1++;
        xstart2++;
      }
      if (inBounds(m, xstart1, ystart1) && m[xstart1][ystart1] == '#')
        count++;
      if (inBounds(m, xstart2, ystart2) && m[xstart2][ystart2] == '#')
        count++;
    }
  }
  return count;
}

char[][] generateMap() {
  char[][] m = new char[50][50];
  int[][] count1 = new int[50][50];
  int[][] count2 = new int[50][50];
  for (int x = 0; x < m.length; x++) {
    for (int y = 0; y < m[x].length; y++) {
      if (x==0 || x==m[x].length-1 || y==0 || y==m.length-1 || random(100)<40)
        m[x][y] = '#';
      else
        m[x][y] = '.';
    }
  }
  for (int i = 0; i < 7; i++) {
    for (int x = 1; x < m.length-1; x++) {
      for (int y = 1; y < m[x].length-1; y++) {
        count1[x][y] = checkWalls(m, x, y, 1);
        if (i < 4)
          count2[x][y] = checkWalls(m, x, y, 2);
      }
    }
    for (int x = 1; x < count1.length-1; x++) {
      for (int y = 1; y < count1[x].length-1; y++) {
        if ((count1[x][y]>=5) || (i<4 && count2[x][y]<=2))
          m[x][y] = '#';
        else
          m[x][y] = '.';
      }
    }
  }
  return m;
}

boolean detectWall(int x, int y) {
  return map[(Player.getX()+x)/16][(Player.getY()+y)/16-1] == '#';
}

void keyPressed() {
  switch(key) {
  case '1':
    if (!detectWall(-16, 16))
      Player.addLoc(-16, 16);
    break;
  case '2':
    if (!detectWall(0, 16))
      Player.addLoc(0, 16);
    break;
  case '3':
    if (!detectWall(16, 16))
      Player.addLoc(16, 16);
    break;
  case '4':
    if (!detectWall(-16, 0))
      Player.addLoc(-16, 0);
    break;
  case '5':
    break;
  case '6':
    if (!detectWall(16, 0))
      Player.addLoc(16, 0);
    break;
  case '7':
    if (!detectWall(-16, -16))
      Player.addLoc(-16, -16);
    break;
  case '8':
    if (!detectWall(0, -16))
      Player.addLoc(0, -16);
    break;
  case '9':
    if (!detectWall(16, -16))
      Player.addLoc(16, -16);
    break;
  }
  redraw();
}

void draw() {
  background(0);
  textSize(16);
  for (int x = 0; x < map.length; x++) {
    for (int y = 0; y < map[x].length; y++) {
      if (x*16 != Player.getX() || y*16 + 16 != Player.getY()) {
        text(map[x][y], x*16, y*16 + 16);
      }
    }
  }
  Player.display();
}

