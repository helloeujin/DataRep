/*
  "hotelsbase.csv data"
  - - - - - - 
0 id~  1 hotelName~  2 stars~  3 price~  4 cityName~  5 stateName~
6 countryCode~  7 countryName~  8 address~  9 location~  10 url~
11 tripadvisorUrl~  12 latitude~  13 longitude~  14 latlong~  15 propertyType~
16 chainId~  17 rooms~  18 facilities~  19 checkIn~  20 checkOut~  21 rating
*/

BufferedReader myReader;
IntDict countryDict = new IntDict();
IntDict priceDict = new IntDict();
IntDict starDict = new IntDict();
PFont myFont;
PFont numFont;
PImage starImg;
PImage mapImg;
boolean mode = false;

ArrayList<Hotel> hotelList = new ArrayList();
String selectedCountry = "Japan"; //United States, Thailand, Mexico, China, Japan, South Korea
float maxPrice = 800;
float gap = 100;
int cnt = 0;
int cntTotal = 0;

int star_1 = 0;
int star_2 = 0;
int star_3 = 0;
int star_4 = 0;
int star_5 = 0;

int numStar_1 = 0;
int numStar_2 = 0;
int numStar_3 = 0;
int numStar_4 = 0;
int numStar_5 = 0;

void setup() {
  size(int(1280*1.08), int(720*1.08));
  background(51);
  myReader = createReader("hotelsbase.csv"); 
  myFont = loadFont("Blanch-Caps-48.vlw");
  numFont = createFont("SansSerif-48.vlw", 48);
  starImg = loadImage("star.png");
  mapImg = loadImage("japan_map3.png");
  smooth();
  
  try {
    String ln;
    while( (ln = myReader.readLine ()) != null) {
      String[] cols = ln.split("~");
      if (cols.length > 20) {
        if(float(cols[3]) < maxPrice) {
          if(cols[7].equals(selectedCountry)) {
            if(cols[2].length() == 1) {
              int n = int(cols[2]);
              cntTotal++;
              if(cntTotal % 40 == 0) {
                if(n==1 || n==2 || n ==3 || n==4 || n==5) {
                  countryDict.increment(cols[7]);
                  priceDict.increment(cols[3]);
                  starDict.increment(cols[2]);
                  cnt++;
                  
                  // create a hotel object
                  Hotel h = new Hotel();
                  h.price = float(cols[3]);
                  h.country = cols[7];
                  h.star = int(cols[2]);
                  h.pos = new PVector(0,0);
                  h.hotelName = cols[1];
                  h.lon = float(cols[13]);
                  h.lat = float(cols[12]);
                  //println("lat, lon: " + cols[12] +", "+cols[13]);
                  
                  if(h.star == 1) h.numStar = numStar_1;
                  if(h.star == 2) h.numStar = numStar_2;
                  if(h.star == 3) h.numStar = numStar_3;
                  if(h.star == 4) h.numStar = numStar_4;
                  if(h.star == 5) h.numStar = numStar_5;
                  
                  if(h.star == 1) numStar_1++;
                  if(h.star == 2) numStar_2++;
                  if(h.star == 3) numStar_3++;
                  if(h.star == 4) numStar_4++;
                  if(h.star == 5) numStar_5++;            
                  h.tpos = new PVector(random(width), random(height));
                  
                  // put in arrayList
                  hotelList.add(h);
                }
              }
            }
          }
        }
      }
    }
  } catch(Exception e) {
    println("READER FAILED. " + e);
  }
  
  for(Hotel h:hotelList) {
    h.check();
  }
  countStar();
}

