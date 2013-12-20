class Element {
  
  float year = 0;
  float suicideRate = 0;
  float data = 0;
  color cr;
  int num = 25;
  int cnt = 0;
  int cnti = 0;
  String info;
  float opac2 = 255;
  
  PVector pos = new PVector();
  PVector tpos = new PVector(random(50, width-50), random(height*0.9));
  ArrayList<SubElement> subElementList = new ArrayList();
  
  Element() {
  }
  
  void update() {
    pos.lerp(tpos, 0.04);
  }
  
  void update(int syear) {
    if(year <= syear) {
      pos.lerp(tpos, 0.1);
    }
  }
  
  void render() {   
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      fill(cr);
      ellipse(0, 0, 5, 5);
    popMatrix();
  }
  
  void crender(float opac) {   
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      stroke(255);
      point(0, 0);
    popMatrix();
  }
  
  void subUpdate() {
    for(SubElement se:subElementList) {
      se.update();
    }
  }
  
  void subRender() {
    for(SubElement se:subElementList) {
      se.render();
    }
  }
  
  void subcRender() {
    for(SubElement se:subElementList) {
      se.crender();
    }
  }
  
  void subUpdate(int syear) {
    for(SubElement se:subElementList) {
      //se.update();
      if(se.year <= syear) se.update();
    }
  }
  
  void subRender(int syear) {
    for(int i = 0; i < subElementList.size(); i++) {
      SubElement se = new SubElement();
      se = subElementList.get(i);
      //se.render();
      if(se.year <= syear) se.render();
    }
  }
  
  void showInfo(int syear) {
    textAlign(RIGHT, BOTTOM);
    float mcnt = 1985 + 120 - year;
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      noStroke();
      
      if(year<=syear) {
        cnt++;
        if(year == 1985) {
          //if(cnt > mcnt)  ellipse(0,0,10,10);
        }
        else if(cnt > mcnt/4)  {
          textSize(30);
          if(info != null) {
            
            if(year == 2009) {
              opac2=opac2-2;
              if(opac2<-255) opac2 = 255;
              fill(#FF9900, opac2);
              ellipse(0,0,15,15);
            } else {
              fill(255, 120);
              ellipse(0,0,10,10);
            }          
            //fill(255, 120);
            //ellipse(0,0,10,10);
            fill(255);
            if(year == 1987) text(info, 150, -15);
            else text(info, 0,-15);
          }
        }
      }
    popMatrix();
  }
  
  void addSubElement() {
    float rateInt = ceil(suicideRate);
    for(int i = 0; i < suicideRate; i++) {     
      //float range = map(rateInt, 0, 44, height*0.9,0);
      SubElement se = new SubElement();
      // Drop Motion
      //se.pos.x = random(0,width);
      //se.pos.y = map(i, 0, rateInt, height*0.9,range) - (i+1)*40*height;
      
      // Rise Motion
      se.pos.x = tpos.x;
      se.pos.y = height*0.9;
      se.tpos.x = tpos.x;
      se.tpos.y = map(i, 0, 34, height*0.9, 150);
      //se.tpos.y = map(i, 0, rateInt, height*0.9,range);
      se.year = year;
      se.cr = cr;
      subElementList.add(se);
    }
  }
}
