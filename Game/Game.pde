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
  int i=0;
  while(i<5){
   for(int a = 1; a < map.length-1; a++) {
      for(int b = 1; b < map[a].length-1; b++){
       int count = 0;
      
       if(map[a-1][b-1]=='#')
           count++;
       if(map[a-1][b]=='#')
           count++;
       if(map[a-1][b+1]=='#')
           count++;
       if(map[a][b-1]=='#')
           count++;
       if(map[a][b]=='#')
           count++;
       if(map[a][b+1]=='#')
           count++;
       if(map[a+1][b-1]=='#')
           count++;
       if(map[a+1][b]=='#')
           count++;
       if(map[a+1][b+1]=='#')
           count++;
           
       if(count>=5)
           map[a][b]='#';
       else
          map[a][b]='.';
          
       i++;
    }   
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

