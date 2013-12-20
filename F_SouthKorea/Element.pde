class Element {
  
  float year = 0;
  float suicideRate = 0;
  color cr;
//  float roundness = 0;
//  float troundness = 0;
  
  PVector pos = new PVector();
  PVector tpos = new PVector(random(50,width-50), random(height*0.9));
  
  Element() {
  }
  
  void update() {
    pos.lerp(tpos, 0.04);
//    roundness = lerp(roundness, troundness, 0.05);
  }
  
  void render() {
//    float i = year - 1985;
//    float r = map(i, 0, 26-1, 0, TAU);
    
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
//      rotate(r * roundness);
      fill(cr);
      ellipse(0, 0, 5, 5);
      stroke(cr);
    popMatrix();
    //line(pos.x, pos.y, pos.x, height*0.9);
  }
}
