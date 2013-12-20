class Article {
  
  PVector pos = new PVector();
  PVector tpos = new PVector();
  boolean clicked = false;
  String st;
  int stat = 0;
  int num = 0;
  int cnt = 0;
  
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
    float ttx = map(1, 0, 8, 50, width-50);
    //fill(#04376C, 255);
    fill(255);
    textSize(52);
    textAlign(RIGHT);
    
    cnt = cnt+35;
    if(cnt > stat) cnt = stat;
    text(cnt, ttx - 20, height*0.32);
    
    textAlign(LEFT);
    text(st, ttx + 20, height*0.32);
  }
}
