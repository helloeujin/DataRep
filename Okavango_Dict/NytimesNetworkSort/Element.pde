class Element implements Comparable { // in order to make it sortable
  
  String facetType;
  String facetTerm;
  int count;
  int birthOrder;
  int sortNumber; 
  
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
      float r = 5 + sqrt(count); // consider the area vs length
      ellipse(0, 0, r, r);
      text(facetTerm, r, 0);
    popMatrix();
    
    stroke(255, 50);
    noFill();
    for(Element c:connections) {
      //line(c.pos.x, c.pos.y, c.pos.z, pos.x, pos.y, pos.z);
      arcBetweenPoints(pos, c.pos);
      //bezierBetweenPoints(pos, c.pos, seed.pos); 
    }
  }
  
  int compareTo(Object o) {   
    //return(count - ((Element) o).count); //cast element (b.c. generic java object dosn't know which object it is)
    return(((Element) o).sortNumber - sortNumber); // instead of count
    
    //return(int(random(-100,100)));
    // should return negative(-) when behind
    // should return positive(+) when forward
    // should return 0, when same
  }
}
