class Element {
  
  String facetType;
  String facetTerm;
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  PVector rot = new PVector();
  PVector trot = new PVector();
  
  ArrayList<Element> connections = new ArrayList();
  int generation = 0;
  boolean spawned = false;
  
  void update() {
    pos.lerp(tpos, 0.1);
    rot.lerp(trot, 0.1);
    
    //check to see if we're being clicked. if we are, spawn
    if(mousePressed && mousePos.dist(pos) < 10 && !spawned) {
      toSpawn = this;
      spawned = true;
    }
  }
  
  void render() {
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      rotateX(rot.x);
      rotateY(rot.y);
      rotateZ(rot.z);
      fill(spawned ? #FF9900: #FFFFFF);
      ellipse(0, 0, 5, 5);
      text(facetTerm, 5, 0);
    popMatrix();
    
    stroke(255, 50);
    for(Element c:connections) {
      line(c.pos.x, c.pos.y, c.pos.z, pos.x, pos.y, pos.z);
    }
  }
}
