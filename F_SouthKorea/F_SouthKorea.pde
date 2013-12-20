/*
  Data Rep final project
  Suicide rate in South Korea
*/

PFont myfont;
int condition = 0;
float opacity = 0;
int cnt = 0;
color cr;

ArrayList<Indicators> indicsList = new ArrayList();
ArrayList<Country> countryList = new ArrayList();
Arrow myArrow = new Arrow();
Table countryTable;

void setup() {
  //size(1280, 720, P3D);
  size(displayWidth, displayHeight, P3D);
  background(0);
  myfont = loadFont("Blanch-Caps-48.vlw"); //"Blanch-Caps-48.vlw" "OpenSans-48.vlw"
  condition = 0;
  
  // load table
  countryTable = loadTable("suicideRate.csv", "header");
  loadCountryData();
  
  for(int i = 0; i < 15; i++) {
    Indicators id = new Indicators();
    id.labelSelected = id.label[i];
    id.tpos = new PVector(random(width), random(height), 0);
    indicsList.add(id);
  }
  myArrow.pos.x = 50;
  myArrow.pos.y = height*0.9;
  myArrow.tpos.x = map(24, 0, 26-1, 50, width-50);
  myArrow.tpos.y = height*0.9;
}

void draw() { 
  textAlign(LEFT, CENTER);
  background(0);
  if(condition == 0) firstScreen();
  if(condition == 1) guessWhat();
}

void guessWhat() {
  textAlign(CENTER, CENTER);
  textSize(20);
  fill(100);
  for(Indicators id:indicsList) {
    id.update();
    id.render();
  }
  opacity++;
  if(opacity > 230) opacity = 230;
  fill(220,opacity);
  
  textSize(68);
  text("GUESS WHAT IT IS ABOUT?", width*0.5, height*0.5);
}

void firstScreen() {
  cnt++;
  displayGuideLine();
  displayLine("United States");
  if(cnt > 100)  displayLine("Japan");
  if(cnt > 200)  displayLine("South Korea");
  if(cnt > 350)  {
    opacity++;
    if(opacity > 255) opacity = 255;
    displayGuideText();
  }
  if(cnt > 600 && cnt <= 700) myArrow.render();
  if(cnt > 700) displayArrow();
}

void displayLine(String name) {
  for(Country c:countryList) {
    if(c.countryName.equals(name)) {
      c.update();
      if(name.equals("South Korea")) c.renderGraphFill();
      else c.renderGraph();
      cr = c.cr;
    }
  }
}

void displayGuideLine() {
  stroke(140);
  strokeWeight(2);
  for(int i = 0; i < 26; i++) {
    float x = map(i, 0, 26-1, 50, width-50);
    float y = height*0.9;
    line(x, y, x, y + 10);
  }
}
void displayGuideText() {
  textSize(20);
  fill(180, opacity);
  for(int i = 0; i < 26; i++) {
    float x = map(i, 0, 26-1, 50, width-50);
    float y = height*0.9;
    text(i+1985, x-10, y+24);
  }
  fill(0, opacity);
  noStroke();
  rect(0, 0, 300, 200);
  
  fill(120, opacity);
  textSize(52);
  text("SUICIDE RATES", 50, height*0.1);
  textSize(30);
  text("(per 100,000)", 50, height*0.15);
  
  for(Country c:countryList) {
    c.displayName2(opacity);
  } 
}

void displayArrow() {
  if(cnt > 1200) {
    myArrow.tpos.y = map(33.8, 0, 44, height*0.9,0);
    myArrow.displayNum();
  }
  myArrow.update();
  myArrow.render();
}

void loadCountryData() {
  for(TableRow row : countryTable.rows()) {
    Country c = new Country();
    String countryName = row.getString("Country");
    c.countryName = countryName;
    for(int i = 0; i<26; i++) {
      String year = Integer.toString(i + 1985);
      float suicideRate = row.getFloat(year);
      c.years[i] = i + 1985;
      c.suicideRate[i] = suicideRate;
    }
    if(countryName.equals("South Korea")) {
      c.cr = color(#FF9900);
      c.pos.x = 50;
      c.pos.y = height*0.2;
      c.tpos = c.pos;
    }
    if(countryName.equals("Japan")) {
      c.cr = color(180);
      c.pos.x = 50;
      c.pos.y = height*0.15;
      c.tpos = c.pos;
    }
    if(countryName.equals("United States")) {
      c.cr = color(120);
      c.pos.x = 50;
      c.pos.y = height*0.1;
      c.tpos = c.pos;
    }
    c.addElements();
    countryList.add(c);
  }
}
