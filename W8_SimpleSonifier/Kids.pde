class Kids {
  
  String country;
  float fruit = 0;
  float breakfast = 0;
  float exercise = 0;
  float lifeSatisfaction = 0;
  float likeSchool = 0;
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  Kids() {
  }
  
  void update() {
    pos.lerp(tpos, 0.1);
  }
  
  void render() {
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      fill(255);
      ellipse(0, 0, 10, 10);
    popMatrix();
  }
}
