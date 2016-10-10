// light speed sim
float lightx = 100;

float sizscale = 1;
float planetscale = .33;

int sunx = 0;

int stateStart = 0;

int delta = 1;
int deltatime = 1;

int startingTime;
int timeSoFar;
boolean clockRunning;

int rectTime;
int rectSoFar;
boolean rectRunning;

float zoom = 2;

float translateX = 0;
float translateY = -250;

float scrollx = 60;

float lastTime = 0;
float x = 0;
int rmillis = 1;

PImage starbackground;

int sunsize = 60;

float[] planetDistances = {35.98, 67.23, 92.897, 141.6, 483.6, 888.2, 1786.4, 2798.8, 3666.2};

float mercuryX = (35.98 * planetscale) + sunsize/2;
float venusX = (67.23 * planetscale) + sunsize/2;
float earthX = (92.897 * planetscale) + sunsize/2;
float marsX = (141.6 * planetscale) + sunsize/2;
float jupiterX = (483.6 * planetscale) + sunsize/2;
float saturnX = (888.2 * planetscale) + sunsize/2;
float uranusX = (1786.4 * planetscale) + sunsize/2;
float neptuneX = (2798.8 * planetscale) + sunsize/2;
float plutoX = (3666.2 * planetscale) + sunsize/2;

void setup () {
  size (1300, 500);

  PFont font= loadFont("AnonymousPro-Bold-30.vlw");
  textFont(font);

  starbackground = loadImage("SolarSystemBG.jpg");
  
  shipSetup();
}

