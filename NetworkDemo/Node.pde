class Node {
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  
  ArrayList<Node> connections = new ArrayList(); // populate the object later
  
  void update() {
    pos.lerp(tpos, 0.1); 
  }
  
  void render() {
    pushMatrix();
      translate(pos.x, pos.y, pos.z);
      rect(0, 0, 5, 5);
    popMatrix();
    
    // Draw a line to each connection (outside of push/popMatrix)
    for(Node c:connections) {
      line(pos.x, pos.y, pos.z, c.pos.x, c.pos.y, c.pos.z);
    }
  }
}
