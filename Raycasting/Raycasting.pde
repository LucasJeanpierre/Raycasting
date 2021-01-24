int width = 800;


Player p;
int speed = width/160;
float angleSpeed = 0.1;
int NUMBER_OF_RAYS = 200;
int rayLength = width;
float visionAngle = (float) Math.PI/3;
int height = width;

color wallColorCollision;
color skyColor = color(0, 100, 200);
color groundColor = color(50, 50, 50);
ArrayList<Wall> walls = new ArrayList<Wall>();
public StringList rays = new StringList();

boolean displayLeftPart = true;
boolean displayRightPart = true;

/**
 * 0 -> no wall
 * 1 -> white wall
 * 2 -> red wall
 * 3 -> green wall
 * 4 -> blue wall
 */

//10*10 map
/*int[] map = 
 {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 
 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 
 1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 
 1, 0, 1, 0, 0, 4, 0, 0, 0, 1, 
 1, 0, 0, 0, 0, 3, 0, 0, 0, 1, 
 1, 0, 0, 0, 0, 2, 0, 0, 0, 1, 
 1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 
 1, 4, 0, 0, 0, 1, 0, 0, 0, 4, 
 1, 1, 1, 1, 1, 1, 1, 1, 1, 1};*/

//16*16 map
int[] map = 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
    1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 
    1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 0, 0, 0, 0, 1, 
    1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 3, 3, 0, 0, 1, 
    1, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0, 3, 0, 0, 0, 1, 
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 
    1, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 0, 0, 0, 0, 1, 
    1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 
    1, 0, 0, 0, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 
    1, 4, 4, 4, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 
    1, 0, 0, 4, 0, 0, 0, 0, 1, 0, 1, 0, 0, 0, 0, 1, 
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 
    1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 1, 
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, };

int widthMap = int(sqrt(map.length));
int scale = (int) width/widthMap;

void settings() {
    if (displayLeftPart && displayRightPart) {
        size(width*2, width);
    } else {
        size(width, width);
    }
    
}

void setup() {

    background(0);
    noStroke();

    p = new Player(width/8, height/8, 0);
    createMap(map);
}

void draw() {
    background(0);
    //p.angle = atan2(mouseY - p.y, mouseX - p.x);
    p.see();
    if (displayLeftPart) {
        p.show();
        showWalls();
    }
    if (displayRightPart) {
        paralaxe();
    }
    p.move();

}

//player movements
void setMovement(int k, boolean b) {
    switch (k) {
    case 'z':
        //p.yspeed = -speed * int(b);
        p.yspeed = speed * int(b) * sin(p.angle);
        p.xspeed = speed * int(b) * cos(p.angle);
        break;
    case 'q':
        //p.xspeed = -speed * int(b);
        p.yspeed = speed * int(b) * sin((float) (p.angle-Math.PI/2));
        p.xspeed = speed * int(b) * cos((float) (p.angle-Math.PI/2));
        break;
    case 's':
        //p.yspeed = speed * int(b);
        p.yspeed = -speed * int(b) * sin(p.angle);
        p.xspeed = -speed * int(b) * cos(p.angle);
        break;
    case 'd':
        //p.xspeed = speed * int(b);
        p.yspeed = speed * int(b) * sin((float) (p.angle+Math.PI/2));
        p.xspeed = speed * int(b) * cos((float) (p.angle+Math.PI/2));
        break;
    case 'a':
        p.angleSpeed = -angleSpeed * int(b);
        break;
    case 'e':
        p.angleSpeed = angleSpeed * int(b);
    }
}

void keyPressed() {
    setMovement(key, true);
}

void keyReleased() {
    setMovement(key, false);
}


public void createMap(int[] map) {
    int x;
    int y;
    for (int i = 0; i < widthMap*widthMap; i++) {
        if (map[i] != 0) {
            x = i%widthMap; 
            y = (int) i/widthMap;
            color wColor = color(255, 255, 255);
            if (map[i] == 1) {
                wColor = color(255);
            } else if (map[i] == 2) {
                wColor = color(255, 0, 0);
            } else if (map[i] == 3) {
                wColor = color(0, 255, 0);
            } else if (map[i] == 4) {
                wColor = color(0, 0, 255);
            }

            createWall(x, y, wColor);
        }
    }
}

public void createWall(int x, int y, color c) {
    walls.add(new Wall(x*scale, y*scale, x*scale+scale, y*scale, c));
    walls.add(new Wall(x*scale+scale, y*scale, x*scale+scale, y*scale+scale, c));
    walls.add(new Wall(x*scale+scale, y*scale+scale, x*scale, y*scale+scale, c));
    walls.add(new Wall(x*scale, y*scale+scale, x*scale, y*scale, c));
}
