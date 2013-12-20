float[] numbers;
ArrayList<Kids> kidsList = new ArrayList();
ArrayList<Sonifier> sonList = new ArrayList();
int num = 0;
PFont myFont;

void setup() {
  size(1280,720,P3D);
  background(241, 229, 203);
  smooth(4);
  frameRate(200);
  myFont = createFont("Blanch-Condensed-48.vlw", 48);
 
  loadCSV("happyKids.csv");
  numbers = new float[5];
  for(int i = 0; i < kidsList.size(); i++) {
    Kids k = new Kids();
    k = kidsList.get(i);
    
    Sonifier s = new Sonifier();
    s.num_0 = k.fruit;
    s.num_1 = k.breakfast;
    s.num_2 = k.exercise;
    s.num_3 = k.lifeSatisfaction;
    s.num_4 = k.likeSchool;
    
    s.country = k.country;
    s.init_start();
    //s.init(0,3000,100);
    s.init(-3000,3000,100);
    //s.start();
    sonList.add(s);
  }
}

void draw() {
  background(241, 229, 203);
  displayLine();
  
  for(int i = 0; i < sonList.size(); i++) {
    Sonifier s = new Sonifier();
    s = sonList.get(i);
    float h = map(i, 0, sonList.size()-1, height*0.10, height*0.9);

    if(mouseX>width*0.1 && mouseX<width*0.2 && mouseY<h && mouseY>h-20) {
      //fill(252, 37, 70, 180);
      fill(0, 238, 217, 180);
      noStroke();
      rect(width*0.1, h-15, width*0.09, 20);
      noFill();
      s.start();
      s.render();
      fill(80);
    } else {
      fill(120);
      s.stop();
    }
    //fill(120);
    textFont(myFont);
    textSize(12);
    text(s.country, width*0.1, h);
  }
  stroke(20);
  strokeWeight(0.4);
  line(width*0.1, height*0.07, width*0.9, height*0.07);
  line(width*0.1, height*0.07, width*0.9, height*0.07);
  
  fill(70);
  textSize(24);
  text("How happy are our kids?", width*0.665, height*0.12);
  
  stroke(100);
  strokeWeight(0.4);
  for(int i = 0; i < 5; i++) {
    float h = map(i, 0, 4, height*0.4, height*0.9);
    if(i == 4) stroke(40);
    line(width*0.2, h, width*0.9, h);
    
  } 
}

void displayLine() {
//  stroke(100);
//  strokeWeight(0.4);
//  for(int i = 0; i < 5; i++) {
//    float h = map(i, 0, 4, height*0.4, height*0.9);
//    if(i == 4) stroke(40);
//    line(width*0.2, h, width*0.9, h);
//    
//  } 
}

void loadCSV(String url) {
  Table kidTable = loadTable(url, "header");
  for(int i = 0; i < kidTable.getRowCount(); i++) {
    TableRow r = kidTable.getRow(i);
    Kids k = new Kids();
    k.country = r.getString("Country");
    k.fruit = r.getFloat("fruit");
    k.breakfast = r.getFloat("breakfast");
    k.exercise = r.getFloat("exercise");
    k.lifeSatisfaction = r.getFloat("lifeSatisfaction");
    k.likeSchool = r.getFloat("likeSchool");
    kidsList.add(k);
  }
}
