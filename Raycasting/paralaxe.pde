/**
 * raycasting 3d rendering 
 */

/**
 * 0 -> black texture
 * 1 -> wall color texture
 */
/*int[] texture = 
 {0,1,1,
 1,0,1,
 1,1,0};*/

/*int[] texture = 
 {1,1,1,
 1,1,1,
 1,1,1};*/

int[] texture = 
    {0, 1, 0, 1, 
    1, 0, 1, 0, 
    0, 1, 0, 1, 
    1, 0, 1, 0};

int textureSize = int(sqrt(texture.length));

int renderHeight = width*50;

void paralaxe() {
    //if we display the top view of the map
    if (displayLeftPart) {
        translate(width, 0);
    }
    
    color co;
    float colorScale = rayLength*1.2/255;

    //set the wide of a ray on the screen
    float w = (width/rays.size());
    //rectMode(CENTER);
    //for each ray
    for (int i = 0; i < rays.size(); i++) {
        float rectLength = float(split(rays.get(i), ";")[0]);
        //println(int(float(split(split(rays.get(i), ";")[1],",")[1])));
        color wallColor = color(int(float(split(split(rays.get(i), ";")[1], ",")[0])), int(float(split(split(rays.get(i), ";")[1], ",")[1])), int(float(split(split(rays.get(i), ";")[1], ",")[2])));
        //the further the wall is, the less visible it will be
        co = color(red(wallColor)-rectLength/colorScale, green(wallColor)-rectLength/colorScale, blue(wallColor)-rectLength/colorScale);


        //the further the wall is, the smallest it will be on the screen
        rectMode(CORNER);
        for (int j = 0; j < textureSize; j++) {

            int touchPart = int(split(rays.get(i), ";")[2]);
            //touchPart = 1;
            //println(touchPart);
            //stroke(co*texture[j*textureSize + touchPart]);
            noStroke();
            fill(co*texture[j*textureSize + touchPart]);

            rect(i*w, (height/2-renderHeight/rectLength/2) + renderHeight/rectLength/textureSize*j, w, renderHeight/rectLength/textureSize);
        }

        //stroke(co);
        //fill(co);
        //rect(i*w, height/2, w, 80000/rectLength);

        rectMode(CORNER);
        fill(groundColor);
        stroke(groundColor);
        rect(i*w, height, w, -(height/2-renderHeight/rectLength/2));
        fill(skyColor);
        stroke(skyColor);
        rect(i*w, 0, w, (height/2-renderHeight/rectLength/2));
    }
    rectMode(CORNER);
    if (displayLeftPart) {
        translate(-width, 0);
    }

}
