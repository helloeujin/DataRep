class GeoPoint {
  
  float lat;
  float lon;
  String dateString;
  String name;
  Date date;
  
  PVector pos = new PVector();
  PVector tpos = new PVector();

  GeoPoint() {
  }
  
  void update() {
    pos.x = lerp(pos.x, tpos.x, 0.1);
    pos.y = lerp(pos.y, tpos.y, 0.1);
    //pos.lerp(tpos, 0.1);
  }
  
  void render() {
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      stroke(255);
      //point(0, 0);
    popMatrix();
  }
}
