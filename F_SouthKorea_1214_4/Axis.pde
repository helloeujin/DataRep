class Axis {
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  int value;
  int year = 0;
  
  Axis() {
  }
  
  void update() {
    pos.lerp(tpos, 0.1);
  }
  
  void render() {
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      fill(255);
      textAlign(LEFT,TOP);
      textSize(20);
      text(year, 0, 14);
      stroke(255);
      strokeWeight(0.8);
      line(0, 0,0,10);
    popMatrix();
  }
  
  void crender() {
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      fill(75);
      textAlign(LEFT,TOP);
      textSize(40);
      text(year, 0, 16);
      if(year == 75) {
        textSize(28);
        text(" years old", 30, 22);
      }
      stroke(80);
      strokeWeight(1);
      line(0, -230,0,10);
    popMatrix();
  }
  
  void hrender(float opac) {
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      fill(255, opac);
      textAlign(RIGHT, BOTTOM);
      textSize(20);
      text(value, -4, 0);
      stroke(255, opac);
      strokeWeight(0.8);
      line(0, 0, 10, 0);
    popMatrix();
  }
  
  void hrender2(float opac) {
    pushMatrix();
      translate(width-pos.x, pos.y, pos.z);
      fill(255, opac);
      textAlign(LEFT, CENTER);
      textSize(20);
      text(value, 18, 0);
      stroke(255, opac);
      strokeWeight(0.8);
    popMatrix();
  }
}
