int unit = 25;
int count;
float xoff = 0.001;
BadOnes[] enemies;
GoodOne PlayerShape1;

void setup() {
  size(640, 360);
  noStroke();
  int wideCount = width / unit;
  int highCount = height / unit;

  count = wideCount * highCount;

  enemies = new BadOnes[count];

  PlayerShape1 = new GoodOne(20, 20, 20);

  int index = 0;
  for (int y = 0; y < highCount; y++) {
    for (int x = 0; x < wideCount; x++) {
      enemies[index++] = new BadOnes(x*unit, y*unit, unit/2, unit/2, random(0.05, 0.8), random(0.05, 0.8), unit);
    }
  }
}

void draw() {
  background(255);
  for (int i = 0; i < enemies.length; i++) {
    if(enemies[i] != null){
      enemies[i].update();
      enemies[i].display();
      PlayerShape1.display();
      if (enemies[i].xoff > (PlayerShape1.x - (PlayerShape1.l/2))&&
        enemies[i].xoff < (PlayerShape1.x + (PlayerShape1.l/2))&&
        enemies[i].yoff > (PlayerShape1.y - (PlayerShape1.l/2))&&
        enemies[i].yoff < (PlayerShape1.y + (PlayerShape1.l/2))) {
          //killed one
          enemies[i] = null;  
      }
    }
  }
}

void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      PlayerShape1.y = PlayerShape1.y - 10;
    }  
    if (keyCode == DOWN) {
      PlayerShape1.y = PlayerShape1.y + 10;
    }  
    if (keyCode == RIGHT) {
      PlayerShape1.x = PlayerShape1.x + 10;
    } 
    if (keyCode == LEFT) {
      PlayerShape1.x = PlayerShape1.x - 10;
    }
  }
}



class GoodOne {
  int x;
  int y;
  int l;

  GoodOne (int xTemp, int yTemp, int lTemp) {
    x = xTemp;
    y = yTemp;
    l = lTemp;
  }


  void display() {
    stroke(0);
    fill(255);
    rect(x, y, l, l);
  }

  void setX(int xpos) {
    x = xpos;
  }

  void setY(int ypos) {
    y = ypos;
  }
}

class BadOnes {
  int xoff;
  int yoff;
  float x, y;
  int unit;
  int xdir = 1;
  int ydir = 1;
  float xspeed; 
  float yspeed;

  BadOnes(int xoffTemp, int yoffTemp, int xTemp, int yTemp, float xspeedTemp, float yspeedTemp, int tempUnit) {
    xoff = xoffTemp;
    yoff = yoffTemp;
    x = xTemp;
    y = yTemp;
    xspeed = xspeedTemp;
    yspeed = yspeedTemp;
    unit = tempUnit;
  }

  // Custom method for updating the variables
  void update() {
    x = x + (xspeed * xdir);
    if (x >= unit || x <= 0) {
      xdir = xdir * -1;
      x = x + (1 * xdir);
      y = y + (1 * ydir);
    }
    y = y + (yspeed * ydir);
    if (y >= unit || y <= 0) {
      ydir = ydir * -1;
      y = y + (1 * ydir);
    }
  }

  // Custom method for drawing the object
  void display() {
    fill(0);
    ellipse(xoff + x, yoff + y, 6, 6);
  }
}