void draw() {
  background(255); //51
  
  
  if(mode) image(mapImg, 0,-40, width, height);
  fill(0, 180);
  rect(0, 0, width, height);
  
  for(Hotel h: hotelList) {
    if(mode) {
      //image(mapImg, 0, 0, width, height);
      
      //h.updateSlow();
      h.updateFast();
      h.render();
    } else { 
      //image(mapImg, 0, 0, width, height);
      h.updateFast();
      h.render();
      if(dist(h.pos.x,h.pos.y,h.tpos.x,h.tpos.y)< 2) {
        displayStar();
        h.priceRender();
      }
    }
  }
  displayInDict();
  
  textFont(myFont);
  textAlign(LEFT, TOP);
  textSize(32);
  //fill(192);
  fill(11, 148, 190, 220);
  text("HOTEL PRICE vs STAR", width*0.1, height*0.12);
  
  textSize(64);
  text(selectedCountry, width*0.1, height*0.16);
}

void displayInDict() {
//    String[] keys = starDict.keyArray();
//    for(int i = 0; i < keys.length; i++) {
//      stroke(255);
//      fill(255);
//      float x = map(i, 0, keys.length, width*0.1, width*0.9);
//      float y = map(starDict.get(keys[i]),0, max(starDict.valueArray()),0,height*0.8);
//      //line(x, height*0.9,x,height*0.9-y);
//      //text(keys[i], x, height*0.9);
//      //println(keys[i] + ": "+ starDict.get(keys[i]));
//    }
}

void countStar() {
  String[] keys = starDict.keyArray();
  for(int i = 0; i < keys.length; i++) {
    if(keys[i].equals("1")) star_1 = starDict.get(keys[i]);
    if(keys[i].equals("2")) star_2 = starDict.get(keys[i]);
    if(keys[i].equals("3")) star_3 = starDict.get(keys[i]);
    if(keys[i].equals("4")) star_4 = starDict.get(keys[i]);
    if(keys[i].equals("5")) star_5 = starDict.get(keys[i]);
  }
}

void displayStar() {
  float minAngle = PI/25;
  float maxAngle = PI - PI/25;
  float minA = minAngle + PI;
  float maxA = maxAngle + PI;
  
  pushMatrix();
    float translate_x = width*0.63;
    float translate_y = height*0.53;
    float diameter = height*0.74;
    
    translate(translate_x, translate_y);
    noFill();
    stroke(180, 100);
    strokeWeight(2);
 
    float star_1_angle = map(star_1, 0, cnt, minA, maxA);
    float star_2_angle = map(star_2 + star_1, 0, cnt, minA, maxA);
    float star_3_angle = map(star_3 + star_2 + star_1, 0, cnt, minA, maxA);
    float star_4_angle = map(star_4 + star_3 + star_2 + star_1, 0, cnt, minA, maxA);
    float star_5_angle = map(star_5 + star_4 + star_3 + star_2 + star_1, 0, cnt, minA, maxA);
    
    strokeWeight(8);
    stroke(104, 162, 26);
    arc(0, 0, diameter, diameter, minA, star_1_angle);
    
    stroke(249, 176, 74);
    arc(0, 0, diameter, diameter, star_1_angle, star_2_angle);
    
    stroke(11, 148, 190);
    arc(0, 0, diameter, diameter, star_2_angle, star_3_angle);
    
    stroke(226, 41, 55);
    arc(0, 0, diameter, diameter, star_3_angle, star_4_angle);
    
    stroke(143, 101, 149);
    arc(0, 0, diameter, diameter, star_4_angle, star_5_angle);
  popMatrix();
}

void scatter() {
  // lon range (121.55, 153.28)
  // lat range (29.08, 46.01)
  for(Hotel h:hotelList) {
    //h.tpos = new PVector(random(width), random(height));
//    float x = map(h.lon, -180, 180, 0, width);
//    float y = map(h.lat, -90, 90, height,0);
    float x = map(h.lon, 106.7, 164.36, 0, width);
    float y = map(h.lat, 20.68, 50.12, height, 0);
    h.tpos = new PVector(x, y);
  }
}

void keyPressed() {
  if(key == 's') {
    scatter();
    mode = !mode;
    if(mode == false) {
      for(Hotel h:hotelList) {
        h.tpos.x = h.price_x + h.translate_x;
        h.tpos.y = h.price_y + h.translate_y;
      }
    }
  }
}
