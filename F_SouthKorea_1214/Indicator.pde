class Indicator {
  
  PVector pos = new PVector(); // pos of name
  PVector tpos = new PVector();
  color cr;
  
  String indicName;
  String reference;
  String unit;
  boolean clicked = false;
  boolean sclicked = false;
  
  int[] years = new int[26]; //2010-1985
  float[] data = new float[26];
  ArrayList<Element> elementList = new ArrayList();
  ArrayList<Axis> axisList = new ArrayList();
  float opac = 255;
  
  float min_data = 100000;
  float max_data = 0;
  float topac = 0;
  
  Indicator() {
  }
  
  void update() {
    pos.lerp(tpos, 0.1);
  }
  
  void render() {
    pushMatrix();
      fill(0, 0, 255, 100);
      translate(pos.x, pos.y, pos.z);
    popMatrix();
  }
  
  void renderGraph(float opacity) {
    strokeWeight(0.6);
    noFill();
    beginShape();
    stroke(200, opac);
    for(Element e:elementList) {
      e.update();
      if(e.pos.dist(e.tpos) < 7) vertex(e.pos.x, e.pos.y);
    }
    endShape();
    
    for(Axis ax:axisList) {
      ax.update();
      ax.hrender(opac);
    }
    if(!indicName.equals("Suicide Rate"))  displayUnit(opac);
    if(indicName.equals("Suicide Rate")) displayUnit2();
  }
  
  void nrender(float opacity) {
    if(clicked) {
      opac = opac-0.4;
      if(opac<0) opac = 0;
    }
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      fill(100, opac);
      textSize(40);
      textAlign(LEFT);
      text(indicName, 0, 0);
    popMatrix();
  }
  
  void checkClicked() {
    if(pos.dist(mpos)<50 && mousePressed) {
      clicked = true;
      if(indicName.equals("Suicide Rate")) sclicked = true;
    }
  }
  
  void displayUnit(float opac) {
    pushMatrix();
      //translate(200, 200, 0);
      translate(50 + 14, height*0.1+50, 0);
      fill(200, opac);
      textSize(24);
      textAlign(LEFT);
      text(unit, 0, 0);
    popMatrix();
  }
  
  void displayUnit2() {
    topac++;
    if(topac > 200) topac = 200;
    
    pushMatrix();
      //translate(200, 200, 0);
      translate(50, height*0.1+45, 0);
      fill(180, topac);
      textSize(24);
      textAlign(LEFT);
      text(unit, 0, 0);
    popMatrix();
  }
  
  void displayAxis(float opac) {
    for(Axis ax:axisList) {
      ax.update();
      ax.hrender2(opac);
    }
  }
  
  void addElements() {
    for(int i = 0; i < num; i++) {
      Element e = new Element();
      e.year = years[i];
      e.data = data[i];
      e.pos.set(50, map(e.data, 0, 100, height*0.9,150));
      e.tpos.x = map(i,0,num-1,50,width-50);
      e.tpos.y = 0;
      elementList.add(e);
    }
    
    for(int i = 0; i < num; i++) {
      if(data[i] > max_data) max_data = data[i];
      if(data[i] < min_data) min_data = data[i];
    }
    
    for(Element e:elementList) {
      e.tpos.y = map(e.data, min_data, max_data, height*0.9, 150);
    }
    
    int n = 35;
    for(int i = 0; i < n; i++) {
      Axis ax = new Axis();
      ax.pos.set(50, height*0.9);
      ax.tpos.x = 50;
      ax.tpos.y = map(i, 0, n-1, height*0.9, 150);
      //ax.value = int(map(i, 0, n-1, 0, 34));
      //ax.value = int(map(i, 0, n-1, min_data, max_data));
      if(indicName.equals("Suicide Rate")) {
        //ax.value = int(map(i, 0, n-1, 0, max_data));
        ax.value = int(map(i, 0, n-1, 0, 34));
      }
      axisList.add(ax);
    }
  }
}
