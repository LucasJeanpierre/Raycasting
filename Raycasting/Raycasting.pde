Player p;
int speed = 5;
int rayLength = 500;
float visionAngle = (float) Math.PI/1.2;
ArrayList<Wall> walls = new ArrayList<Wall>();

void setup() {
    size(800, 800);
    background(0);
    noStroke();

    p = new Player(width/2, height/4, 0);

    walls.add(new Wall(0,0,width,height));
    walls.add(new Wall(width,0,0,height));
}

void draw() {
    background(0);
    p.angle = atan2(mouseY - p.y, mouseX - p.x);
    p.see();
    p.show();
    p.move();
    showWalls();
}

//player movements
void setMovement(int k, boolean b) {
    switch (k) {
    case 'z':
        p.yspeed = -speed * int(b);
        break;
    case 'q':
        p.xspeed = -speed * int(b);
        break;
    case 's':
        p.yspeed = speed * int(b);
        break;
    case 'd':
        p.xspeed = speed * int(b);
        break;
    }
}

void keyPressed() {
    setMovement(key, true);
}

void keyReleased() {
    setMovement(key, false);
}