void draw () {
  background(70);
  image(starbackground, 0, 0, width, height);
  
  buttons();
  
  int y = height/2;

  int milliseconds = (millis() - startingTime) * deltatime;
  int seconds = milliseconds / 1000;
  int minutes = seconds / 60;
  int hours = minutes / 60;
  int days = hours / 24;

  if (clockRunning == true) {
    milliseconds -= (seconds * 1000);
    seconds -= minutes * 60;
    minutes -= hours * 60;
    hours -= days * 24;

    String message =
      nf(hours, 2, -1) + ":" +
      nf(minutes, 2, -1) + ":" +
      nf(seconds, 2, -1);

    fill(255);
    textSize(20);
    textAlign(CORNER);
    text(message, 20, 35);
  } else {
    seconds -= minutes * 60;
    minutes -= hours * 60;
    hours -= days * 24;

    String message =
      nf(hours, 2, -1) + ":" +
      nf(minutes, 2, -1) + ":" +
      nf(seconds, 2, -1);

    fill(255);
    textSize(20);
    textAlign(CORNER);
    text(message, 20, 35);
  }

  if (rectRunning == true) {
    rmillis = (millis() - rectTime);
  }

  if (rectRunning == false) {
    rmillis = rectSoFar;
  }

  //decrease planetscale button
  rectMode(CORNER);
  fill(150);
  rect(width-75, 20, 20, 20, 5);
  fill(0);
  stroke(20);
  line(width-75+5, 30, width-75+15, 30);

  if (mouseX > width-75 && mouseX < width-75+20 && mouseY > 20 && mouseY < 40 && mousePressed) {
    zoom -= .015;
    translateY = translateY + 3.68;
  }

  //increase planetscale button
  noStroke();
  fill(150);
  rect(width-40, 20, 20, 20, 5);
  fill(0);
  stroke(20);
  line(width-40+5, 30, width-40+15, 30);
  line(width-40+10, 25, width-40+10, 35);

  if (mouseX > width-40 && mouseX < width-40+20 && mouseY > 20 && mouseY < 40 && mousePressed) {
    zoom += .015;
    translateY = translateY - 3.68;

    /*if (translateY <= -1545.6058) {
      translateY = -1545.6058;
      zoom -= .015;
    }*/
  }

  /*********************************/
  ////Lightspeed is 186,282 mi/sec
  // * Every second, .186282 times the planetscale (which is relative to the distance of the planets)
  // is added to the rectangle's width *//
  if ( rmillis - lastTime >= 1000/10) {
    lastTime = rmillis;
    x = x+((.186282)/10);
  }

  lightx = (x*planetscale) * delta;

  //This displays the distance so far by using the pixel length of the light and dividing
  //it by the planetscale and multiplying it to the accurate power 
  fill(255);
  textAlign(CORNER);
  text("Distance: "+nfc((lightx*pow(10, 6))/planetscale, 2)+" miles", width/2 + 200, 40);

  //compress/stretch solar system 
  noStroke();
  fill(150, 100);
  //arcMode(CENTER);
  arc(width/2+1, height-100, 40, 40, -HALF_PI, HALF_PI);
  arc(width/2-1, height-100, 40, 40, HALF_PI, 3*(HALF_PI), PIE);

  if (mouseX > width/2 && mouseX < width/2+40 && mouseY > height-100 && mouseY < height-100+40 && mousePressed) {
    planetscale = planetscale + .01;
  }
  if (mouseX < width/2 && mouseX > width/2-40 && mouseY > height-100 && mouseY < height-100+40 && mousePressed) {
    planetscale = planetscale - .01;
  }
  
  for(int i = 0; i < planetDistances.length; i++) {
    planetDistances[i] = scaler(planetDistances[i]);
  }
  
  mercuryX = (35.98 * planetscale) + sunsize/2;
  venusX = (67.23 * planetscale) + sunsize/2;
  earthX = (92.897 * planetscale) + sunsize/2;
  marsX = (141.6 * planetscale) + sunsize/2;
  jupiterX = (483.6 * planetscale) + sunsize/2;
  saturnX = (888.2 * planetscale) + sunsize/2;
  uranusX = (1786.4 * planetscale) + sunsize/2;
  neptuneX = (2798.8 * planetscale) + sunsize/2;
  plutoX = (3666.2 * planetscale) + sunsize/2;

  //speeed up time
  if (mouseX > width/2+30 && mouseX < width/2+50 && mouseY > 20 && mouseY < 40 && mousePressed) {    
    delta = delta + 1;      
    deltatime = deltatime + 1;
  }

  //speed up time even more
  if (mouseX > width/2+55 && mouseX < width/2+73 && mouseY > 22 && mouseY < 38 && mousePressed) {
    delta = delta + 2;
    deltatime = deltatime + 2;
  }

  //slow down time
  if (mouseX > width/2 - 50 && mouseX < width/2 - 30 && mouseY > 20 && mouseY < 40 && mousePressed) {
    delta = delta - 1;
    deltatime = deltatime - 1;

    if (delta <= 1) {
      delta = 1;
    }
    if (deltatime <= 1) {
      deltatime = 1;
    }
  }

  //slow down time even more
  if (mouseX > width/2 - 73 && mouseX < width/2 - 55 && mouseY > 22 && mouseY < 38 && mousePressed) {
    delta = delta - 2;
    deltatime = deltatime - 2;

    if (delta <= 1) {
      delta = 1;
    }
    if (deltatime <= 1) {
      deltatime = 1;
    }
  }

  //shows how fast you're going
  fill(255);
  text("x"+nf(delta, 1, -1), width/2 - 180, 40); 

  //play/pause/continue
  if (mouseX > width/2-20 && mouseX < width/2+20 && mouseY > 20 && mouseY < 40 && mousePressed) {
    stateStart++;
    delay(200);
  }

  if (stateStart == 0) {   
    //wait to start
    clockRunning = true;
    startingTime = millis();
    
    rectRunning = true;
    rectTime = millis();

    //start icon
    fill(0, 200, 0);
    stroke(0, 150, 0);
    triangle(width/2-5, 23, width/2+10, 30, width/2-5, 37);
  }
  if (stateStart == 1) {
    //start
    clockRunning = false;
    timeSoFar = (millis() - startingTime);// * deltatime;

    rectRunning = false;
    rectSoFar = (millis() - rectTime);

    //pause icon
    rectMode(CORNER);
    fill(0, 200, 0);
    stroke(0, 150, 0);
    rect(width/2-7, 23, 5, 13);
    rect(width/2+2, 23, 5, 13);
  }
  if (stateStart == 2) {
    //pause
    clockRunning = true;
    startingTime = (millis() - timeSoFar);// * deltatime;

    rectRunning  = true;
    rectTime = (millis() - rectSoFar);

    //start icon
    fill(0, 200, 0);
    stroke(0, 150, 0);
    triangle(width/2-5, 23, width/2+10, 30, width/2-5, 37);
  }
  if (stateStart == 3) {
    //continue
    stateStart = 1;
  }

  // scrolling and zooming
  scrollx = -translateX;

  if (translateX >= 0) {
    translateX = 0;
  }

  if (translateX <= -plutoX-width/2) {
    translateX = -plutoX-width/2;
  }

  translate(translateX, translateY);
  scale(zoom);
  
  //Light rectangle
  noStroke();
  fill(#FEFF1F, 200); 
  rectMode(CORNER);  
  rect((sunsize/2)*sizscale, y-sunsize/2, lightx/sizscale, sunsize*sizscale);

  //sun
  fill(#FEFF1F);
  ellipseMode(CENTER);
  ellipse(sunx, y, sunsize*sizscale, sunsize*sizscale);

  //planets
  fill(255, 0, 0);
  noStroke();
  fill(100);
  ellipse(mercuryX, y, 4*sizscale, 4*sizscale);
  fill(#E87223);
  ellipse(venusX, y, 6*sizscale, 6*sizscale);
  fill(#23B2E8);
  ellipse(earthX, y, 6*sizscale, 6*sizscale);
  fill(#E89923);
  ellipse(marsX, y, 5*sizscale, 5*sizscale);
  fill(#E8C123);
  ellipse(jupiterX, y, 20*sizscale, 20*sizscale);
  fill(#E5E592);
  ellipse(saturnX, y, 17*sizscale, 17*sizscale);
  fill(#A8F5F4);
  ellipse(uranusX, y, 15*sizscale, 15*sizscale);
  fill(#5D66FF);
  ellipse(neptuneX, y, 13*sizscale, 13*sizscale);
  fill(#989898);
  ellipse(plutoX, y, 3*sizscale, 3*sizscale);
  
  ships();
}

void mouseWheel(MouseEvent e) {
  translateX -= e.getCount() * mouseX / 100;
}

float scaler(float distance) {
 return (distance * planetscale) + sunsize/2; 
}

void buttons() {

  //interface bar
  rectMode(CORNER);
  fill(10, 200);
  rect(0, 0, width, 60);
  
  //interface bar for rocket
  //rect(0, height-40, width, 40);

  //button to start light
  rectMode(CENTER);
  fill(0, 255, 0, 240);
  rect(width/2, 30, 40, 20, 7);

  //back icon
  fill(255, 0, 0, 240);
  triangle(width/2 - 30, 40, width/2 - 30, 20, width/2 -50, 30);
  //fast forward icon
  fill(255, 0, 0, 240);
  triangle(width/2 + 30, 40, width/2 + 30, 20, width/2 + 50, 30);

  //extra fast forward icon
  triangle(width/2 + 55, 38, width/2 + 55, 22, width/2 + 73, 30);
  //extra back icon
  triangle(width/2 - 55, 38, width/2 - 55, 22, width/2 - 73, 30);
}