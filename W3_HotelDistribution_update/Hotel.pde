class Hotel {
  int star = 0;
  float price = 0;
  String country;
  float diameter = height*0.74;
  float radius = diameter/2;
  String hotelName;

  PVector pos = new PVector();
  PVector tpos = new PVector();
  float opac = 255;
  color c = color(255, 255, 255);
  int numStar = 0;
  
  float star_x = 0;
  float star_y = 0;
  float price_x = 0;
  float price_y = 0;
  
  float minAngle = PI/25;
  float maxAngle = PI - PI/25;
  float minA = minAngle + PI;
  float maxA = maxAngle + PI; 
  float translate_x = width*0.63;
  float translate_y = height*0.53;

  float lat = 0;
  float lon = 0;

  Hotel() {
  }

  void updateSlow() {
    pos.lerp(tpos, 0.01);
  }
  
  void updateFast() {
    pos.lerp(tpos, 0.03);
  }

  void render() {
    pushMatrix();
      noStroke();
      //fill(c, 180);
      fill(c);
      translate(pos.x, pos.y);
      rect(0, 0, 3, 3);
      //ellipse(0, 0, 7,7);
      interaction();
    popMatrix();
  }
  
  void interaction() {
    if(dist(mouseX, mouseY, pos.x, pos.y) < 5) {
      textSize(30);
      textAlign(LEFT);
      text(hotelName, 0, 0);
      //text(hotelName, width*0.1, height*0.5);
    }
  }

  void priceRender() {
    int gap = 5;
    pushMatrix();
    translate(translate_x, translate_y);
    noFill();
    stroke(190, 90);
    smooth();
    strokeWeight(0.8);
    arc(0, 0, diameter*1.012, diameter*1.012, minAngle, maxAngle);
    
    // for the price guideline
    for (int i = 0; i < gap+1; i ++) {
      float angle = map(i, 0, gap, maxAngle, minAngle);
      float x = (radius*1.07)*cos(angle);
      float y = (radius*1.07)*sin(angle);
      float tx = (radius*0.95)*cos(angle);
      float ty = (radius*0.95)*sin(angle);
      float cx = (radius*1.0)*cos(angle);
      float cy = (radius*1.0)*sin(angle);

      noStroke();
      fill(160);
      ellipse(cx, cy, 4, 4);

      int gap_price = int(map(i, 0, gap, 0, maxPrice));
      textFont(myFont);
      textSize(22);
      textAlign(CENTER, CENTER);
      text("$"+gap_price, x, y);
    }  
    stroke(c, 200);
    strokeWeight(0.4);
    float t = 2;
    curveTightness(t);
  
    beginShape();
      noFill();
      curveVertex(0, 0);
      curveVertex(star_x, star_y);
      curveVertex(price_x, price_y);
      curveVertex(0, 0);
    endShape();
    popMatrix();
  }

  void displayStar(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
  
  void check() {
    // get color
    if (star == 1)  c = color(104, 162, 26);
    else if (star == 2) c = color(249, 176, 74);
    else if (star == 3) c = color(11, 148, 190); //color(181);
    else if (star == 4) c = color(226, 41, 55);
    else if (star == 5) c = color(143, 101, 149);
    
    // get position
    int tempNum = 0;
    if (star == 1)  tempNum = numStar;
    else if (star == 2) tempNum = numStar_1 + numStar;
    else if (star == 3) tempNum = numStar_1 + numStar_2 + numStar;
    else if (star == 4) tempNum = numStar_1 + numStar_2 + numStar_3 + numStar;
    else if (star == 5) tempNum = numStar_1 + numStar_2 + numStar_3 + numStar_4 + numStar;

    float star_angle = map(tempNum, 0, cnt, minAngle + PI, maxAngle + PI);
    star_x = radius*cos(star_angle);
    star_y = radius*sin(star_angle);
    
    float price_angle = map(price, 0, maxPrice, maxAngle, minAngle);
    price_x = radius*cos(price_angle);
    price_y = radius*sin(price_angle);
    
    tpos.x = price_x + translate_x;
    tpos.y = price_y + translate_y;
    pos.x = random(width);
    pos.y = random(height);
  }
}

