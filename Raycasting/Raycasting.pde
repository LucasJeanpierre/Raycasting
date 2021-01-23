Player p;
int speed = 5;
float angleSpeed = 0.1;
int rayLength = 1000;
float visionAngle = (float) Math.PI/2;
int width = 800;
int height = 800;
ArrayList<Wall> walls = new ArrayList<Wall>();
public IntList rays = new IntList();
int[] map = 
    {1, 1, 1, 1, 1, 
    1, 0, 1, 0, 1, 
    1, 0, 1, 0, 1, 
    1, 0, 0, 0, 1, 
    1, 1, 1, 1, 1};

/*int[] map = 
    {0, 0, 0, 0, 0, 
    0, 0, 1, 0, 0, 
    0, 0, 1, 0, 0, 
    0, 0, 1, 0, 0, 
    0, 0, 0, 0, 0};*/

void setup() {
    size(1600, 800);
    background(0);
    noStroke();

    p = new Player(width/4, height/4, 0);
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
    for (int i = 0; i < 25; i++) {
        if (map[i] == 1) {
            x = i%5; 
            y = (int) i/5;
            createWall(x, y);
        }
    }
}

public void createWall(int x, int y) {
    int scale = (int) width/5;

    walls.add(new Wall(x*scale, y*scale, x*scale+scale, y*scale));
    walls.add(new Wall(x*scale+scale, y*scale, x*scale+scale, y*scale+scale));
    walls.add(new Wall(x*scale+scale, y*scale+scale, x*scale, y*scale+scale));
    walls.add(new Wall(x*scale, y*scale+scale, x*scale, y*scale));
}
