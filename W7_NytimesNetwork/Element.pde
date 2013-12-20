class Element {
  
  /* - - - control - - - */
  //int controlCnt = 0; // 0, 1, 2
  
  String facetType; 
  String facetTerm;
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  PVector rot = new PVector();
  PVector trot = new PVector();
  
  ArrayList<Element> connections = new ArrayList();;
  int generation = 0;
  boolean spawned = false;
  
  int networkedNum = 0;
  color c1 = color(200, 120);
  color c2 = color(200, 120);
  
  void update() {
    pos.lerp(tpos, 0.1);
    rot.lerp(trot, 0.1);
    //println("updated");
    
    //check to see if we're being clicked; if we are, spawn
    if(mousePressed && mousePos.dist(pos) < 10 && !spawned) {
      toSpawn = this;
      spawned = true;
      println("clicked");
    }
    if(networkedNum > 0) spawned = true;
  }
  
  void render() {
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      rotateX(rot.x);
      rotateY(rot.y);
      rotateZ(rot.z);
      if(controlCnt == 0)  c1 = color(#FF9900, 100 + networkedNum*20);
      //if(controlCnt == 1)  c1 = color(165, 27, 61, 100 + networkedNum*20);
      if(controlCnt == 1)  c1 = color(80, 27, 191, 120 + networkedNum*20);
      if(controlCnt == 2)  c1 = color(51, 247, 199, 100 + networkedNum*20);
      c2 = color(200, 120);
      fill(spawned ? c1: c2);
      //fill(spawned ? #FF9900:#FFFFFF);
      //fill(#FF9900, 50 + networkedNum*50);
      ellipse(0, 0, 5, 5);
      text(facetTerm, 5, 0);
    popMatrix();
    
    stroke(255, 50);
    for(Element c:connections) {
      line(c.pos.x, c.pos.y, c.pos.z, pos.x, pos.y, pos.z);
    }
  }
}
