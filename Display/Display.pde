PVector loc;
char[][] map;

void setup(){
 size(800,800); 
 loc = new PVector(400,400);
 map = new char[50][50];
 for(int a = 0;a < map.length;a++){
   for(int b = 0;b < map[a].length;b++){
     if(random(100)<45)
       map[a][b] = '#';
     else
       map[a][b] = '.';
   }
 } 
}

void draw(){
 background(0);
 textSize(16);
 for(int a = 0;a < map.length;a++){
   for(int b = 0;b < map[a].length;b++){
     if(a*16 != loc.x || b*16 != loc.y){
       text(map[a][b],a*16,b*16);
     }
   }
 }
 text("@",loc.x,loc.y);
 if(keyPressed){
   switch(key){
     case '1':
       loc.add(-16,16,0);
       break;
     case '2':
       loc.add(0,16,0);
       break;
     case '3':
       loc.add(16,16,0);
       break;
     case '4':
       loc.add(-16,0,0);
       break;
     case '5':
       break;
     case '6':
       loc.add(16,0,0);
       break;
     case '7':
       loc.add(-16,-16,0);
       break;
     case '8':
       loc.add(0,-16,0);
       break;
     case '9':
       loc.add(16,-16,0);
       break;
   }
 }
}
