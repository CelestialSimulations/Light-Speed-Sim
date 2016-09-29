float rxpow = 100;

float sizscale = 1;
float planetscale = .33;

int ex = 0;

int stateStart = 0;

int delta = 1;
int deltatime = 1;

int startingTime;
int timeSoFar;
boolean clockRunning;

int rectTime;
int rectSoFar;
boolean rectRunning;

float zoom = 1;

float translateX = 0;
float translateY;

float scrollx = 60;

float lastTime = 0;
float x= 0;

PImage starbackground;

void setup () {
  size (1300, 500);

  PFont font= loadFont("AnonymousPro-Bold-30.vlw");
  textFont(font);

  starbackground = loadImage("SolarSystemBG.jpg");
}

void draw () {
  background(70);
  image(starbackground, 0, 0, width, height);

  int y = height/2;
  int rmillis = 1;
  int sunsize = 60;

  int milliseconds = (millis() - startingTime) * deltatime;
  int seconds = milliseconds / 1000;
  int minutes = seconds / 60;
  int hours = minutes / 60;
  int days = hours / 24;

  float merx = (35.98 * planetscale) + sunsize/2;
  float venx = (67.23 * planetscale) + sunsize/2;
  float earx = (92.897 * planetscale) + sunsize/2;
  float marx = (141.6 * planetscale) + sunsize/2;
  float jupx = (483.6 * planetscale) + sunsize/2;
  float satx = (888.2 * planetscale) + sunsize/2;
  float urax = (1786.4 * planetscale) + sunsize/2;
  float nepx = (2798.8 * planetscale) + sunsize/2;
  float plux = (3666.2 * planetscale) + sunsize/2;

  buttons();

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
  ////Lightspeed is 186,000 mi/sec
  // * Every second, .186282 times the planetscale (which is relative to the distance of the planets)
  // is added to the rectangle's width *//
  if ( rmillis - lastTime >= 1000/10) {
    lastTime = rmillis;
    x = x+(.186282/10);
  }

  rxpow = (x*planetscale) * delta;

  //This displays the distance so far by using the pixel length of the light and dividing
  //it by the planetscale and multiplying it to the accurate power 
  fill(255);
  textAlign(CORNER);
  text("Distance: "+nfc((rxpow*pow(10, 6))/planetscale, 2)+" miles", width/2 + 200, 40);

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
    println(stateStart);
  }

  if (stateStart == 0) {   
    //wait to start
    clockRunning = true;
    startingTime = millis();// * deltatime;

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

  if (translateX <= -plux-width/2) {
    translateX = -plux-width/2;
  }

  translate(translateX, translateY);
  scale(zoom);

  //Light rectangle
  noStroke();
  fill(#FEFF1F, 200); 
  rectMode(CORNER);  
  rect((sunsize/2)*sizscale, y-sunsize/2, rxpow/sizscale, sunsize*sizscale);

  //sun
  fill(#FEFF1F);
  ellipseMode(CENTER);
  ellipse(ex, y, sunsize*sizscale, sunsize*sizscale);

  //planets
  fill(255, 0, 0);
  noStroke();
  ellipse(merx, y, 4*sizscale, 4*sizscale);
  ellipse(venx, y, 6*sizscale, 6*sizscale);
  ellipse(earx, y, 6*sizscale, 6*sizscale);
  ellipse(marx, y, 5*sizscale, 5*sizscale);
  ellipse(jupx, y, 20*sizscale, 20*sizscale);
  ellipse(satx, y, 17*sizscale, 17*sizscale);
  ellipse(urax, y, 15*sizscale, 15*sizscale);
  ellipse(nepx, y, 13*sizscale, 13*sizscale);
  ellipse(plux, y, 3*sizscale, 3*sizscale);
}

void mouseWheel(MouseEvent e) {

  translateX -= e.getCount() * mouseX / 100;
}

void buttons() {

  //interface bar
  rectMode(CORNER);
  fill(10, 200);
  rect(0, 0, width, 60);

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

void spaceship() {
}