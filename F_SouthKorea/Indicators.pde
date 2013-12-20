class Indicators {
  
  String[] label = {"Children at work","GDP growth rate","CO2 emissions"
            ,"Unemployment rate","Youth Inactivity","Secure internet servers"
            ,"Life expectancy","Mobile cellular subscriptions"
            ,"Water consumption","Motor vehicles","Infant mortality"
            ,"Population","Education attainment","Suicide rate","Household debt"};
  String labelSelected;
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  PVector rot = new PVector();
  PVector trot = new PVector();
  
  Indicators() {
  }
  
  void update() {
    pos.lerp(tpos, 0.1);
  }
  
  void render() {
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      rotateX(rot.x);
      rotateY(rot.y);
      rotateZ(rot.z);
      fill(#FF9900);
      //ellipse(0, 0, 5, 5);
      //text(random(100), 5, 0);
      text(labelSelected, 5, 0);
    popMatrix();
  }
}
