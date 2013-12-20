class Hotel {

  int star = 0;
  float price = 0;
  String country;
  float diameter = height*0.8;
  float radius = diameter/2;

  PVector pos = new PVector();
  PVector tpos = new PVector();
  float opac = 255;
  color c = color(255, 255, 255);

  Hotel() {
  }

  void update() {
    pos.lerp(tpos, 0.1);
  }

  void render() {
  }

  void priceRender() {
    float translate_x = width*0.68;
    float translate_y = height*0.53;
    int gap = 5;
    smooth();
    
    pushMatrix();
    translate(translate_x, translate_y);
    noFill();
    stroke(180, 100);
    strokeWeight(0.5);
    ellipse(0, 0, diameter, diameter);
    
    // get color
    if (star == 1)  c = color(109, 164, 190);
    else if (star == 2) c = color(141, 178, 203);
    else if (star == 3) c = color(56, 173, 119);//color(181);
    else if (star == 4) c = color(197, 146, 158);
    else if (star == 5) c = color(193, 70, 93);

    // get star position
    //float star_angle = map(star, 1, 5, PI/2 + PI/6, PI - PI/6);
    float star_angle = map(star, 1, 5, PI - PI/6, PI/2 + PI/6);
    float star_x = radius*cos(star_angle);
    float star_y = radius*sin(star_angle);
    stroke(c);
    noFill();
    strokeWeight(1);
    smooth();
    //displayStar(star_x, star_y, 7, 12, 5);
    
    noStroke();
    fill(c);
    ellipse(star_x, star_y, 10, 10);

    // get price position
    float price_angle = map(price, 0, maxPrice, 8*PI/6, 2*PI + PI/6);
    float price_x = radius*cos(price_angle);
    float price_y = radius*sin(price_angle);
    fill(255, 0, 0);
    noStroke();
    //ellipse(price_x, price_y, 10, 10);
  
    // for the price guideline
    for (int i = 0; i < gap+1; i ++) {
      float angle = map(i, 0, gap, 8*PI/6, 2*PI + PI/6);
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
      textFont(numFont);
      textSize(12);
      textAlign(CENTER, CENTER);
      text("$"+gap_price, x, y);
    }

    float distance = dist(star_x + translate_x, star_y+translate_y, mouseX, mouseY);        
    if (distance < 10) {
      stroke(c);
      strokeWeight(1.5);
    } else {
      stroke(120, 40);
      strokeWeight(0.8);
    }

    line(star_x, star_y, price_x, price_y); 
    popMatrix();
  }

  void displayStar(float x, float y, float radius1, float radius2, int npoints) {
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    //noFill();
    //stroke(170);
    //strokeWeight(1);
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
}

