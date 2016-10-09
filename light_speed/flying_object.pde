class flying_obj {
  //float time;
  float rlastTime = 0;
  float rspeed = 0;
  flying_obj() { 
    //time = m;
    //println(m);
  }
  void fly(float rate, float time) {
    rate = rate/pow(10, 6);
  
  if ( time - rlastTime >= 1000/10) {
    rlastTime = time;
    rspeed = rspeed + (rate/10);
  }
  //rocketx = (rspeed*planetscale) * delta;
  }
  void appear (float defpos, String svgName) {
    rocket = loadShape(svgName);
  shape(rocket, ((rspeed*planetscale) * delta)/sizscale+defpos, height/2, 20, 20);
  }
}