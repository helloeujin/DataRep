class Education {
  String country;
  int math = 0;
  int cnt = 0;
  
  Education() {
    
  }
  
  void display() {
    stroke(0);
    strokeWeight(7);
    //fill(100,200);
    pushMatrix();
      translate(width*0.4, 0);
      translate((cnt)*8, height*0.8);
      
      if(country.equals("KOR"))  fill(0, 255, 0, 180);
      else  fill(140, 140);
      
      float h = map(math, 350, 650, 0, height * 0.7);
      rect(0, 0, 8, -h);

      if(dist(width*0.4+(cnt)*8, height*0.8, mouseX, mouseY) < 4) {
        fill(255);
        textSize(16);
        text(math+" in " + country, 13,0+10);// width*0.4+(cnt)*8, height*0.8 - h);
      }
      
    popMatrix();
  }
}
