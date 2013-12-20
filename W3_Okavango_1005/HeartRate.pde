class HeartRate {
  
  String dateTime;
  String person;
  float lon = 0; // x
  float lat = 0; // y
  float cnt = 0;
  
  /* date */
  int y = 0; // year
  int m = 0; // month
  int d = 0; // day
  
  /* time */
  int h = 0;  // hour
  int mi = 0; // minute
  int s = 0;  // second
  
  /* hr */
  float hr = 0;
  float temp = 0;
  float energy = 0;
  
  /* display */
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  HeartRate() {
  }
  
  void update() {
    //pos.lerp(tpos, 0.1);
  }
  
  void render() {
    pushMatrix();
      translate(pos.x, pos.y);
      fill(255, 0, 0, 150);
      noStroke();
      ellipse(0, 0, 3, 3);
    popMatrix();
    //checkMouse();
  }
  
  void getDate() {
    String[] pieces = split(dateTime, 'T');
    String[] date = split(pieces[0], '-');
    String[] tempTime = split(pieces[1], '+');
    String[] time = split(tempTime[0], ':');
    
    y = int(date[0]);
    m = int(date[1]);
    d = int(date[2]);
    
    h = int(time[0]);
    mi = int(time[1]);
    s = int(time[2]);
  }
  
  void checkMouse() {
    if(dist(pos.x, pos.y, mouseX, mouseY) < 10) {
      String currentTime = h+":"+mi+":"+s;  
      pushMatrix();
        translate(pos.x, pos.y);
        fill(255);
        //textSize(24);
        text(currentTime, 0, 0);
      popMatrix();
    }
  }
}
