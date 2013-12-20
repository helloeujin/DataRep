class Article {
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  boolean clicked = false;
  int num = 0;
  
  Article() {
  }
  
  void update() {
  }
  
  void render() {
    fill(255,0,0);
    ellipse(pos.x, pos.y, 140, 140);
  }
  
  void checkClicked() {
    if(pos.dist(mpos) < 70 && mousePressed) clicked = true;
  }
  
  void showArticle() {
  }
}
