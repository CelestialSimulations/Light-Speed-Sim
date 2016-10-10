class flying_obj {
  float rlastTime = 0;
  float rspeed = 0;
  PShape shipSvg;
  PShape flame;
  
  float defpos;
  String svgName;
  float time;
  
  boolean displayShip = true;
  boolean displayFire = true;
  
  flying_obj(float dp, String sn) { 
   
    defpos = dp;
    svgName = sn;
    shipSvg = loadShape("svgs/"+svgName+".svg");
  }
  void fly(float rate, float t) {
    time = t;
    rate = rate/pow(10, 6);
    
    if ( time - rlastTime >= 1000/10) {
      rlastTime = time;
      rspeed = rspeed + (rate/10);
    }
  }
  void appear () {
    if(displayShip == true) {
     shape(shipSvg, ((rspeed*planetscale) * delta)/sizscale+defpos, height/2, 20, 20);
    }
  }
  void burn () {
    if(displayFire) {
      flame = loadShape("svgs/FireIcon.svg");
      shape(flame, ((rspeed*planetscale) * delta)/sizscale+defpos, height/2, 20, 20); 
    }
  }
  void destroy() {
    
    displayShip = false; 
    displayFire = false;
  }

}