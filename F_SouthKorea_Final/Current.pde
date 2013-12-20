class Current {
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  int total = 0; // in 2009
  int num = 0; // group number
  
  float xoff = 0;
  float yoff = 10;
  
  ArrayList<Element> elementList = new ArrayList();
  ArrayList<Axis> axisList = new ArrayList();
  boolean done = false;
  float opac = 0;
  
  Current() {
  }
  
  void update() {
    pos.lerp(tpos, 0.1);
  }
  
  void render() {
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
    popMatrix();
  }
  
  void subUpdate() {
    for(Element e:elementList) {
      e.update();
    }
  }
  
  void subRender() {
    for(Element e:elementList) {
      e.crender(255);
      //if(done) e.crender(20);
      //else e.crender(255);
    }
  }
  
  void addElements() {
    for(int i = 0; i < total; i++) {
      xoff = xoff + .5;
      yoff = yoff + .5;
      
      Element e = new Element();
      e.data = i;
      //e.pos.set(width/2, height/2);
      e.pos.x = random(0,width);
      e.pos.y = -10;
      e.tpos.x = random(0, width); 
      e.tpos.y = random(0, height);
      elementList.add(e);
    }
    //setpos(0);
  }
  
  void setpos() {
    float d = map(1, 0, 8, 0, width);
    float h = map(total, 81, 3060, 20, 170); // make the 
    //float h = map(total, 0, 3060, 0, 170);
    for(int i = 0; i < total; i++) {
      xoff = xoff + .5;
      yoff = yoff + .5;
      
      Element e = new Element();
      e = elementList.get(i);
      //e.tpos.x = map(num, 0, 8, 50, width-50)+ random(10, d-20);
      //e.tpos.y = height*0.8 - random(height*0.25);
      e.tpos.x = map(num, 0, 8, 50, width-50) + h*(noise(xoff)-0.5) + d/2;
      e.tpos.y = height*0.65 + h*noise(yoff) - h/2;
      //e.tpos.y = height*0.6 + 160*noise(yoff) - 80;
    }
    done = true;
  }
  
  void setpos(int con) {
    for(Element e:elementList) {
      xoff = xoff + .5;
      yoff = yoff + .5;
      e.tpos.x = noise(xoff) * width;
      e.tpos.y = noise(yoff) * height;
    }
  }
  
  void axisRender() {
    for(Axis ax:axisList) {
      ax.update();
      ax.crender();
    }
  }
  
  void axisInit() {
    for(int i = 0; i < 8; i++) {
      float x = map(i, 0, 8, 50, width-50);
      Axis ax = new Axis();
      ax.pos.set(0, height*0.8);
      ax.tpos.set(x, height*0.8);
      ax.year = 5+ i*10;
      axisList.add(ax);
    }
  }
  
  void showUnit() {
    opac++;
    if(opac > 140) opac = 140;
    fill(150, opac);  
    textAlign(CENTER);
    textSize(48);
    text("Number of suicides by age group", width/2, height*0.34);
  }
  
  void showUnit2() {
    opac--;
    if(opac < 0) opac = 0;
    fill(150, opac);
    textAlign(CENTER);
    textSize(48);
    text("Number of suicides by age group", width/2, height*0.34);
  }
  
  void init() {
    for(int i = 0; i < total; i++) {
      xoff = xoff + .5;
      yoff = yoff + .5;
      
      Element e = new Element();
      e = elementList.get(i);
      e.data = i;
      //e.pos.set(width/2, height/2);
      e.pos.x = random(0,width);
      e.pos.y = -10;
      e.tpos.x = random(0, width); 
      e.tpos.y = random(0, height);
      e.cnt = 0;
      //elementList.add(e);
    }
    done = false;
    //setpos(0);
  }
}
