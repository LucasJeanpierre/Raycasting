/**
 * raycasting 3d rendering 
 */
void paralaxe() {
    translate(width, 0);

    //set the wide of a ray on the screen
    int w = (int) (width/rays.size());
    rectMode(CENTER);
    //for each ray
    for (int i = 0; i < rays.size(); i++) {

        //the further the wall is, the less visible it will be
        fill(255-rays.get(i)/2);

        //the further the wall is, the smallest it will be on the screen
        rect(i*w, height/2, w, 80000/rays.get(i));
    }
    rectMode(CORNER);

    translate(-width, 0);
}
