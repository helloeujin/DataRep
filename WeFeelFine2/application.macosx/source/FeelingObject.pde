class FeelingObject {
  
  String feeling;
  String sentence;
  String sex; // "1" = male, "0" = female
  
  PVector pos = new PVector(); // x, y, z
  PVector tpos = new PVector(); // target position
  
  FeelingObject() {
  
  }
  
  void update() {
    pos.lerp(tpos, 0.1);
  }
  
  void render() { // easy to transform to 3d
    pushMatrix();
      translate(pos.x, pos.y);
      text(feeling, 0, 0);
    popMatrix();
  }
}
