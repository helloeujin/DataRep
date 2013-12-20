class Tweet {
  float x = 0;
  float y = 0;
  int opacity = 180;
  String username = "hi";
  boolean isDraw = false;
  boolean isCircle = false;
  float panX = 0;
  float panY = 0;
  int tI = 0;
  color tcolor;
  float lat = 0;
  float lon = 0;
  
  
  // for arc
  Location pLocation = new Location(40.722912, -74.007606);
  ArcLine myArc;

  boolean isClicked = false;
  int temp_i = 0;
  int strokeWidth = 0;
  float opacity_2 = 20;
  Location myLocation;

  Tweet() {
    myArc = new ArcLine();
    getColor();
  }

  void display(int strokeWidth_, Fireworks myFire_) {
    getPos();
    Fireworks myFire = new Fireworks();
    myFire = myFire_;
    
    havasMarker = new SimplePointMarker(pLocation);
    ScreenPosition havasPos = havasMarker.getScreenPosition(map);
    float havasX = havasPos.x;
    float havasY = havasPos.y;
    strokeWidth = strokeWidth_;

    myMarker = new SimplePointMarker(myLocation);
    ScreenPosition myPos = myMarker.getScreenPosition(map);
    x = myPos.x;
    y = myPos.y;

    myArc.display(havasX, havasY, x, y, strokeWidth_, tcolor);
    panX = myArc.tempX;
    panY = myArc.tempY;

    if (myArc.cnt > myArc.num-1) {
      isDraw = true;
      pushMatrix();
        strokeWeight(20);
        translate(x, y);
        //drawSpreadNew();
        myFire.display();
      popMatrix();
      noStroke();
    }
  }

  void drawSpreadNew() { 
    int num = 20;
    float D = map(strokeWidth,0,10,2,34);
    float o = 255/num;
    float d = (D/num);
    float H = 0, S = 0, B = 0;
    
    noStroke();
    fill(57, 18, 100, 100); 
    ellipse(0, 0, 10, 10);
    ellipse(0, 0, 6, 6);

    for (int i = 0; i < num; i++) {
      noFill();
      H = 57;
      S = map(i, 0, num, 0, 60);
      B = map(i, 0, num, 100, 100);
      stroke(H, S, B);
      strokeWeight(1);

      if (i == temp_i) {
        strokeWeight(1.2);
        stroke(H, S, B);
      } else {
        strokeWeight(1);
        noStroke();
      }
      ellipse(0, 0, d*i, d*i);
    }
    temp_i++;
    if (temp_i > num) temp_i = 0;
    opacity_2 = opacity_2 - 0.8;
  }
  
  void getPos() {
    myMarker = new SimplePointMarker(myLocation);
    ScreenPosition myPos = myMarker.getScreenPosition(map);
    x = myPos.x;
    y = myPos.y; 
  }
  


}

