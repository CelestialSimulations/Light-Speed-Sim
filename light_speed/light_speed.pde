float rxpow = 100;//((.186282 * pow(10, 6)))/pow(10, 6);

float powscale = 6;//6.5;
float sizscale = 1;

float scale = .33;

int ex = 0;

int stateStart = 0;
int stateSpeedin = 0;

float delta = 1;
int deltatime = 1;

int startingTime;
int timeSoFar;
boolean clockRunning;

int rectTime;
int rectSoFar;
boolean rectRunning;

int buttontog = 240;
int fastforwardtog = 240;
int backtog = 240;

float zoom = 1;

float scaleFactor, translateX, translateY;

int stateReset = 0;

float scrollx = 60;
float scrolly = 500-12;

int stateScroll = 0;

float rectMinute = 1;

int stateChapter = 0;

float lastTime = 0;

float x= 0;//.186282;

float time = 0;

int changechap = 1;

int hide = 100;

int Width = 1300;

int slide = Width/2;//width/2+330;

int stateBackChap = 0;

PImage starbackground;

void setup () {
  //fullScreen();
  size (1300, 500);
  
  //smooth();
  
  //surface.setResizable(true);

  PFont font= loadFont("AnonymousPro-Bold-30.vlw");
  textFont(font);
  
  translateX = 0;
  
  starbackground = loadImage("SolarSystemBG.jpg");
  
}

