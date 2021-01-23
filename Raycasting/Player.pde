public class Player {
    float x;
    float y;
    float angle;
    float xspeed;
    float yspeed;
    float angleSpeed;
    int NUMBER_OF_RAYS = 200;

    public Player(float x, float y, float angle) {
        this.x = x;
        this.y = y;
        this.angle = angle;
    }

    public void show() {
        fill(255);
        ellipse(this.x, this.y, 50, 50);
        fill(255, 0, 0);
        ellipse(this.x+15*cos(this.angle), this.y+15*sin(this.angle), 15, 15);
    }

    public void move() {
        this.x += this.xspeed;
        this.y += this.yspeed;
        this.angle += this.angleSpeed;
    }

    /**
     * see method draw the rays from the player
    */
    public void see() {
        rays.clear();
        //start from the first half of the visionAngle
        float see_angle = this.angle-visionAngle/2;
        float length;
        stroke(0,255,0);

        for (int i = 0; i < this.NUMBER_OF_RAYS; i++) {

            //get the length of the ray
            length = lengthCollision(see_angle,walls);
            line(this.x,this.y,this.x+length*cos(see_angle),this.y+length*sin(see_angle));
            rays.append((int) length);

            //set angle of the next ray
            see_angle += (visionAngle)/this.NUMBER_OF_RAYS;
        }
        noStroke();
    }
}
