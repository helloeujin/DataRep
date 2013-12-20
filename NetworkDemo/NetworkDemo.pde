
ArrayList<Node> nodeList = new ArrayList();

void setup() {
  size(1280, 720, P3D);
  spawnNodes();
  //connectRandom();
  connectClose(50);
}

void draw() {
  background(255);
  for(Node n:nodeList) {
    n.update();
    n.render(); 
  }
}

void connectRandom() {
  for(Node n:nodeList) {
    // assign a single random connection
    Node friend = nodeList.get(floor(random(nodeList.size())));
    // use floor then, we need to worry about "size()-1" : floor, ceil, round
    n.connections.add(friend);
  }
}

void connectClose(float tolerance) {
  for(Node n:nodeList) {
    // assign a connection for any node that is within our tolerance
    for(int i = 0; i < nodeList.size(); i++) {
      Node potentialFriend = nodeList.get(i);
      if(n.tpos.dist(potentialFriend.tpos) < tolerance) {
        n.connections.add(potentialFriend);
      }
    }
  }
}

void spawnNodes() { // generate random data
  for(int i = 0; i < 500; i++) {
    Node n = new Node();
    n.tpos = new PVector(random(width), random(height));
    nodeList.add(n);
  }
}
