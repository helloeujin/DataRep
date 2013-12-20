class Country {
  
  String countryName;
  int[] years = new int[26]; //2010-1985
  float[] suicideRate = new float[26];
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  PVector rot = new PVector();
  PVector trot = new PVector();
  
  PVector npos = new PVector();
  
  color cr;
  ArrayList<Element> elementList = new ArrayList();
  
  Country() {
  }
  
  void update() {
    pos.lerp(tpos, 0.1);
    for(int i = 0; i < 26; i++) {
      Element e = new Element();
      e = elementList.get(i);
      e.update();
    }
  }
  
  void render() {
    strokeWeight(1.5);
    stroke(255);
    line(50,height*0.9,width-50,height*0.9);
    noStroke();
    for(int i = 0; i < 26; i++) {
      Element e = new Element();
      e = elementList.get(i);
      e.render();
    }
    displayName();
  }
  
  void renderGraph() {
    strokeWeight(1.5);
    noFill();
    beginShape();
    stroke(cr);
    for(int i = 0; i < 26; i++) {
      Element e = new Element();
      e = elementList.get(i);
      vertex(e.pos.x, e.pos.y);
    }
    endShape();
    displayName();
  }
  
  void renderGraphFill() {    
    strokeWeight(1.5);
    //noFill();
    beginShape();
    stroke(cr);
    fill(cr, 50);
    vertex(50,height*0.9);
    for(int i = 0; i < 26; i++) {
      Element e = new Element();
      e = elementList.get(i);
      vertex(e.pos.x, e.pos.y);
    }
    vertex(width-50, height*0.9);
    endShape();
    displayName();
    
    // for black
    float y1 = map(9.882329, 0, 44, height*0.9,0);
    float y2 = map(33.5, 0, 44, height*0.9,0);
    stroke(0);
    strokeWeight(1.6);
    line(50, height*0.9, 50, y1);
    line(width-50, height*0.9, width-50, y2);
  }
  
  void renderStaticGraph() {
    strokeWeight(1.5);
    noFill();
    beginShape();
    stroke(cr);
    for(int i = 0; i < 26; i++) {
      Element e = new Element();
      e = elementList.get(i);
      vertex(e.tpos.x, e.tpos.y);
    }
    endShape();
    displayName();
  }
  
  void addElements() {
    for(int i = 0; i < 26; i++) {
      Element e = new Element();
      e.year = years[i];
      e.suicideRate = suicideRate[i];
      e.pos.x = map(i,0,26-1,50,width-50);
      e.pos.y = height*0.9;
      e.tpos.x = e.pos.x;
      e.tpos.y = map(e.suicideRate, 0, 44, height*0.9,0);
      e.cr = cr;
      
      if(i == 0) npos = e.pos;
      elementList.add(e);
    }
  }
  
  void displayName() {
    textFont(myfont);
    textSize(38);
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      fill(cr);
      text(countryName, 0, 0);
    popMatrix();
  }
  
  void displayName2(float opacity) {
    textSize(20);
    fill(cr, opacity);
    pushMatrix();
      translate(npos.x, npos.y);
      if(countryName.equals("Japan")) text(countryName, 0, 11);
      else text(countryName, 3, -12);
    popMatrix();
  }
}
