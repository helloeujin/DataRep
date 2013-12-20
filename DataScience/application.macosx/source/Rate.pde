class Rate {
  
  String country;
  float rate_2011 = 0;
  int cnt = 0;
  int opac = 0;
  //float[] rates = new float[2011 - 1985 + 1]; // from 1985 to 2011 year
  
  Rate() {
    
  }
  
  void display() {
    stroke(0);
    strokeWeight(6);
    fill(180, opac);
    pushMatrix();
      translate(width*0.1, 0);
      translate((cnt)*70, height*0.9);
      
      fill(150);
      textFont(myfont);
      textSize(11);
      text(country, 0+5, 0+10);
      
      if(country.equals("Korea"))  fill(255, 0, 0, opac);
      else  fill(180);
      
      float h = map(rate_2011, 0, 35, 0, height * 0.7);
      rect(0, 0, 50, -h);
      fill(0);
      textSize(16);
      text(int(rate_2011), 0+15, -h+13);
    popMatrix();
    opac++;
    if(opac>220) opac = 220;
  }
  
}
