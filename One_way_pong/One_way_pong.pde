// Variables for the first circle
float circleX;
float circleY;
float speedX;
float speedY;
float sizeX = 30;
float sizeY = 30;

// Variables for the player/ the rect
float rectSize = 300;

// Variables for the second circle
float secondCircleX;
float secondCircleY;
float newXspeed;
float newYspeed;

// Variables for points
int pointsWin = 10;
float decrease = rectSize/pointsWin; /* later it will be used to make the rect smaller every time the circles bounces on it, 
so when the points has counted down to zero, the rect will be gone */

//Start values for the first circle and the second circle, will only repeat once because they are in setup()
void setup() {
  size(800,500);
  secondCircleX = width/3;
  secondCircleY = height/3;
  circleX = width/2;
  circleY = height/2;
  speedX = 4; // speed for circle
  speedY = 4; // speed for circle
  newXspeed= 3; // speed for second circle
  newYspeed= 3; // speed for second circle
}

void draw() {
  frameRate(80);
  background(0);
  ellipse(circleX, circleY, sizeX, sizeY);
  fill(255,100,200);
  rect(0, 0, 20, height); 
  rect(width-20, mouseY-rectSize/2, 10, rectSize); //mouseY-rectsize/2 is set so mouseY will follow the middle of the rect
  circleX += speedX;
  circleY += speedY;
  
/* if the circleX is bigger than 870 and circleX is smaller than 880 and circleY 
is bigger than the mouseY location minus 150 and circleY is smaller than mouseY location plus 150 */
  
  if (circleX > width-30 && circleX < width-20 && circleY > mouseY-rectSize/2 && circleY < mouseY+rectSize/2){
    speedX = speedX * -1;
    rectSize = rectSize-decrease;
    pointsWin -= 1;
  }   
  
// if the size of the rect goes under 200 in height, it will draw a new circle (second circle) 
  if (rectSize < 200) {
    secondCircleX += newXspeed;
    secondCircleY += newYspeed;
    ellipse(secondCircleX, secondCircleY, 40, 40);
    if (secondCircleX < 40) { 
      newXspeed *=1;
      newYspeed *=1;
      secondCircleX += newXspeed;
    }
// if the second circle goes past the top OR the bottom on the screen, the circle will bounce back with the same speed
    if (secondCircleY > height || secondCircleY < height-500 ) { 
      newYspeed *=-1;
    }
// if the second circle intersect with the rect, the circle will bounce back with the same speed and count down one point  
    if(secondCircleX > width-30 && secondCircleY < width-20 && secondCircleY > mouseY-rectSize/2 && secondCircleY < mouseY+rectSize/2) {
      newXspeed = newXspeed * -1;
      rectSize = rectSize-decrease; 
      pointsWin -= 1;
    }   
// if the second circle goes past the X location, the circle will bounce back with a higher speed
    if (secondCircleX < 40) {
      newXspeed *= -1.1;
      newYspeed *= 1.1;
      secondCircleX += newXspeed;
    }
  }

// if the circle goes past the X location, the circle will bounse back with a higher speed
  if (circleX < 40) {
    speedX *= -1.1;
    speedY *= 1.1;
    circleX += speedX;
  }

// if the circle goes past the top or buttom of the screen, the circle will bounce back with the same speed
  if ( circleY > height || circleY < 0 ) {
    speedY *= -1;
  }
  
// Win, loose and points
  if (circleX > width || secondCircleX > width) {
    textSize(50);
    text("You loose...", width/3, height/2);
    noLoop();
  }  
  
  if (rectSize == 0) { 
    textSize(50);
    text("YOU WIN", width/3, height/2);
    noLoop();
  }
  
  if(pointsWin > 0 && !(circleX > width || secondCircleX > width)) {
    textSize(40);
    fill(0, 408, 612);
    text(pointsWin, width/2, height/2);
  }
}
