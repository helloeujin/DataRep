class Economy {
  
  float[] gdp_capita = new float[2012-1960+1];
  String gdp_whole = "155.213586 91.62360601 103.8672749 142.3626527 120.63605 105.7698691 130.2648401 157.2902539 194.7795608 239.231464 278.7873797 302.2277793 322.7225528 403.4641509 555.6677296 608.2277798 824.423333 1041.586281 1382.921004 1746.730347 1674.387559 1845.65362 1938.112133 2117.529507 2306.860313 2367.782505 2702.641221 3367.542808 4465.670323 5438.252668 6153.093997 7122.701332 7555.272527 8219.896199 9525.43563 11467.81385 12249.17315 11234.777 7462.838645 9554.439443 11346.66499 10654.93555 12093.7573 13451.22942 15028.94015 17550.85389 19676.12418 21590.10558 19028.01293 16958.65239 20540.17693 22388.39597 22590.15648";
  String[] list = split(gdp_whole," ");
  
  float[] debt = {125.0, 120.5, 116.4, 123.2, 131.3, 139.0, 142.6, 146.9, 150.8, 156.3};
  int[] year = {2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011};
  Economy() {
    getGdpData();
  }
  
  void getGdpData() {
    for(int i = 0; i < list.length; i++) {
      gdp_capita[i] = float(list[i]);
    }
  }
  
  void display() {
    beginShape();
    noFill();
    strokeWeight(1);
    stroke(0, 0, 255,180);
    for(int i = 0; i < gdp_capita.length; i++) {
      pushMatrix();
        float h = map(gdp_capita[i],50, 22600, 0, height * 0.5);
        vertex(width*0.1 + i*5, height*0.8-h);
        
        if(dist(width*0.1 + i*5, height*0.8-h, mouseX, mouseY) < 5) {
          fill(255, 200);
          textSize(15);
          text("$ " +gdp_capita[i], width*0.1 + i*5 + 5, height*0.8-h);
          noFill();
        }

        //text(int(rate_2011), 0+15, -h+13);
      popMatrix();
    }
    endShape();
  }

void displayNew() {
  beginShape();
    noFill();
    strokeWeight(1);
    stroke(0, 0, 255,180);
    for(int i = 0; i < debt.length; i++) {
      pushMatrix();
        float h = map(debt[i], 100, 160, 0, height * 0.5);
        vertex(width*0.1 + i*30, height*0.8-h);
        
        if(dist(width*0.1 + i*30, height*0.8-h, mouseX, mouseY) < 5) {
          fill(255, 200);
          textSize(15);
          text(debt[i]+ " in "+year[i], width*0.1 + i*30 + 10, height*0.8-h);
          noFill();
        }
      popMatrix();
    }
    endShape();
  }
}
