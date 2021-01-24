Player p;
int speed = 5;
float angleSpeed = 0.1;
int NUMBER_OF_RAYS = 200;
int rayLength = 800;
float visionAngle = (float) Math.PI/3;
int width = 800;
int height = 800;
int widthMap = 10;
color wallColorCollision;
color skyColor = color(0,100,200);
color groundColor = color(50,50,50);
ArrayList<Wall> walls = new ArrayList<Wall>();
public StringList rays = new StringList();

/**
 * 0 -> no wall
 * 1 -> white wall
 * 2 -> red wall
 * 3 -> green wall
 * 4 -> blue wall
 */
int[] map = 
    {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 
    1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 
    1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 
    1, 0, 1, 0, 0, 0, 0, 0, 0, 1, 
    1, 0, 1, 0, 0, 4, 0, 0, 0, 1, 
    1, 0, 0, 0, 0, 3, 0, 0, 0, 1, 
    1, 0, 0, 0, 0, 2, 0, 0, 0, 1, 
    1, 0, 0, 0, 0, 1, 0, 0, 0, 1, 
    1, 4, 0, 0, 0, 1, 0, 0, 0, 4, 
    1, 1, 1, 1, 1, 1, 1, 1, 1, 1};


void setup() {
    size(1600, 800);
    background(0);
    noStroke();

    p = new Player(width/2, height/4, 0);
    createMap(map);
}

void draw() {
    background(0);
    //p.angle = atan2(mouseY - p.y, mouseX - p.x);
    p.see();
    p.show();
    p.move();
    showWalls();
    paralaxe();
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
    int scale = (int) width/widthMap;
    walls.add(new Wall(x*scale, y*scale, x*scale+scale, y*scale, c));
    walls.add(new Wall(x*scale+scale, y*scale, x*scale+scale, y*scale+scale, c));
    walls.add(new Wall(x*scale+scale, y*scale+scale, x*scale, y*scale+scale, c));
    walls.add(new Wall(x*scale, y*scale+scale, x*scale, y*scale, c));
}
