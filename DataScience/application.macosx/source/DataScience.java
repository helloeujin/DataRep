import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class DataScience extends PApplet {


Table table;
Table edu_table;
Table neet_table;
Table social_table;
PFont myfont;
int condition = 0;
int opacity = 0;
int opacity2 = 0;
ArrayList <Rate> myRate = new ArrayList();
ArrayList <Education> myEdu = new ArrayList();
ArrayList <Neet> myNeet = new ArrayList();
ArrayList <Social> mySocial = new ArrayList();
Economy myEconomy = new Economy();
Health myHealth = new Health();

public void setup() {
  size(1280, 720);
  background(0);
  myfont = loadFont("ArialNarrow-48.vlw");
  condition = 0;
  
  // load table
  table = loadTable("suicideRate_oecd.csv", "header");
  edu_table = loadTable("pisa.csv", "header");
  neet_table = loadTable("neet.csv", "header");
  social_table = loadTable("social.csv", "header");
  loadData();
  loadEduData();
  loadNeetData();
  loadSocialData();
}

public void draw() {
  background(0);
  checkMouse();
  if (condition == 0) firstScreen();
  else if (condition == 1) suicideTotal(); // suicide rate total
  else if (condition == 2) whatWeKnow();
  else if (condition == 3) whatWeNeedToKnow();
  else if (condition == 4) conclusion();
//  fill(255);
//  text(condition, width*0.9, height*0.1);
}

public void firstScreen() {
  fill(220, 180);
  textFont(myfont);
  textAlign(LEFT, CENTER);
  textSize(58);
  text("SOUTH KOREA", width*0.1f, height*0.5f);
  fill(0, 0, 255, opacity);
  text(" SUICIDE CAPITAL", width*0.4f, height*0.5f);
  opacity++;
  if (opacity > 180) opacity = 180;
}

public void suicideTotal() {
  fill(220, 180);
  textFont(myfont);
  textSize(46);
  text("SUICIDE RATE 2011", width*0.1f, height*0.1f);
  
  textSize(18);
  fill(120);
  text("deaths per 100,000", width*0.15f, height*0.25f);
  
  for (Rate r: myRate) {
    if(r.rate_2011 > 0)  r.display();
  }
}

public void whatWeKnow() {
  fill(220, 180);
  textFont(myfont);
  textSize(46);
  text("WHAT WE KNOW ABOUT S.KOREA", width*0.1f, height*0.1f);
  
  textSize(28);
  text("HIGH ECONOMIC GROWTH", width*0.1f, height*0.85f);
  text("GOOD EDUCATION", width*0.4f, height*0.85f);
  text("IMPROVED HEALTH", width*0.7f, height*0.85f);
  
  textSize(14);
  fill(150, 140);
  text("GDP PER CAPITA", width*0.1f, height*0.85f +35);
  text("PISA PERFORMANCE", width*0.4f, height*0.85f+35);
  text("LIFE EXPECTANCY", width*0.7f, height*0.85f+35);
  
  myEconomy.display();
  myHealth.display();
  for (Education e: myEdu) {
    e.display();
  }
}

public void whatWeNeedToKnow() {
  fill(220, 180);
  textFont(myfont);
  textSize(46);
  text("WHAT WE NEED TO KNOW ABOUT S.KOREA", width*0.1f, height*0.1f);
  
  fill(0, 0, 255, 180);
  text("NEED TO", width*0.2467f, height*0.1f);
  
  fill(220, 180);
  textSize(28);
  text("FINANCIAL VULNERABILITY", width*0.1f, height*0.85f);
  text("YOUTH INACTIVITY", width*0.4f, height*0.85f);
  text("LACK OF SOCIAL SUPPORT", width*0.7f, height*0.85f);
  
  textSize(14);
  fill(150, 140);
  text("HOUSEHOLD DEBT", width*0.1f, height*0.85f +35);
  text("NEET POPULATION", width*0.4f, height*0.85f+35);
  text("SOCAIL EXPENDITURE", width*0.7f, height*0.85f+35);
  
  myEconomy.displayNew();
//  myHealth.display();
  for (Neet n: myNeet) {
    n.display();
  }
  for (Social s: mySocial) {
    s.display(); 
  }
}

public void conclusion() {
  fill(220, 180);
  textFont(myfont);
  textSize(46);
  text("People in South Korea", width*0.1f, height*0.3f);
  text("at risk of being socially excluded", width*0.1f, height*0.4f);
  fill(0, 0, 255, opacity2);
  text("They don\u2019t have a place to go",width*0.1f, height*0.6f);
  opacity2++;
  if(opacity2 > 180)  opacity2 = 180;
}

public void checkMouse() {
  // right arrow
  if ((mouseX>width*0.95f)&&(mouseY>0)) {
    fill(255, 40);
    noStroke();
    rect(width*0.95f, 0, width*0.1f, height);
  }
  // left arrow
  if ((mouseX<width*0.05f)&&(mouseY>0)) {
    fill(255, 40);
    noStroke();
    if (condition != 0)  rect(0, 0, width*0.05f, height);
  }
}

public void mouseClicked() {
  // right arrow
  if ((mouseX>width*0.95f)&&(mouseY>0)) {
      if (condition == 0)  condition = 1;
      else if (condition == 1)  condition = 2;
      else if (condition == 2)  condition = 3;
      else if (condition == 3)  condition = 4;
      else if (condition == 4)  condition = 0;
  }
  // left arrow
  if ((mouseX<width*0.05f)&&(mouseY>0)) {
      if (condition == 1)  condition = 0;
      else if (condition == 2)  condition = 1;
      else if (condition == 3)  condition = 2;
      else if (condition == 4)  condition = 3;
  }
}

public void loadData() {
  int cnt = 0;
  for(TableRow row : table.rows()) {
    //float[] rates = new rates[2011-1985+1];
    String country = row.getString("country");
    String rate_temp = row.getString("2011");
    float rate_2011 = 0;
    if (rate_temp.equals("..")) {
      rate_2011 = 0;
    } else {
      rate_2011 = PApplet.parseFloat(rate_temp);
    }
    
    Rate r = new Rate();
    r.country = country;
    r.rate_2011 = rate_2011;
    r.cnt = cnt;
    myRate.add(r);
    cnt++;
  }
}

public void loadEduData() {
  int cnt = 0;
  for(TableRow row : edu_table.rows()) {
    String country = row.getString("country");
    int math = PApplet.parseInt(row.getFloat("Mathematics"));

    Education e = new Education();
    e.country = country;
    e.math = math;
    e.cnt = cnt;
    myEdu.add(e);
    cnt++;
  }
}

public void loadNeetData() {
  int cnt = 0;
  for(TableRow row : neet_table.rows()) {
    String country = row.getString("country");
    int neet_rate = PApplet.parseInt(row.getFloat("neet"));

    Neet n = new Neet();
    n.country = country;
    n.neet_rate = neet_rate;
    n.cnt = cnt;
    myNeet.add(n);
    cnt++;
  }
}

public void loadSocialData() {
  int cnt = 0;
  for(TableRow row : social_table.rows()) {
    String country = row.getString("country");
    int rate = PApplet.parseInt(row.getFloat("2011"));

    Social s = new Social();
    s.country = country;
    s.rate = rate;
    s.cnt = cnt;
    mySocial.add(s);
    cnt++;
  }
}
class Economy {
  
  float[] gdp_capita = new float[2012-1960+1];
  String gdp_whole = "155.213586 91.62360601 103.8672749 142.3626527 120.63605 105.7698691 130.2648401 157.2902539 194.7795608 239.231464 278.7873797 302.2277793 322.7225528 403.4641509 555.6677296 608.2277798 824.423333 1041.586281 1382.921004 1746.730347 1674.387559 1845.65362 1938.112133 2117.529507 2306.860313 2367.782505 2702.641221 3367.542808 4465.670323 5438.252668 6153.093997 7122.701332 7555.272527 8219.896199 9525.43563 11467.81385 12249.17315 11234.777 7462.838645 9554.439443 11346.66499 10654.93555 12093.7573 13451.22942 15028.94015 17550.85389 19676.12418 21590.10558 19028.01293 16958.65239 20540.17693 22388.39597 22590.15648";
  String[] list = split(gdp_whole," ");
  
  float[] debt = {125.0f, 120.5f, 116.4f, 123.2f, 131.3f, 139.0f, 142.6f, 146.9f, 150.8f, 156.3f};
  int[] year = {2002, 2003, 2004, 2005, 2006, 2007, 2008, 2009, 2010, 2011};
  Economy() {
    getGdpData();
  }
  
  public void getGdpData() {
    for(int i = 0; i < list.length; i++) {
      gdp_capita[i] = PApplet.parseFloat(list[i]);
    }
  }
  
  public void display() {
    beginShape();
    noFill();
    strokeWeight(1);
    stroke(0, 0, 255,180);
    for(int i = 0; i < gdp_capita.length; i++) {
      pushMatrix();
        float h = map(gdp_capita[i],50, 22600, 0, height * 0.5f);
        vertex(width*0.1f + i*5, height*0.8f-h);
        
        if(dist(width*0.1f + i*5, height*0.8f-h, mouseX, mouseY) < 5) {
          fill(255, 200);
          textSize(15);
          text("$ " +gdp_capita[i], width*0.1f + i*5 + 5, height*0.8f-h);
          noFill();
        }

        //text(int(rate_2011), 0+15, -h+13);
      popMatrix();
    }
    endShape();
  }

public void displayNew() {
  beginShape();
    noFill();
    strokeWeight(1);
    stroke(0, 0, 255,180);
    for(int i = 0; i < debt.length; i++) {
      pushMatrix();
        float h = map(debt[i], 100, 160, 0, height * 0.5f);
        vertex(width*0.1f + i*30, height*0.8f-h);
        
        if(dist(width*0.1f + i*30, height*0.8f-h, mouseX, mouseY) < 5) {
          fill(255, 200);
          textSize(15);
          text(debt[i]+ " in "+year[i], width*0.1f + i*30 + 10, height*0.8f-h);
          noFill();
        }
      popMatrix();
    }
    endShape();
  }
}
class Education {
  String country;
  int math = 0;
  int cnt = 0;
  
  Education() {
    
  }
  
  public void display() {
    stroke(0);
    strokeWeight(7);
    //fill(100,200);
    pushMatrix();
      translate(width*0.4f, 0);
      translate((cnt)*8, height*0.8f);
      
      if(country.equals("KOR"))  fill(0, 255, 0, 180);
      else  fill(140, 140);
      
      float h = map(math, 350, 650, 0, height * 0.7f);
      rect(0, 0, 8, -h);

      if(dist(width*0.4f+(cnt)*8, height*0.8f, mouseX, mouseY) < 4) {
        fill(255);
        textSize(16);
        text(math+" in " + country, 13,0+10);// width*0.4+(cnt)*8, height*0.8 - h);
      }
      
    popMatrix();
  }
}
class Health {
  
  //float[] life_exp = {71.4, 76.0, 80.7};
  int[] life_exp = {71, 76, 81};
  int[] life_year = {1990, 2000, 2010};
  
  Health() {
    
  }
  
  public void display() {
    beginShape();
    noFill();
    strokeWeight(1);
    stroke(255, 0, 0,180);
    for(int i = 0; i < life_exp.length; i++) {
      pushMatrix();
        float h = map(life_exp[i],70, 82, 0, height * 0.5f);
        vertex(width*0.7f + i*90, height*0.8f-h);
        
        fill(255, 0, 0);
        ellipse(width*0.7f + i*90, height*0.8f-h,2,2);
        noFill();
        
        if(dist(width*0.7f + i*90, height*0.8f-h, mouseX, mouseY) < 5) {
          fill(255, 200);
          textSize(15);
          text(life_exp[i]+" in "+life_year[i], width*0.7f + i*90 + 15, height*0.8f-h);
          noFill();
        }

        //text(int(rate_2011), 0+15, -h+13);
      popMatrix();
    }
    endShape();
  }
}
class Neet {
  String country;
  int neet_rate = 0;
  int cnt = 0;
  
  Neet() {
    
  }
  
  public void display() {
    stroke(0);
    strokeWeight(7);
    //fill(100,200);
    pushMatrix();
      translate(width*0.4f, 0);
      translate((cnt)*8, height*0.8f);
      
      if(country.equals("Korea"))  fill(0, 255, 0, 180);
      else  fill(140, 140);
      
      float h = map(neet_rate, 5, 47, 0, height * 0.6f);
      rect(0, 0, 8, -h);

      if(dist(width*0.4f+(cnt)*8, height*0.8f, mouseX, mouseY) < 4) {
        fill(255);
        textSize(16);
        text(neet_rate+" in " + country, 13,0+10);// width*0.4+(cnt)*8, height*0.8 - h);
      }
      
    popMatrix();
  }
}
class Rate {
  
  String country;
  float rate_2011 = 0;
  int cnt = 0;
  int opac = 0;
  //float[] rates = new float[2011 - 1985 + 1]; // from 1985 to 2011 year
  
  Rate() {
    
  }
  
  public void display() {
    stroke(0);
    strokeWeight(6);
    fill(180, opac);
    pushMatrix();
      translate(width*0.1f, 0);
      translate((cnt)*70, height*0.9f);
      
      fill(150);
      textFont(myfont);
      textSize(11);
      text(country, 0+5, 0+10);
      
      if(country.equals("Korea"))  fill(255, 0, 0, opac);
      else  fill(180);
      
      float h = map(rate_2011, 0, 35, 0, height * 0.7f);
      rect(0, 0, 50, -h);
      fill(0);
      textSize(16);
      text(PApplet.parseInt(rate_2011), 0+15, -h+13);
    popMatrix();
    opac++;
    if(opac>220) opac = 220;
  }
  
}
class Social {
  String country;
  int rate = 0;
  int cnt = 0;
  
  Social () {
    
  }
  
  public void display() {
    stroke(0);
    strokeWeight(7);
    //fill(100,200);
    pushMatrix();
      translate(width*0.7f, 0);
      translate((cnt)*8, height*0.8f);
      
      if(country.equals("Korea"))  fill(255, 0, 0, 180);
      else  fill(140, 140);
      
      float h = map(rate,0, 11, 0, height * 0.55f);
      rect(0, 0, 8, -h);

      if(dist(width*0.7f+(cnt)*8, height*0.8f, mouseX, mouseY) < 4) {
        fill(255);
        textSize(16);
        text(rate+" in " + country, 13,0+10);// width*0.4+(cnt)*8, height*0.8 - h);
      }
      
    popMatrix();
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--full-screen", "--bgcolor=#666666", "--stop-color=#cccccc", "DataScience" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
