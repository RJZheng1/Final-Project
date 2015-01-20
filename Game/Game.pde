PC Player;
Terrain[][] map;
ArrayList<Monster> Monsters;
int level=0;
String text;
ArrayList<String> todisplay = new ArrayList<String>(10);

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
  text = "You begin your descent into the cave, hungry for the legendary treasure of the ruthless Baron. The walls are damp and slimy, but you are undaunted.";
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
    if (map[x][y].getType() == '.') {
      map[x][y].setType('>');
      break;
    }
  }
}

void generateMap() {
  for ( int x = 0; x < map.length; x ++ ) {
    for ( int y = 0; y < map[x].length; y ++ ) {
      map[x][y].setEmpty(true);
    }
  }
  level++;
  text = "You are on level " + level +".";
  Monsters.clear();
  if ( level != 2 ) {
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
    generateLadder();
    Player.spawn(map);
    for (int i = 0; i < 9+level; i++) {
      Monsters.add(new Monster("Zombie", 'Z', 19+level, 0.5, i, level));
      Monsters.get(i).spawn(map);
    }
  } else {
    for ( int x = 0; x < map.length; x ++ ) {
      for ( int y = 0; y < map[x].length; y ++ ) {
        map[x][y].setType('.');
      }
    }
    Player.setLoc(23, 23);
    for ( int x = 0; x < map.length; x ++) {
      for ( int y = 0; y <map[x].length; y ++) {
        if ( x <=13 || x >= map.length-12) {
          map[x][y].setType('#');
        }
        if (y <= 13 || y >= map.length-12) {
          map[x][y].setType('#');
        }
      }
    }
    Monsters.add(new Monster("Baron", 'B', 500, .75, 0, 20));
    Monsters.get(0).spawn(map);
    text="You see the gruesome Baron in front of you. Although your knees are shaking, you do not give in to the fear. You draw your weapon and charge.";
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
      text += Monsters.get(map[xstart][ystart].getMonster()).move(map, Player, Monsters.get(map[xstart][ystart].getMonster()).getDmg());
      Monsters.get(map[xstart][ystart].getMonster()).display();
    }
  }
}

void keyPressed() {
  if (key >= '1' && key <= '9')
    text = Player.move(map, Monsters, key);
  else if (key >= 'a' && key < 'a' + map[Player.getX()][Player.getY()].loot.size())
    map[Player.getX()][Player.getY()].loot.get(key-'a').equip(Player, map[Player.getX()][Player.getY()], key-'a');
  else if (key == 'y' && map[Player.getX()][Player.getY()].getType() == '>')
    generateMap();
  redraw();
}
void inMenu() {
  todisplay.clear();
  todisplay.add(Player.getName());
  todisplay.add("Level "+Player.getSkill()+ "     Exp "+Player.getExp());
  todisplay.add("HP: "+Player.getHP());
  todisplay.add("Speed: "+Player.getSpeed());
  todisplay.add(Player.weapon.getName() + " " + Player.weapon.getMin() + "-" + Player.weapon.getMax());
  todisplay.add(Player.armor.getName() + " " + Player.armor.getMin() + "-" + Player.armor.getMax());
  todisplay.add("On the floor:");
  int x = 0;
  for (Item i : map[Player.getX ()][Player.getY()].loot) {
    todisplay.add("" + char('a' + x) + ") " + i.getName() + " " + i.getMin() + "-" + i.getMax());
  }
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
  if (Monsters.size() == 1 && Monsters.get(0).isDead()) {
    background(0);
    text("You have defeated the Baron and gotten the legendary Treasure! Press any key to play again.", 256, 392);
    if (keyPressed) {
      Player.reset();
      level = 0;
      generateMap();
    }
  } else if (Player.getHP() > 0) {
    Player.display();
    fill(255, 255, 255);
    rect(0, 735, 800, 3);
    text(text, 0, 736, 800, 56);
    rect(800, 0, 3, 800);
    rect(800, 600, 1200, 3);
    inMenu();
    playerMenu(800, 0);
  } else {
    background(0);
    text("You have died. Press any key to restart.", 480, 392);
    if (keyPressed) {
      Player.reset();
      level = 0;
      generateMap();
    }
  }
}

