Characters Player;
char[][] map;

void setup() {
  noLoop();
  size(800, 800);
  Player = new Characters("Player", '@', 400, 400);
  map = new char[50][50];
  for (int a = 0; a < map.length; a++) {
    for (int b = 0; b < map[a].length; b++) {
      if (random(100)<45)
        map[a][b] = '#';
      else
        map[a][b] = '.';
    }
  }
}

boolean detectWall(int x, int y) {
  return map[(Player.getX()+x)/16][(Player.getY()+y)/16] == '#';
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
  for (int a = 0; a < map.length; a++) {
    for (int b = 0; b < map[a].length; b++) {
      if (a*16 != Player.getX() || b*16 != Player.getY()) {
        text(map[a][b], a*16, b*16);
      }
    }
  }
  Player.display();
}

