//to create a new ship, first start by declaring it
// for the statement, you will need to with flying_obj,
// then it's the ship's name.
//
// flying_obj, ship name 
//    ↓        ↓
flying_obj deathstar;
flying_obj rocket;

// declaring the rate of rocket as 100000
int rocketRate = 100000;

void shipSetup() {
  //initialize
  
  // the parameters for flying_obj are: the default position, the name of 
  // the image you want to use (must be svg format). For the default
  // position, you could use the position of a planet, like jupiterX
  //
  //                     default position, svg name
  //                            ↓            ↓          
  deathstar = new flying_obj(mercuryX, "death-star");
  rocket = new flying_obj(earthX, "rocketship");
}

void ships() {
  //rate is in miles
  
  // build() makes an image of the selected ship show up
  deathstar.build();
  
  // fly(186282) makes ship move forward at a rate of 186,282 miles per second
  // the number 186282 is the rate - it could be any number, if you like. rmillis 
  // is the variable that keeps in track with pausing and resuming, and must be added
  //            rate   rmillis
  //              ↓        ↓
  deathstar.fly(186282, rmillis);
  
  // this statement increases the rate steadily - this is basically acceleration
  rocketRate = rocketRate + 1000;
  
  // this prints the current rate of the ship onto the console. println can be useful when 
  // you want to find the value of a variable
  println(rocketRate);
  
  // deathsta
  rocket.build();
  rocket.fly(rocketRate, rmillis);
  
  // rmillis is the time that has passed since the play button was pressed in
  // milliseconds, so 4000 milliseconds is equal to 4 seconds
  if(rmillis > 4000) {
    // burn() places a fire image in front of the ship
    rocket.burn(); 
  }
  
  // try adding a condition for destroying the ship when rocketRate becomes very high. 
  // The syntax to destroy it would be rocket.destroy();
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  // Hint
  // if (rocketRate equals some high number) {
  //    rocket.destroy();  
  // }
}