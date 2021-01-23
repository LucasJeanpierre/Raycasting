
/**
 * return the length between the player and the closest wall
 *   
*/
public float lengthCollision(float angle, ArrayList<Wall> w) {
    float length = rayLength*2;

    //for each wall
    for (int i = 0; i < w.size(); i++) {

        //if the ray intersect a wall
        if (isIntersect(p.x, p.y, p.x+rayLength*cos(angle), p.y+rayLength*sin(angle), w.get(i).x1, w.get(i).y1, w.get(i).x2, w.get(i).y2)) {

            //get the intersections points
            float intersectionY = intersectionY(p.x, p.y, p.x+rayLength*cos(angle), p.y+rayLength*sin(angle), w.get(i).x1, w.get(i).y1, w.get(i).x2, w.get(i).y2);
            float intersectionX = intersectionX(p.x, p.y, p.x+rayLength*cos(angle), p.y+rayLength*sin(angle), w.get(i).x1, w.get(i).y1, w.get(i).x2, w.get(i).y2);

            //get the distance
            float distance = dist(p.x, p.y, intersectionX, intersectionY);

            //if this wall is closer
            if (distance < length) {
                length = distance;
            } 
        } else { //if the ray don't intersect a wall

            //if this wall is closer
            if (rayLength < length) {
                 length = rayLength;
            }
        }
    }
    return length;
}

/**
 * return true if the lines intersect
*/
public boolean isIntersect(float px1, float py1, float px2, float py2, float px3, float py3, float px4, float py4) {
    float ua = 0.0;
    float ub = 0.0;
    float ud = (py4 - py3) * (px2 - px1) - (px4 - px3) * (py2 - py1);
    boolean isIntersect;


    if (ud != 0) {
        ua = ((px4 - px3) * (py1 - py3) - (py4 - py3) * (px1 - px3)) / ud;
        ub = ((px2 - px1) * (py1 - py3) - (py2 - py1) * (px1 - px3)) / ud;
        if (ua < 0.0 || ua > 1.0 || ub < 0.0 || ub > 1.0) ua = 0.0;
    }

    if (ua == 0) {
        isIntersect = false;
    } else {
        isIntersect = true;
    }
    return isIntersect;
}

/**
 * return the x position of the intersection point
*/
public float intersectionX(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float intersectionX = x1 + (uA * (x2-x1));
    return intersectionX;
}

/**
 * return the y position of the intersection point
*/
public float intersectionY(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4) {
    float uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1));
    float intersectionY = y1 + (uA * (y2-y1));
    return intersectionY;
}
