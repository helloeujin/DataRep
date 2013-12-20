PFont myfont;
int condition = 0;
int num = 26;
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
ArrayList<Article> articleList = new ArrayList();
ArrayList<Axis> axisList = new ArrayList();
Icon arrowIcon = new Icon();
Icon arrowIcon2 = new Icon();
PVector mpos = new PVector();
boolean clicked = false;
boolean clicked2 = false;
int clickedNum = 0;
float tx = 0;

void setup() {
  //size(1280, 720, P3D);
  size(displayWidth, displayHeight, P3D);
  myfont = loadFont("Blanch-Caps-48.vlw");
  
  countryTable = loadTable("suicideRate.csv", "header");
  indicTable = loadTable("indicData.csv", "header");
  currentTable = loadTable("currentRate.csv", "header");
  loadCountryData();
  loadIndicData();
  loadCurrentData();
  arrowIcon.pos.set(width*0.2 + 350, height*0.5); // (width*0.1 + 770, height*0.5);
  
  tx = map(0.5, 0, 8, 50, width-50);
  arrowIcon2.pos.set(tx, height*0.52); 
  arrowIcon2.tpos = arrowIcon2.pos;
  axisInit();
  articleInit();
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
  fill(160);
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
  
  if(cnt2 > 200 && cnt2 <= 250) {
    for(Current c:currentList) {
      c.showUnit();
    }
  } else if(cnt2 > 250 && cnt2 < 350) {
    for(Current c:currentList) {
      c.showUnit2();
    }
  }
  
  if(cnt2 > 300) {
    if(clicked2) {
      arrowIcon2.update();
      arrowIcon2.displayArrow2();
    }
    //arrowIcon2.checkClicked();
    
    for(int i = 0; i < articleList.size(); i++) {
      Article ar = new Article();
      ar = articleList.get(i);
      ar.checkClicked();
      if(ar.clicked) {
        clicked2 = true;
        clickedNum = i;
        //ar.render();
        arrowIcon2.tpos.x = ar.pos.x;
        ar.clicked = false;
      }
      
      if(clicked2) {
        if(clickedNum == i) {
          ar.showArticle();
        }
      }
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
  fill(170, 255-opacity);
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
        /*
        if(syear >= 2009) {
          syear = 2009;
          cr.subUpdate();
          cr.subcRender();
        } else {
        
          cr.subUpdate(syear);
          cr.subRender(syear);
        }
        */
        cr.subUpdate(syear);
          cr.subRender(syear);
        cr.update(syear);
        cr.renderGraph(syear, opac);
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
      //c.pos.x = 50;
      //c.pos.y = height*0.2;
      //c.tpos = c.pos;
    }
    if(countryName.equals("Japan")) {
      c.cr = color(#04376C, 220);
      //c.pos.x = 50;
      //c.pos.y = height*0.15;
      //c.tpos = c.pos;
    }
    if(countryName.equals("United States")) {
      c.cr = color(120);
      //c.pos.x = 50;
      //c.pos.y = height*0.1;
      //c.tpos = c.pos;
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

void articleInit() {
  for(int i = 0; i < 8; i++) {
    float x = map(i, 0, 8, 50, width-50) + tx - 50;
    Article ar = new Article();
    ar.pos.set(x, height*0.62);
    ar.tpos.set(x, height*0.62);
    ar.num = i;
    if(i == 0) {
      ar.stat = 81;
      ar.st = "Due to her parents' divorce, 10 year old girl commits suicide 2009.04.08";
    }
    else if(i == 1) {
      ar.stat = 1009;
      ar.st = "After his teacher punished him 110 times, high school student commits suicide 2009.05.02";
    }
    else if(i == 2) {
      ar.stat = 2382;
      ar.st = "Storm in South Korea over Jang Ja-yeon's suicide 2009.03.07";
    }
    else if(i == 3) {
      ar.stat = 2768;
      ar.st = "Suicide is the number one reason for deaths";
    }
    else if(i == 4) {
      ar.stat = 3060;
      ar.st = "record the most suicide rates after the Subprime mortgage crisis";
    }
    else if(i == 5) {
      ar.stat = 2032;
      ar.st = "Former S. Korean President Roh commits suicide. He was 62.";
    }
    else if(i == 6) {
      ar.stat = 2145;
      ar.st = "elderly suicide rates increase evey year";
    }
    else if(i == 7) {
      ar.stat = 1926;
      ar.st = "Korea, Highest in Elderly Poverty: OECD";
    }
    articleList.add(ar);
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
