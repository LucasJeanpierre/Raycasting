public class Player {
    private float x;
    private float y;
    private float angle;
    private float xspeed;
    private float yspeed;
    public int NUMBER_OF_RAYS = 50;

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
        p.x += xspeed;
        p.y += yspeed;
    }

    /**
     * see method draw the rays from the player
    */
    public void see() {

        //start from the first half of the visionAngle
        float see_angle = this.angle-visionAngle/2;
        float length;
        stroke(0,255,0);

        for (int i = 0; i < this.NUMBER_OF_RAYS; i++) {

            //get the length of the ray
            length = lengthCollision(see_angle,walls);
            line(this.x,this.y,this.x+length*cos(see_angle),this.y+length*sin(see_angle));

            //set angle of the next ray
            see_angle += (visionAngle)/this.NUMBER_OF_RAYS;
        }
        noStroke();
    }
}
