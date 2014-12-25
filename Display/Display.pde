int x,y;

void setup(){
 size(400,400); 
 x = 200;
 y = 200;
}

void draw(){
 background(0);
 text("@",x,y);
 if(keyPressed){
   switch(key){
     case '1':
       x--;
       y++;
       break;
     case '2':
       y++;
       break;
     case '3':
       x++;
       y++;
       break;
     case '4':
       x--;
       break;
     case '5':
       break;
     case '6':
       x++;
       break;
     case '7':
       x--;
       y--;
       break;
     case '8':
       y--;
       break;
     case '9':
       x++;
       y--;
       break;
   }
 }
}
