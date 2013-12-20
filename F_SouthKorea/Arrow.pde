class Arrow {
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  float lerpConst = 0.0001;
  boolean reach = false;
  float tx = map(24, 0, 26-1, 50, width-50);
  float ty = map(33.8, 0, 44, height*0.9,0);

  Arrow() {
  }  
  
  void update(){
    lerpConst = lerpConst + 0.00008;
    pos.lerp(tpos, lerpConst);
  }
  
  void render() {
    stroke(#FF9900);
    strokeWeight(0.6);
    //stroke(0);
    //strokeWeight(2);
    float y = map(33.8, 0, 44, height*0.9,0);
    line(pos.x, height*0.9, pos.x, y);
    
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      fill(255);
      noStroke();
      //triangle(0, 0, -10, -50, 10, -50);
      ellipse(0, 0, 10,10);
    popMatrix();
  }
  
  void displayNum() {
    pushMatrix();
      textSize(34);
      translate(tpos.x, tpos.y);
      fill(255);
      text(33.8, -30, -30);
    popMatrix();
  }
}
