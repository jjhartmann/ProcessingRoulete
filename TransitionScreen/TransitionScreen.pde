import java.awt.*;

ArrayList<PVector> pathPoints = new ArrayList<PVector>();
PImage previousScreen;
PGraphics imageBuffer;

void setup() {
  size(500, 500); 
  //fullScreen();
  background(0);
  
  // Get screen shot
  previousScreen = GetScreenshot();
  background(previousScreen.get(0,0, width, height));
  
  // Create PGraphics Buffer
  imageBuffer = createGraphics(width, height, JAVA2D);
  
  imageBuffer.beginDraw();
  imageBuffer.background(0);
  imageBuffer.endDraw();
} 

void draw() {
  // Display Background
  image(previousScreen, 0, 0)
  
  //create the path
  pathPoints = circlePoints();
  
  for(int j=0;j < 6;j++){
    pathPoints = complexifyPath(pathPoints);
  }

  //draw the path
  imageBuffer.beginDraw();
  imageBuffer.stroke(255, 15);
  for(int i=0;i<pathPoints.size() -1;i++){
    PVector v1 = pathPoints.get(i);
    PVector v2 = pathPoints.get(i + 1);
    imageBuffer.line(v1.x,v1.y,v2.x,v2.y);
  }
  imageBuffer.endDraw();
  
  // Display Image
  tint(255, 127);
  image(imageBuffer, 0, 0);
}

 ArrayList<PVector> complexifyPath(ArrayList<PVector> pathPoints){
  //create a new path array from the old one by adding new points inbetween the old points
  ArrayList<PVector> newPath = new ArrayList<PVector>();
  
  for(int i=0;i<pathPoints.size() -1;i++){
    PVector v1 = pathPoints.get(i);
    PVector v2 = pathPoints.get(i + 1);
    PVector midPoint = v1.add(v2).mult(0.5f);//p5.Vector.add(v1, v2).mult(0.5);
    float distance =  v1.dist(v2);
    
    //the new point is halfway between the old points, with some gaussian variation
    float standardDeviation = 0.125*distance;
    PVector v = new PVector(midPoint.x + randomGaussian() * standardDeviation, midPoint.y + randomGaussian() * standardDeviation);
    newPath.add(v1);//append(newPath,v1);
    newPath.add(v);//append(newPath,v);
  }
  
  //don't forget the last point!
  newPath.add(pathPoints.get(pathPoints.size()  - 1));//append(newPath,pathPoints[pathPoints.length-1]);
  return newPath;  
}

ArrayList<PVector> circlePoints() {
  //two points somewhere on a circle
  float r = width/2.1;
  //var theta1 = random(TWO_PI);
  float theta1 = randomGaussian();
  float theta2 = theta1 + randomGaussian();
  
  ArrayList<PVector> points = new ArrayList<PVector>();
  points.add (new PVector(width/2 + r*cos(theta1),width/2 + r*sin(theta1)));
  points.add (new PVector(width/2 + r*cos(theta2),width/2 + r*sin(theta2)));
  return points;
}


PImage GetScreenshot() {
  PImage screenshot = new PImage();
  try {
    screenshot = new PImage(new Robot().createScreenCapture(new Rectangle(0, 0, displayWidth, displayHeight)));
  } catch (AWTException e) { }
  return screenshot;
}