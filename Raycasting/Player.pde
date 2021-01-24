public class Player {
    float x;
    float y;
    float angle;
    float xspeed;
    float yspeed;
    float angleSpeed;
    int NUMBER_OF_RAYS = 100;

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
        String temp;
        stroke(0, 255, 0);

        for (int i = 0; i < NUMBER_OF_RAYS; i++) {

            //get the length of the ray

            //length = lengthCollision(see_angle,walls);
            //wallColorCollision = colorCollision(see_angle, walls);
            temp = lengthAndColorCollision(see_angle, walls);
            length = float(split(temp, ";")[0]);
            wallColorCollision = color(int(split(split(temp, ";")[1], ",")[0]), int(split(split(temp, ";")[1], ",")[1]), int(split(split(temp, ";")[1], ",")[2]));
            line(this.x, this.y, this.x+length*cos(see_angle), this.y+length*sin(see_angle));
            rays.append(str(length) + ";" + red(wallColorCollision) + "," + green(wallColorCollision) + "," + blue(wallColorCollision));

            //set angle of the next ray
            see_angle += (visionAngle)/NUMBER_OF_RAYS;
        }
        noStroke();
    }
}
