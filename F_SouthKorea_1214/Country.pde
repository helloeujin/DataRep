class Country {
  
  String countryName;
  int num = 26;
  boolean clicked = false;
  int[] years = new int[26]; //2010-1985
  float[] suicideRate = new float[26];
  String[] info = new String[26];
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  PVector rot = new PVector();
  PVector trot = new PVector();
  
  PVector npos = new PVector();
  PVector epos = new PVector(); // end pos
  PVector clickPos = new PVector();
  
  color cr;
  ArrayList<Element> elementList = new ArrayList();
  
  Country() {
  }
  
  void update() {
    pos.lerp(tpos, 0.1);
    for(Element e:elementList) {
      e.update();
    }
  }
  
  void update(int syear) {
    pos.lerp(tpos, 0.1);
    for(Element e:elementList) {
      e.update(syear);
    }
  }
  
  void render() {
    noStroke();
    for(Element e:elementList) {
      e.render();
    }
  }
  
  void renderGraph(float opacity) {
    strokeWeight(1.0);
    noFill();
    beginShape();
    stroke(cr, opacity);
    for(Element e:elementList) {
      vertex(e.pos.x, e.pos.y);
    }
    endShape();
  }
  
  void renderGraph(int syear, float opacity) {
    strokeWeight(1.0);
    noFill();
    beginShape();
    stroke(cr, opacity);
    for(Element e:elementList) {
      if(e.year <= syear) {
        vertex(e.pos.x, e.pos.y);
      }
    }
    endShape();
  }
  
  void subUpdate() {
    for(Element e:elementList) {
      e.subUpdate();
    }
  }
  
  void subUpdate(int syear) {
    for(Element e:elementList) {
      e.subUpdate(syear);
    }
  }
  
  void subRender(int syear) {
    for(Element e:elementList) {
      e.subRender(syear);
    }
  }
  
  void subcRender() {
    for(Element e:elementList) {
      e.subcRender();
    }
  }
  
  
  void showInfo(int syear) {
    for(Element e:elementList) {
      e.showInfo(syear);
    }
  }
  
  void displayName(float opacity) {
    textSize(20);
    fill(cr, opacity);
    textAlign(LEFT);
    pushMatrix();
      translate(npos.x, npos.y);
      if(countryName.equals("Japan")) text(countryName, 0, 11);
      else if(countryName.equals("United States")) text(countryName, 3, -12);
    popMatrix();
  }
  
  
  void addElements() {
    for(int i = 0; i < num; i++) {
      Element e = new Element();
      e.year = years[i];
      e.suicideRate = suicideRate[i];
      
      if(countryName.equals("South Korea")) {
        e.pos.x = map(i,0,num-1,50,width-50);
        e.pos.y = height*0.9;
      } else {
        e.pos.x = map(i,0,num-1,50,width-50);
        e.pos.y = height*0.9;
      }
      
      e.tpos.x = map(i,0,num-1,50,width-50);
      e.tpos.y = map(e.suicideRate, 0, 34, height*0.9,150);
      e.cr = cr;
      e.addSubElement();
      elementList.add(e);
      
      if(i == 0) npos = e.pos;
      if(e.year == 2009) clickPos = e.tpos;
      epos = e.tpos;
    }
  }
  
  void checkClicked() {
    //if(epos.dist(mpos)<50 && mousePressed)  clicked = true;
    if(clickPos.dist(mpos)<50 && mousePressed)  clicked = true;
  }
  
  void addInfo() {
    for(Element e:elementList) {
      if(countryName.equals("South Korea")) {
        //if(e.year == 1987) e.info = "Korean Air Flight Terror";
        if(e.year == 1997) e.info = "Asian financial crisis";
        //if(e.year == 2003) e.info = "Iraq War";
        if(e.year == 2003) e.info = "ranked #1 among oecd nations";
        if(e.year == 2008) e.info = "Subprime mortgage crisis";
        if(e.year == 2009) e.info = "The highest suicide record";
      }
    }
  }
  
  void init() {
    if(countryName.equals("South Korea")) {
        pos.set(50, height*0.2, 0);
      } else if(countryName.equals("Japan")) {
        pos.set(50, height*0.15, 0);
      } else if(countryName.equals("United States")) {
        pos.set(50, height*0.1, 0);
      }
      tpos = pos;
    
    for(int i = 0; i < elementList.size(); i++) {
      Element e = new Element();
      e = elementList.get(i);
      e.pos.x = map(i,0,elementList.size()-1,50,width-50);
      e.pos.y = height*0.9;
      e.tpos.x = e.pos.x;
      e.tpos.y = map(e.suicideRate, 0, 34, height*0.9,150);
      //e.tpos.y = map(e.suicideRate, 0, 44, height*0.9,0);
    }
  }
}
