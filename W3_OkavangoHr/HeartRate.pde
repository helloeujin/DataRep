class HeartRate {
  
  float hr = 0;
  float temp = 0;
  float energy = 0;
  String dateTime;
  String person;
  
  PVector hr_pos = new PVector(); // x, y, z
  PVector hr_tpos = new PVector(); // target position
  PVector temp_pos = new PVector();
  PVector temp_tpos = new PVector();
  
  HeartRate() {
    
  }
  
  void update() {
    hr_pos.lerp(hr_tpos, 0.1);
    temp_pos.lerp(temp_tpos, 0.1);
  }
  
  void render() { // easy to transfom to 3D  
    pushMatrix();
      translate(hr_pos.x, hr_pos.y);
      fill(255);
      noStroke();
      ellipse(0, 0, 2, 2);   
    popMatrix();
    
    pushMatrix();
      translate(temp_pos.x, temp_pos.y);
      fill(255, 0, 0);
      noStroke();
      ellipse(0, 0, 2, 2);   
    popMatrix();
  }
}
