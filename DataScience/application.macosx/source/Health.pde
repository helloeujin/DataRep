class Health {
  
  //float[] life_exp = {71.4, 76.0, 80.7};
  int[] life_exp = {71, 76, 81};
  int[] life_year = {1990, 2000, 2010};
  
  Health() {
    
  }
  
  void display() {
    beginShape();
    noFill();
    strokeWeight(1);
    stroke(255, 0, 0,180);
    for(int i = 0; i < life_exp.length; i++) {
      pushMatrix();
        float h = map(life_exp[i],70, 82, 0, height * 0.5);
        vertex(width*0.7 + i*90, height*0.8-h);
        
        fill(255, 0, 0);
        ellipse(width*0.7 + i*90, height*0.8-h,2,2);
        noFill();
        
        if(dist(width*0.7 + i*90, height*0.8-h, mouseX, mouseY) < 5) {
          fill(255, 200);
          textSize(15);
          text(life_exp[i]+" in "+life_year[i], width*0.7 + i*90 + 15, height*0.8-h);
          noFill();
        }

        //text(int(rate_2011), 0+15, -h+13);
      popMatrix();
    }
    endShape();
  }
}
