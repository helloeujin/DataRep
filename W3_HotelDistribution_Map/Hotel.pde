class Hotel {
  int star = 0;
  float price = 0;
  String country;
  float d = height*0.74;
  float r = d/2;
  String hotelName;
  float easing = 0.1;

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
  float translate_x = width*0.6;
  float translate_y = height*0.5;

  float lat = 0;
  float lon = 0;
  boolean clicked = false;
  boolean selected = false;

  Hotel() {
  }

  void updateSlow() {
    //pos.lerp(tpos, 0.01);
    float dx = tpos.x - pos.x;
    float dy = tpos.y - pos.y;
    pos.x += dx * easing;
    pos.y += dy * easing;
  }
  
  void updateFast() {
    //pos.lerp(tpos, 0.03);
    float dx = tpos.x - pos.x;
    float dy = tpos.y - pos.y;
    pos.x += dx * easing;
    pos.y += dy * easing;
  }

  void render() {
    rectMode(CENTER);
    pushMatrix();
      noStroke();
      fill(c);
      translate(pos.x, pos.y);
      rect(0, 0, 4, 4);
      interaction();
      fill(c, 140);
      if(clicked) ellipse(0, 0, 20, 20);
    popMatrix();
  }
  
  void interaction() {
    /*
    if(dist(mouseX, mouseY, pos.x, pos.y) < 10) {
      float len = 30;
      textSize(len);
      textAlign(LEFT);
      text(hotelName, 16, 0);
      text("$ "+ price, 16, len*0.8);
      text(star + " STAR", 16, len*0.8*2);
      fill(c, 120);
      ellipse(0, 0, 20, 20);
      
      if(mousePressed) clicked = !clicked;
    }
    */
    
    if(selected) {
      float len = 30;
      textSize(len);
      textAlign(LEFT);
      text(hotelName, 16, 0);
      text("$ "+ price, 16, len*0.8);
      text(star + " STAR", 16, len*0.8*2);
      fill(c, 120);
      ellipse(0, 0, 20, 20);
      
      if(mousePressed) clicked = !clicked;
    }
  }

  void priceRender() {
    int gap = 5;
    pushMatrix();
    translate(translate_x, translate_y);
    noFill();
    smooth();
    
    fill(120, 100);
    textAlign(RIGHT, CENTER);
    
    textFont(myFont);
    textSize(18);
    text("USD " + 0, -d*0.52, 20);
    text("STAR ONE", -d*0.52, -20);
    textAlign(LEFT, CENTER);
    text("USD " + maxPrice, d*0.52, 20);
    text("STAR FIVE", d*0.52, -20);
    
    // for the price guideline
//    for (int i = 0; i < gap+1; i ++) {
//      float angle = map(i, 0, gap, maxAngle, minAngle);
//      float x = (r*1.07)*cos(angle);
//      float y = (r*1.07)*sin(angle);
//      float tx = (r*0.95)*cos(angle);
//      float ty = (r*0.95)*sin(angle);
//      float cx = (r*1.0)*cos(angle);
//      float cy = (r*1.0)*sin(angle);
//      
////      int gap_price = int(map(i, 0, gap, 0, maxPrice));
////      textFont(myFont);
////      textSize(22);
////      textAlign(CENTER, CENTER);
////      text("$"+gap_price, x, y);
//    }  
    //stroke(c, 200);
    stroke(c);
    strokeWeight(0.3);
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
    star_x = r*cos(star_angle);
    star_y = r*sin(star_angle);
    
    float price_angle = map(price, 0, maxPrice, maxAngle, minAngle);
    price_x = r*cos(price_angle);
    price_y = r*sin(price_angle);
    
    tpos.x = price_x + translate_x;
    tpos.y = price_y + translate_y;
    pos.x = random(width);
    pos.y = random(height);
  }
}

