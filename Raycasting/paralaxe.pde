/**
 * raycasting 3d rendering 
 */
void paralaxe() {
    translate(width, 0);
    color co;
    float colorScale = rayLength/255;

    //set the wide of a ray on the screen
    int w = (int) (width/rays.size());
    //rectMode(CENTER);
    //for each ray
    for (int i = 0; i < rays.size(); i++) {
        float rectLength = float(split(rays.get(i), ";")[0]);
        //println(int(float(split(split(rays.get(i), ";")[1],",")[1])));
        color wallColor = color(int(float(split(split(rays.get(i), ";")[1], ",")[0])), int(float(split(split(rays.get(i), ";")[1], ",")[1])), int(float(split(split(rays.get(i), ";")[1], ",")[2])));
        //the further the wall is, the less visible it will be
        co = color(red(wallColor)-rectLength/colorScale, green(wallColor)-rectLength/colorScale, blue(wallColor)-rectLength/colorScale);
        

        //the further the wall is, the smallest it will be on the screen
        rectMode(CENTER);
        fill(co);
        rect(i*w, height/2, w, 80000/rectLength);

        rectMode(CORNER);
        fill(groundColor);
        rect(i*w, height, w, -(height/2-80000/rectLength/2));
        fill(skyColor);
        rect(i*w, 0, w, (height/2-80000/rectLength/2));
    }
    rectMode(CORNER);

    translate(-width, 0);
}
