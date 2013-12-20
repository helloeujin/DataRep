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

void setup() {
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

void draw() {
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

void firstScreen() {
  fill(220, 180);
  textFont(myfont);
  textAlign(LEFT, CENTER);
  textSize(58);
  text("SOUTH KOREA", width*0.1, height*0.5);
  fill(0, 0, 255, opacity);
  text(" SUICIDE CAPITAL", width*0.4, height*0.5);
  opacity++;
  if (opacity > 180) opacity = 180;
}

void suicideTotal() {
  fill(220, 180);
  textFont(myfont);
  textSize(46);
  text("SUICIDE RATE 2011", width*0.1, height*0.1);
  
  textSize(18);
  fill(120);
  text("deaths per 100,000", width*0.15, height*0.25);
  
  for (Rate r: myRate) {
    if(r.rate_2011 > 0)  r.display();
  }
}

void whatWeKnow() {
  fill(220, 180);
  textFont(myfont);
  textSize(46);
  text("WHAT WE KNOW ABOUT S.KOREA", width*0.1, height*0.1);
  
  textSize(28);
  text("HIGH ECONOMIC GROWTH", width*0.1, height*0.85);
  text("GOOD EDUCATION", width*0.4, height*0.85);
  text("IMPROVED HEALTH", width*0.7, height*0.85);
  
  textSize(14);
  fill(150, 140);
  text("GDP PER CAPITA", width*0.1, height*0.85 +35);
  text("PISA PERFORMANCE", width*0.4, height*0.85+35);
  text("LIFE EXPECTANCY", width*0.7, height*0.85+35);
  
  myEconomy.display();
  myHealth.display();
  for (Education e: myEdu) {
    e.display();
  }
}

void whatWeNeedToKnow() {
  fill(220, 180);
  textFont(myfont);
  textSize(46);
  text("WHAT WE NEED TO KNOW ABOUT S.KOREA", width*0.1, height*0.1);
  
  fill(0, 0, 255, 180);
  text("NEED TO", width*0.2467, height*0.1);
  
  fill(220, 180);
  textSize(28);
  text("FINANCIAL VULNERABILITY", width*0.1, height*0.85);
  text("YOUTH INACTIVITY", width*0.4, height*0.85);
  text("LACK OF SOCIAL SUPPORT", width*0.7, height*0.85);
  
  textSize(14);
  fill(150, 140);
  text("HOUSEHOLD DEBT", width*0.1, height*0.85 +35);
  text("NEET POPULATION", width*0.4, height*0.85+35);
  text("SOCAIL EXPENDITURE", width*0.7, height*0.85+35);
  
  myEconomy.displayNew();
//  myHealth.display();
  for (Neet n: myNeet) {
    n.display();
  }
  for (Social s: mySocial) {
    s.display(); 
  }
}

void conclusion() {
  fill(220, 180);
  textFont(myfont);
  textSize(46);
  text("People in South Korea", width*0.1, height*0.3);
  text("at risk of being socially excluded", width*0.1, height*0.4);
  fill(0, 0, 255, opacity2);
  text("They don’t have a place to go",width*0.1, height*0.6);
  opacity2++;
  if(opacity2 > 180)  opacity2 = 180;
}

void checkMouse() {
  // right arrow
  if ((mouseX>width*0.95)&&(mouseY>0)) {
    fill(255, 40);
    noStroke();
    rect(width*0.95, 0, width*0.1, height);
  }
  // left arrow
  if ((mouseX<width*0.05)&&(mouseY>0)) {
    fill(255, 40);
    noStroke();
    if (condition != 0)  rect(0, 0, width*0.05, height);
  }
}

void mouseClicked() {
  // right arrow
  if ((mouseX>width*0.95)&&(mouseY>0)) {
      if (condition == 0)  condition = 1;
      else if (condition == 1)  condition = 2;
      else if (condition == 2)  condition = 3;
      else if (condition == 3)  condition = 4;
      else if (condition == 4)  condition = 0;
  }
  // left arrow
  if ((mouseX<width*0.05)&&(mouseY>0)) {
      if (condition == 1)  condition = 0;
      else if (condition == 2)  condition = 1;
      else if (condition == 3)  condition = 2;
      else if (condition == 4)  condition = 3;
  }
}

void loadData() {
  int cnt = 0;
  for(TableRow row : table.rows()) {
    //float[] rates = new rates[2011-1985+1];
    String country = row.getString("country");
    String rate_temp = row.getString("2011");
    float rate_2011 = 0;
    if (rate_temp.equals("..")) {
      rate_2011 = 0;
    } else {
      rate_2011 = float(rate_temp);
    }
    
    Rate r = new Rate();
    r.country = country;
    r.rate_2011 = rate_2011;
    r.cnt = cnt;
    myRate.add(r);
    cnt++;
  }
}

void loadEduData() {
  int cnt = 0;
  for(TableRow row : edu_table.rows()) {
    String country = row.getString("country");
    int math = int(row.getFloat("Mathematics"));

    Education e = new Education();
    e.country = country;
    e.math = math;
    e.cnt = cnt;
    myEdu.add(e);
    cnt++;
  }
}

void loadNeetData() {
  int cnt = 0;
  for(TableRow row : neet_table.rows()) {
    String country = row.getString("country");
    int neet_rate = int(row.getFloat("neet"));

    Neet n = new Neet();
    n.country = country;
    n.neet_rate = neet_rate;
    n.cnt = cnt;
    myNeet.add(n);
    cnt++;
  }
}

void loadSocialData() {
  int cnt = 0;
  for(TableRow row : social_table.rows()) {
    String country = row.getString("country");
    int rate = int(row.getFloat("2011"));

    Social s = new Social();
    s.country = country;
    s.rate = rate;
    s.cnt = cnt;
    mySocial.add(s);
    cnt++;
  }
}
