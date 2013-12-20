class SubElement {
  
  color cr;
  float year = 0;
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  SubElement() {
  }
  
  void update() {
    pos.lerp(tpos, 0.1);
  }
  
  void render() {
    noStroke();
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      if(pos.dist(tpos) < 4) fill(100);
      else fill(cr);
      ellipse(0, 0, 2, 2);
    popMatrix();
  }
  
  void crender() { //color render
    noStroke();
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      fill(100);
      if(pos.x-2 < mpos.x && mpos.x< pos.x+2) {
        //if() { 
          fill(cr);
        //}
      }
      ellipse(0, 0, 2, 2);
    popMatrix();
  }
}
