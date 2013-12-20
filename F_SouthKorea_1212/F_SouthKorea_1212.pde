PFont myfont;
int condition = 0;
int num = 25;
int cnt = 0;
int cnt2 = 0;
int syear = 1985;
float opacity = 255;
float opacity2 = 0;
Table countryTable;
Table indicTable;
Table currentTable;

ArrayList<Country> countryList = new ArrayList();
ArrayList<Indicator> indicList = new ArrayList();
ArrayList<Current> currentList = new ArrayList();
ArrayList<Axis> axisList = new ArrayList();
Icon arrowIcon = new Icon();
PVector mpos = new PVector();
boolean clicked = false;

void setup() {
  size(1280, 720, P3D);
  //size(displayWidth, displayHeight, P3D);
  myfont = loadFont("Blanch-Caps-48.vlw");
  
  countryTable = loadTable("suicideRate.csv", "header");
  indicTable = loadTable("indicData.csv", "header");
  currentTable = loadTable("currentRate.csv", "header");
  loadCountryData();
  loadIndicData();
  loadCurrentData();
  arrowIcon.pos.set(width*0.2 + 350, height*0.5); // (width*0.1 + 770, height*0.5);
  axisInit();
}

void draw() {
  background(0);
  textAlign(LEFT, CENTER);
  mpos.set(mouseX, mouseY);
  if(condition == 0) startScreen();
  else if(condition == 1) correctAnswer();
  else if(condition == 2) emotionViz();
}

