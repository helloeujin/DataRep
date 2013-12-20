class Social {
  String country;
  int rate = 0;
  int cnt = 0;
  
  Social () {
    
  }
  
  void display() {
    stroke(0);
    strokeWeight(7);
    //fill(100,200);
    pushMatrix();
      translate(width*0.7, 0);
      translate((cnt)*8, height*0.8);
      
      if(country.equals("Korea"))  fill(255, 0, 0, 180);
      else  fill(140, 140);
      
      float h = map(rate,0, 11, 0, height * 0.55);
      rect(0, 0, 8, -h);

      if(dist(width*0.7+(cnt)*8, height*0.8, mouseX, mouseY) < 4) {
        fill(255);
        textSize(16);
        text(rate+" in " + country, 13,0+10);// width*0.4+(cnt)*8, height*0.8 - h);
      }
      
    popMatrix();
  }
}
