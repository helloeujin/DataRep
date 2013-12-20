class Continent {
  
  float unit_x = width*0.05;
  float unit_y = height*0.1;
  float easing = 0.05;
  
  // 6 continents, so 7 gaps
  float d = 140;
  float gap = (width - 2*unit_x - 6*d)/5;
  String continentName;
  
  int ratio_af = 0;
  int ratio_as = 0;
  int ratio_er = 0;
  int ratio_nt = 0;
  int ratio_st = 0;
  int ratio_oc = 0;
  
  float th_0 = 0;
  float th_1 = 0;
  float th_2 = 0;
  float th_3 = 0;
  float th_4 = 0;
  float th_5 = 0;
  
   Continent() { 

   }

  void displayCircle(float ratio_af_, float ratio_as_, float ratio_er_, float ratio_nt_, float ratio_st_, float ratio_oc_) {
    textAlign(CENTER, CENTER);
    noStroke();
    
    ratio_af = int(ratio_af_);
    ratio_as = int(ratio_as_);
    ratio_er = int(ratio_er_);
    ratio_nt = int(ratio_nt_);
    ratio_st = int(ratio_st_);
    ratio_oc = int(ratio_oc_);
    
    for(int i = 0; i < 6; i ++) {
      float cent_x = unit_x + d/2 + i*d + i*gap;
      float cent_y = 3.8*unit_y;
      
      // ellipse background
      noFill();
      strokeWeight(3);
      stroke(82, 84, 103);
      ellipse(cent_x, cent_y, d, d);
      
      // data arc
      strokeCap(PROJECT);
      strokeWeight(6);
      
      // text color
      fill(245, 247, 255, 220);
      
      if(i == 0) {
        textSize(32);
        text(ratio_af + " %", cent_x, cent_y);
        textSize(11);
        continentName = "AFRICA";
        
        noFill();
        stroke(78, 185, 205);
        // target theta
        float target_th = ratio_af*2*PI/100; 
        float dth = target_th - th_0;
        if(abs(dth) > PI/40) {
          th_0 += dth * easing;
        }
        arc(cent_x, cent_y, d*0.88, d*0.88, 0, th_0);
      }
      if(i == 1) {
        textSize(32);
        text(ratio_as + " %", cent_x, cent_y);
        textSize(11);
        continentName = "ASIA";
        
        noFill();
        stroke(255);
        float target_th = ratio_as*2*PI/100;
        float dth = target_th - th_1;
        if(abs(dth) > PI/40) {
          th_1 += dth * easing; 
        }
        arc(cent_x, cent_y, d*0.88, d*0.88, 0, th_1);
      }
      if(i == 2) {
        textSize(32);
        text(ratio_er + " %", cent_x, cent_y);
        textSize(11);
        continentName = "EUROPE";
        
        noFill();
        stroke(109, 202, 116);
        float target_th = ratio_er*2*PI/100;
        float dth = target_th - th_2;
        if(abs(dth) > PI/40) {
          th_2 += dth * easing; 
        }
        arc(cent_x, cent_y, d*0.88, d*0.88, 0, th_2);
      }
      if(i == 3) {
        textSize(32);
        text(ratio_nt + " %", cent_x, cent_y);
        textSize(11);
        continentName = "NORTH AMERICA";
        
        noFill();
        stroke(144,120,219);
        float target_th = ratio_nt*2*PI/100;
        float dth = target_th - th_3;
        if(abs(dth) > 0) {
          th_3 += dth * easing;
        }
        arc(cent_x, cent_y, d*0.88, d*0.88, 0, th_3);
      }
      if(i == 4) {
        textSize(32);
        text(ratio_st + " %", cent_x, cent_y);
        textSize(11);continentName = "SOUTH AMERICA";
        
        noFill();
        stroke(200,94,200);
        float target_th = ratio_st*2*PI/100;
        float dth = target_th - th_4;
        if(abs(dth) > PI/40) {
          th_4 += dth * easing;
        }
        arc(cent_x, cent_y, d*0.88, d*0.88, 0, th_4);
      }
      if(i == 5) {
        textSize(32);
        text(ratio_oc + " %", cent_x, cent_y);
        textSize(11);
        continentName = "OCEANIA";   
        
        noFill();
        stroke(230, 213, 76);
        float target_th = ratio_oc*2*PI/100;
        float dth = target_th - th_5;
        if(abs(dth) > PI/40) {
          th_5 += dth * easing;
        }
        arc(cent_x, cent_y, d*0.88, d*0.88, 0, th_5);
      } 
      text(continentName, cent_x, cent_y + d/2 + 20);
    }
  } 
}