void draw () {
  background(70);
  
  image(starbackground,0,0, width, height);
  
  rectMode(CORNER);
  fill(10,200);
  rect(0,0, width, 60);
  
  int milliseconds = ((millis() - startingTime) * deltatime) + (changechap);
    int seconds = (milliseconds) / 1000;
    int minutes = seconds / 60;
    int hours = minutes / 60;
    int days = hours / 24;
    
    int milliseconds2 = ((timeSoFar) * deltatime) + (changechap);// * deltatime;
  
  if (clockRunning == true) {
    /*int milliseconds = ((millis() - startingTime) * deltatime) + (changechap);
    int seconds = (milliseconds) / 1000;
    int minutes = seconds / 60;
    int hours = minutes / 60;
    int days = hours / 24;*/
    milliseconds -= seconds * 1000;
    seconds -= minutes * 60;
    minutes -= hours * 60;
    hours -= days * 24;

    String message =
      nf(hours, 2, -1) + " : " +
      nf(minutes, 2, -1) + " : " +
      nf(seconds, 2, -1);

    fill(255);
    textSize(20);
    textAlign(CORNER);
    text(message, 20,35);
        
  } 
  else {
    //int milliseconds2 = ((timeSoFar) * deltatime) + (changechap);// * deltatime;
    /*int seconds = (milliseconds) / 1000;
    int minutes = seconds / 60;
    int hours = minutes / 60;
    int days = hours / 24;*/
    milliseconds2 -= (seconds * 1000);
    seconds -= minutes * 60;
    minutes -= hours * 60;
    hours -= days * 24;
    
    String message =
      nf(hours, 2, -1) + " : " +
      nf(minutes, 2, -1) + " : " +
      nf(seconds, 2, -1);

    fill(255);
    textSize(20);
    textAlign(CORNER);
    text(message, 20,35);
        
  }
  
  int rmillis = 1;
  
  if(rectRunning == true) {
     rmillis = (millis() - rectTime);
  }
  
  if(rectRunning == false) {
     rmillis = rectSoFar;
  }
  
  buttons();

  int sunsize = 60;
  
  rectMode(CORNER);
  
  //decrease scale button
  fill(150);
  rect(width-75, 20, 20, 20, 5);
  fill(0);
  stroke(20);
  line(width-75+5,30,width-75+15,30);
  
  if (mouseX > width-75 && mouseX < width-75+20 && mouseY > 20 && mouseY < 40 && mousePressed) {
    powscale = powscale + .01;
   //sizscale = sizscale - .01;

    //scale = scale - .05;
    
    //delay(150);
    zoom -= .015;
    translateY = translateY + 3.68;
  }
  
  //increase scale button
  noStroke();
  fill(150);
  rect(width-40, 20, 20, 20, 5);
  fill(0);
  stroke(20);
  line(width-40+5,30,width-40+15,30);
  line(width-40+10,25,width-40+10,35);
  
  if (mouseX > width-40 && mouseX < width-40+20 && mouseY > 20 && mouseY < 40 && mousePressed) {
    powscale = powscale - .01; 
    //sizscale = sizscale + .01;

    //scale = scale + .05;
    
    //delay(150);
    zoom += .015;
    translateY = translateY - 3.68;//height;//-= 1;
    
    println(zoom);
    if(translateY <= -1545.6058) {
      translateY = -1545.6058;
      zoom -= .015;
    }
  }
  
  float merx = (35.98 * scale) + sunsize/2;
  float venx = (67.23 * scale) + sunsize/2;
  float earx = (92.897 * scale) + sunsize/2;
  float marx = (141.6 * scale) + sunsize/2;
  float jupx = (483.6 * scale) + sunsize/2;
  float satx = (888.2 * scale) + sunsize/2;
  float urax = (1786.4 * scale) + sunsize/2;
  float nepx = (2798.8 * scale) + sunsize/2;
  float plux = (3666.2 * scale) + sunsize/2;
  
  //println((merx - sunsize/2)/scale);
    
    
    
  ////Lightspeed is 186,000 mi/sec
  // * Every second, .186282 times the scale (which is relative to the distance of the planets)
  // is added to the rectangle's width *//
  if( rmillis - lastTime >= 1000){
    lastTime = rmillis;
    x = x+(.186282);// * delta;
  }
  
  rxpow = (x*scale) * delta;
  
  //This displays the distance so far accurately by using the pixel length of the light and dividing
  //it by the scale and multiplying it to the accurate power 
  fill(255);
  textAlign(CORNER);
  text("Distance: "+nfc((rxpow*pow(10,6))/scale,2)+" miles", width/2 + 200, 40);
  
  
  //compress/stretch solar system 
  noStroke();
  fill(150, 100);
  //arcMode(CENTER);
  arc(width/2+1,height-100,40,40, -HALF_PI, HALF_PI);
  arc(width/2-1,height-100,40,40, HALF_PI, 3*(HALF_PI), PIE);
  
  if(mouseX > width/2 && mouseX < width/2+40 && mouseY > height-100 && mouseY < height-100+40 && mousePressed) {
   scale = scale + .01;
  }
  if(mouseX < width/2 && mouseX > width/2-40 && mouseY > height-100 && mouseY < height-100+40 && mousePressed) {
   scale = scale - .01;
  }
  
  /*noStroke();
  ellipseMode(CENTER);
  fill(0,100,0);
  ellipse(width/2, height-50, 20/scale, 20/scale);
  fill(100,0,0,200);
  ellipse(width/2, height-50, 30*scale, 30*scale);
  if(mouseX > width/2- (10/scale) && mouseX < width/2 +(10/scale) && mouseY > (height-50)-(10/scale) && mouseY < (height-50)+(10/scale) && mousePressed) {
    rect(30,30,30,30);
    scale = scale + .02;
  }
  if(mouseX > width/2- (15*scale) && mouseX < width/2 +(15*scale) && mouseY > (height-50)-(15*scale) && mouseY < (height-50)+(15*scale) && mousePressed) {
    rect(30,30,30,30);
    scale = scale - .01;
  }*/
  
  /*noStroke();
  rectMode(CENTER);
  fill(180, 100);
  rect(width/2, height-20, 200, 10, 7);
  fill(120);
  ellipseMode(CENTER);
  ellipse(slide, height-20, 15, 15);
  
  if(mouseX > width/2-100/*slide-100* && mouseX < width/2+100/*slide+100* && mousePressed) {
   slide = mouseX; 
   if(slide > width/2+10 && slide < width/2+20) {
     scale = scale + .01;
     //delay(200);
   }
  }*/
   
  int y = height/2;

  //speeed up time
  if (mouseX > width/2+30 && mouseX < width/2+50 && mouseY > 20 && mouseY < 40 && mousePressed) {    
      delta = delta + 1;      
      deltatime = deltatime + 1;   
  }
  
  //speed up time even more
  if(mouseX > width/2+55 && mouseX < width/2+73 && mouseY > 22 && mouseY < 38 && mousePressed) {
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
  text("x"+nf(delta,1,-1), width/2 - 180, 40); 
  
  //play/pause/continue
  if (mouseX > width/2-20 && mouseX < width/2+20 && mouseY > 20 && mouseY < 40 && mousePressed) {
    stateStart++;
    delay(200);
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
    startingTime = ((int)millis() - timeSoFar);// * deltatime;
    
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
  
  //use reset button
  if(mouseX < 340 && mouseX > 300 && mouseY < 40 && mouseY > 20 && mousePressed) {
    stateStart = 0;
  }
    
  int a = 10;
  
  //increase chapter
  if(mouseX > width/2+80 && mouseX < width/2+100 && mouseY > 25 && mouseY < 35 && mousePressed) {
   stateChapter++;
   delay(200);
   stateStart = 2;
  // x = merx;
   //seconds = 180;
  
  }
  
  if(stateChapter == 1) {    
   delta = delta + a;
   deltatime = deltatime + a;  
   if(rxpow >= merx-sunsize/2) {
     delta = delta - a;
     deltatime = deltatime - a;
   }  
   if(!(rxpow >= merx-sunsize/2)) {
    // delta = delta - 5;
    // deltatime = deltatime - 5;
   }  
  }
  
  if(stateChapter == 2) {    
   delta = delta + a;
   deltatime = deltatime + a;   
   if(rxpow >= venx-sunsize/2) {
     delta = delta - a;
     deltatime = deltatime - a;
   } 
  }
  
  if(stateChapter == 3) {    
   delta = delta + a;
   deltatime = deltatime + a;   
   if(rxpow >= earx-sunsize/2) {
     delta = delta - a;
     deltatime = deltatime - a;
   }
  }
  
  if(stateChapter == 4) {    
   delta = delta + a;
   deltatime = deltatime + a;   
   if(rxpow >= marx-sunsize/2) {
     delta = delta - a;
     deltatime = deltatime - a;
   }
  }
  
  if(stateChapter == 5) {    
   delta = delta + a;
   deltatime = deltatime + a;   
   if(rxpow >= jupx-sunsize/2) {
     delta = delta - a;
     deltatime = deltatime - a;
   }
  }
  
  if(stateChapter == 6) {    
   delta = delta + a;
   deltatime = deltatime + a;   
   if(rxpow >= satx-sunsize/2) {
     delta = delta - a;
     deltatime = deltatime - a;
   }
  }
  
  if(stateChapter == 7) {    
   delta = delta + a;
   deltatime = deltatime + a;   
   if(rxpow >= urax-sunsize/2) {
     delta = delta - a;
     deltatime = deltatime - a;
   }
  }
  
  if(stateChapter == 8) {    
   delta = delta + a;
   deltatime = deltatime + a;   
   if(rxpow >= nepx-sunsize/2) {
     delta = delta - a;
     deltatime = deltatime - a;
   }
  }
  
  if(stateChapter == 9) {    
   delta = delta + a;
   deltatime = deltatime + a;   
   if(rxpow >= plux-sunsize/2) {
     delta = delta - a;
     deltatime = deltatime - a;
   }
  }
  
  if(mouseX > width/2-100 && mouseX < width/2-80 && mouseY > 25 && mouseY < 35 && mousePressed) {
    //stateBackChap = 1;
  }
  if(stateBackChap == 1) {
    delta = delta - 10;
    deltatime= deltatime -10;
    if(rxpow >= merx-sunsize/2) {
      delta = delta+10;
      deltatime = deltatime + 10;
      //rxpow = merx-sunsize/2;
    }
  }
  
  String[] planetName = {" Mercury", " Venus", " Earth", " Mars", " Jupiter",
                         " Saturn", " Uranus", " Neptune", " Pluto" };
  
  //int hide = 255;
  
  //message when light passes planet
  textAlign(CENTER);
  noStroke();
  rectMode(CORNER);
  if (rxpow >= merx-sunsize/2 && rxpow < venx-sunsize/2) {
   fill(255, hide);
   rect(width/2 + -12, height-36, 150, 20);
   if (mouseX > width/2-31 && mouseX < width/2-31+127 && mouseY > height-36 && mouseY < height-36+18) {
     hide = 0;
   }
   if (!(mouseX > width/2-31 && mouseX < width/2-31+127 && mouseY > height-36 && mouseY < height-36+18)) {
     hide = 255;
   }
   fill(255);
   text("Passed" + planetName[0] + " at 35,980,000,000 miles", width/2, height-20);    
  }
  if (rxpow >= venx-sunsize/2-3 && rxpow < earx-sunsize/2) {
   fill(255, hide);
   rect(width/2 + -37, height-36, 127, 18);
   if (mouseX > width/2-73 && mouseX < width/2-37+127 && mouseY > height-36 && mouseY < height-36+18) {
     hide = 0;
   }
   if (!(mouseX > width/2-37 && mouseX < width/2-37+127 && mouseY > height-36 && mouseY < height-36+18)) {
     hide = 255;
   }
   fill(255);
   text("Passed" + planetName[1] + " at 67,230,000,000 miles", width/2, height-20);    
  }
  if (rxpow >= earx-sunsize/2-3 && rxpow < marx-sunsize/2) {
   fill(255, hide);
   rect(width/2 + -41, height-36, 127, 18);
   if (mouseX > width/2-41 && mouseX < width/2-41+127 && mouseY > height-36 && mouseY < height-36+18) {
     hide = 0;
   }
   if (!(mouseX > width/2-31 && mouseX < width/2-31+127 && mouseY > height-36 && mouseY < height-36+18)) {
     hide = 255;
   }
   fill(255);
   text("Passed" + planetName[2] + " at 92,897,000,000 miles", width/2, height-20);    
  }
  if (rxpow >= marx-sunsize/2-2.5 && rxpow < jupx-sunsize/2) {
   fill(255, hide);
   rect(width/2 + -48, height-36, 139, 18);
   if (mouseX > width/2-48 && mouseX < width/2-48+127 && mouseY > height-36 && mouseY < height-36+18) {
     hide = 0;
   }
   if (!(mouseX > width/2-48 && mouseX < width/2-48+127 && mouseY > height-36 && mouseY < height-36+18)) {
     hide = 255;
   }
   fill(255);
   text("Passed" + planetName[3] + " at 141,600,000,000 miles", width/2, height-20);    
  }
  if (rxpow >= jupx-sunsize/2-10 && rxpow < satx-sunsize/2) {  
   fill(255, hide);
   rect(width/2 + -41, height-36, 138, 18);
   if (mouseX > width/2-41 && mouseX < width/2-41+127 && mouseY > height-36 && mouseY < height-36+18) {
     hide = 0;
   }
   if (!(mouseX > width/2-41 && mouseX < width/2-41+127 && mouseY > height-46 && mouseY < height-36+18)) {
     hide = 255;
   }
   fill(255);
   text("Passed" + planetName[4] + " at 483,600,000,000 miles", width/2, height-20);    
  }
  if (rxpow >= satx-sunsize/2-8.5 && rxpow < urax-sunsize/2) {  
   fill(255, hide);
   rect(width/2 + -41, height-36, 138, 18);
   if (mouseX > width/2-41 && mouseX < width/2-41+127 && mouseY > height-36 && mouseY < height-36+18) {
     hide = 0;
   }
   if (!(mouseX > width/2-41 && mouseX < width/2-41+127 && mouseY > height-46 && mouseY < height-36+18)) {
     hide = 255;
   }
   fill(255);
   text("Passed" + planetName[5] + " at 888,200,000,000 miles", width/2, height-20);    
  }
  if (rxpow >= urax-sunsize/2 && rxpow < nepx-sunsize/2) {
   fill(255, hide);
   rect(width/2 + -46, height-36, 152, 18);
   if (mouseX > width/2-41 && mouseX < width/2-41+127 && mouseY > height-36 && mouseY < height-36+18) {
     hide = 0;
   }
   if (!(mouseX > width/2-41 && mouseX < width/2-41+127 && mouseY > height-46 && mouseY < height-36+18)) {
     hide = 255;
   }
   fill(255);
   text("Passed" + planetName[6] + " at 1,786,400,000,000 miles", width/2, height-20);    
  }
  if (rxpow >= nepx-sunsize/2 && rxpow < plux-sunsize/2) {  
   fill(255, hide);
   rect(width/2 + -41, height-36, 153, 18);
   if (mouseX > width/2-41 && mouseX < width/2-41+127 && mouseY > height-36 && mouseY < height-36+18) {
     hide = 0;
   }
   if (!(mouseX > width/2-41 && mouseX < width/2-41+127 && mouseY > height-46 && mouseY < height-36+18)) {
     hide = 255;
   }
   fill(255);
   text("Passed" + planetName[7] + " at 2,798,800,000,000 miles", width/2, height-20);    
  }
  if (rxpow >= plux-sunsize/2) {  
   fill(255, hide);
   rect(width/2 + -56, height-36, 155, 18);
   if (mouseX > width/2-41 && mouseX < width/2-41+127 && mouseY > height-36 && mouseY < height-36+18) {
     hide = 0;
   }
   if (!(mouseX > width/2-41 && mouseX < width/2-41+127 && mouseY > height-46 && mouseY < height-36+18)) {
     hide = 255;
   }
   fill(255);
   text("Passed" + planetName[8] + " at 3,666,200,000,000 miles", width/2, height-20);    
  }
  
  scrollx = -translateX;
    
  /*(//scrollbar
  fill(255);
  rectMode(CORNER);
  rect(scrollx, scrolly, 100, 10, 7);*/
    
  if (translateX >= 0) {
   translateX = 0; 
  }
  
  if (translateX <= -plux-width/2) {
    translateX = -plux-width/2;
  }
  
  translate(translateX, translateY);
  scale (zoom);
    
  //Light
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
  //ellipseMode(CORNER);
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

void mouseWheel(MouseEvent e){
 
  translateX -= e.getAmount() * mouseX / 100;
 
}

void buttons() {
  
  //button to start light
  rectMode(CENTER);
  fill(0, 255, 0, buttontog);
  rect(width/2, 30, 40, 20, 7);
  
  //back icon
  fill(255, 0, 0, backtog);
  triangle(width/2 - 30, 40, width/2 - 30, 20, width/2 -50, 30);
  //fast forward icon
  fill(255, 0, 0, fastforwardtog);
  triangle(width/2 + 30, 40, width/2 + 30, 20, width/2 + 50, 30);
  
  //extra fast forward icon
  triangle(width/2 + 55, 38, width/2 + 55, 22, width/2 + 73, 30);
  //extra back icon
  triangle(width/2 - 55, 38, width/2 - 55, 22, width/2 - 73, 30);
  
  /*//reset button
  fill(255);
  rect(319, 27, 40, 15, 7);
  fill(50);
  //textSize(13);
  textAlign(CORNER);
  text("Reset", 303, 32);
  textSize(18);*/
  
  //Chapters
  //forward chapter icon
  fill(0,0,255);
  noStroke();
  triangle(width/2+80,25,width/2+80,35,width/2+90,30);
  triangle(width/2+90,25,width/2+90,35,width/2+100,30);
  //back chapter icon
  triangle(width/2-80,25,width/2-80,35,width/2-90,30);
  triangle(width/2-90,25,width/2-90,35,width/2-100,30);
  
  /*rectMode(CORNER);
  fill(255);
  rect(0,0, width, 70);*/
  
}

void hover (int prehover, int hover, float locationx, float locationy, int sizex, int sizey) {
   boolean button = mouseX > locationx && mouseX < locationx + sizex && mouseY > locationy && mouseY < locationy + sizey;
   if(button) {
   prehover = 180; 
   }
   if(!button) {
   prehover = 240;
   }
 
}