void emotionViz() {
  fill(180);
  textFont(myfont);
  textSize(48);
  text("Suicide rate in South Korea", 50, height*0.1);
  
  opacity2++;
  if(opacity2 > 200) opacity2 = 200;
  fill(#FF9900, opacity2);
  text(2009, 400, height*0.1);
  
  for(Current c:currentList) {
    c.subUpdate();
    c.subRender();
    if(cnt2 > 120) c.axisRender();
  }
  
  cnt2++;
  if(cnt2 == 120) {
    for(Current c:currentList) {
      c.setpos();
    }
  }
  
  if(cnt2 > 200) {
    for(Current c:currentList) {
      c.showStory();
    }
  }
}

void correctAnswer() {
  int addcnt = 300;
  cnt++;
  opacity = opacity-2;
  if(opacity < 0) opacity = 0;
  
  textFont(myfont);
  textSize(48);
  fill(200, 255-opacity);
  String st_3 = "Suicide rate in South Korea";
  text(st_3, 50, height*0.1);
  float opac = opacity;
  if(opac < 210) opac = 210;
  
  for(Country cr:countryList) {
    if(cr.countryName.equals("South Korea"))  {
      cr.update();
      cr.renderGraph(opac);
      
      if(cnt > 80 + addcnt) {
        if(cnt == 80+80+ addcnt) syear++; // 1986
        else if(cnt == 80+70+60+50+ addcnt) syear++; 
        else if(cnt == 80+70+60+50+40+ addcnt) syear++; 
        else if(cnt == 80+70+60+50+40+40+ addcnt) syear++; 
        else if(cnt > 80+70+60+50+40+40+ addcnt) {
          if(cnt%10 == 0) syear++;
        }
        if(syear >= 2009) {
          syear = 2009;
          cr.subUpdate();
          cr.subcRender();
        } else {
        
          cr.subUpdate(syear);
          cr.subRender(syear);
        }
        
        //cr.update(syear);
        //cr.renderGraph(syear, opac);
      }    
      cr.showInfo(syear);
      cr.checkClicked();
      if(cr.clicked) condition = 2; //3
      
    } else {
      if(cnt > 200) {
        cr.update();
        cr.renderGraph(opac);
        cr.displayName(opac);
      }
    }
  }
  
  // X axis
  for(Axis ax:axisList) {
    ax.update();
    ax.render();
  }
  // Y axis
  if(cnt > 10) {
    for(Indicator id:indicList) {
      if(id.indicName.equals("Suicide Rate")) {
        id.displayAxis(opac);
        id.displayUnit2();
      }
    }
  }
}

void startScreen() {
  fill(180);
  textFont(myfont);
  textSize(58); //48
  String st_1 = "The True South Korea";
  text(st_1, width*0.2, height*0.5);
  arrowIcon.displayArrow();
  arrowIcon.checkClicked();
  
  if(arrowIcon.clicked) {
    condition = 1;
    arrowIcon.clicked = false;
    arrowIcon.pos.set(400 - 38, height*0.4 - 10); 
    arrowIcon.tpos.set(400 - 38, height*0.4 - 10); 
  }
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
      c.cr = color(#04376C, 220);
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
    c.addInfo();
    countryList.add(c);
  }
}

void loadIndicData() {
    int icnt = 0;
    for(TableRow row : indicTable.rows()) {
      Indicator id = new Indicator();
      id.indicName = row.getString("Indicator");
      id.reference = row.getString("reference");
      id.unit = "("+ row.getString("unit") +")";
      for(int i = 0; i<num; i++) {
        String year = Integer.toString(i + 1985);
        float data = row.getFloat(year);
        id.years[i] = i + 1985;
        id.data[i] = data;
      }
      id.pos.set(random(width), -10);
      //id.tpos.set(400 + icnt*100, height*0.4); 
      id.tpos.set(400, height*0.4);      
      id.addElements();
      indicList.add(id);
      icnt++;
    }
}

void loadCurrentData() {
  for(TableRow row : currentTable.rows()) {
    String name = row.getString("age");
    if(name.equals("total")) {
      Current c = new Current();
      c.total = row.getInt("5_14");
      c.num = 0;
      c.addElements();
      currentList.add(c);
    }
  }
  for(TableRow row : currentTable.rows()) {
    String name = row.getString("age");
    if(name.equals("total")) {
      Current c = new Current();
      c.total = row.getInt("15_24");
      c.num = 1;
      c.addElements();
      currentList.add(c);
    }
  }
  for(TableRow row : currentTable.rows()) {
    String name = row.getString("age");
    if(name.equals("total")) {
      Current c = new Current();
      c.total = row.getInt("25_34");
      c.num = 2;
      c.addElements();
      currentList.add(c);
    }
  }
  for(TableRow row : currentTable.rows()) {
    String name = row.getString("age");
    if(name.equals("total")) {
      Current c = new Current();
      c.total = row.getInt("35_44");
      c.num = 3;
      c.addElements();
      currentList.add(c);
    }
  }
  for(TableRow row : currentTable.rows()) {
    String name = row.getString("age");
    if(name.equals("total")) {
      Current c = new Current();
      c.total = row.getInt("45_54");
      c.num = 4;
      c.addElements();
      currentList.add(c);
    }
  }
  for(TableRow row : currentTable.rows()) {
    String name = row.getString("age");
    if(name.equals("total")) {
      Current c = new Current();
      c.total = row.getInt("55_64");
      c.num = 5;
      c.addElements();
      currentList.add(c);
    }
  }
  for(TableRow row : currentTable.rows()) {
    String name = row.getString("age");
    if(name.equals("total")) {
      Current c = new Current();
      c.total = row.getInt("65_74");
      c.num = 6;
      c.addElements();
      currentList.add(c);
    }
  }
  for(TableRow row : currentTable.rows()) {
    String name = row.getString("age");
    if(name.equals("total")) {
      Current c = new Current();
      c.total = row.getInt("75");
      c.num = 7;
      c.addElements();
      currentList.add(c);
    }
  }
  
  for(Current c:currentList) {
    c.axisInit();
  }
}

void axisInit() {
  for(int i = 0; i < num; i++) {
    float x = map(i, 0, num-1, 50, width-50);
    Axis ax = new Axis();
    ax.pos.set(0, height*0.9);
    ax.tpos.set(x, height*0.9);
    ax.year = i + 1985;
    axisList.add(ax);
  }
}
