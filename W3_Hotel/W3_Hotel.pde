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

ArrayList <Hotel> hotelList = new ArrayList();
String selectedCountry = "South Korea";//United States, Thailand, Mexico, China, Japan, South Korea
float maxPrice = 500;
float gap = 100;
int cnt = 0;

void setup() {
  size(1280, 720);
  background(51);
  myReader = createReader("hotelsbase.csv"); 
  myFont = loadFont("Blanch-Caps-48.vlw");
  numFont = createFont("SansSerif-48.vlw", 48);
  starImg = loadImage("star.png");
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
                h.tpos = new PVector(random(width), random(height));
                
                // put in arrayList
                hotelList.add(h);
              }
            }
          }
        }
      }
    }
   println(cnt);
    
  } catch(Exception e) {
    println("READER FAILED. " + e);
  }
}

void draw() {
  background(51);
  for(Hotel h: hotelList) {
    h.priceRender();
  }
  
  textFont(myFont);
  textAlign(LEFT, TOP);
  textSize(30);
  fill(192);
  text("HOTEL PRICE vs STAR", width*0.1, height*0.1);
  
  textSize(60);
  text(selectedCountry, width*0.1, height*0.15);
  
  String[] keys = starDict.keyArray();
    for(int i = 0; i < keys.length; i++) {
      float y = map(int(keys[i]), 0, keys.length, height*0.3, height*0.8);
      float wid = map(starDict.get(keys[i]),0, max(starDict.valueArray()),0,width*0.3);
      
      // select color for line
      if(int(keys[i]) == 1)  stroke(109, 164, 190);
      else if(int(keys[i]) == 2) stroke(141,178, 203);
      else if(int(keys[i]) == 3) stroke(56, 173, 119);//stroke(181);
      else if(int(keys[i]) == 4) stroke(197, 146, 158);
      else if(int(keys[i]) == 5) stroke(193, 70, 93);
      
      strokeWeight(5);
      line(width*0.1, y, width*0.1 + wid, y);
      
      for(int j = 0; j < int(keys[i]); j++) {
        displayStar(width*0.1+j*18+8, y+18, 7, 12, 5);
      }
    }
}

void displayStar(float x, float y, float radius1, float radius2, int npoints) {
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  noFill();
  strokeWeight(1);
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void displayInDict() {
  //    for(Hotel h: hotelList) {
//      h.priceRender();
//    }
//    println(max(priceDict.valueArray())); //4807
//    println(priceDict);
//    println(max(countryDict.valueArray()));
//    println(countryDict);
//    println(max(starDict.valueArray()));
//    println(starDict);
    
//    String[] keys = priceDict.keyArray();
//    for(int i = 0; i < keys.length; i++) {
//      stroke(255);
//      fill(255);
//      float x = map(float(keys[i]), 0, maxPrice, width*0.1, width*0.9);
//      float y = map(priceDict.get(keys[i]),0, max(priceDict.valueArray()),0,height*0.8);
//      line(x, height*0.9,x,height*0.9-y);
//    }

//    String[] keys = countryDict.keyArray();
//    for(int i = 0; i < keys.length; i++) {
//      stroke(255);
//      fill(255);
//      float x = map(i, 0, keys.length, width*0.1, width*0.9);
//      float y = map(countryDict.get(keys[i]),0, max(countryDict.valueArray()),0,height*0.8);
//      line(x, height*0.9,x,height*0.9-y);
//      println(x+", "+ y);
//      //text(keys[i], x, random(0, height));
//    }

//    String[] keys = starDict.keyArray();
//    for(int i = 0; i < keys.length; i++) {
//      stroke(255);
//      fill(255);
//      float x = map(i, 0, keys.length, width*0.1, width*0.9);
//      float y = map(starDict.get(keys[i]),0, max(starDict.valueArray()),0,height*0.8);
//      line(x, height*0.9,x,height*0.9-y);
//      text(keys[i], x, height*0.9);
//    }
}
