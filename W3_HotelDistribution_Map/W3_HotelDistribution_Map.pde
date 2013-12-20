/*
  "hotelsbase.csv data"
  - - - - - - 
0 id~  1 hotelName~  2 stars~  3 price~  4 cityName~  5 stateName~
6 countryCode~  7 countryName~  8 address~  9 location~  10 url~
11 tripadvisorUrl~  12 latitude~  13 longitude~  14 latlong~  15 propertyType~
16 chainId~  17 rooms~  18 facilities~  19 checkIn~  20 checkOut~  21 rating
*/

// unfolding maps
import processing.opengl.*;
import processing.core.PGraphics;
import codeanticode.glgraphics.*;
import de.fhpotsdam.unfolding.*;
import de.fhpotsdam.unfolding.geo.*;
import de.fhpotsdam.unfolding.geo.Location;
import de.fhpotsdam.unfolding.marker.*;
import de.fhpotsdam.unfolding.marker.SimplePointMarker;
import de.fhpotsdam.unfolding.utils.*;
import de.fhpotsdam.unfolding.utils.ScreenPosition;
import de.fhpotsdam.unfolding.providers.*;
import de.fhpotsdam.unfolding.providers.MapBox;
import de.fhpotsdam.unfolding.providers.MBTilesMapProvider; // add .jar file
import de.fhpotsdam.unfolding.providers.Microsoft;
import de.fhpotsdam.unfolding.providers.OpenStreetMap;
import de.fhpotsdam.unfolding.providers.StamenMapProvider;

UnfoldingMap map;
SimplePointMarker myMarker;
Location centerLocation = new Location(0, 0);
Location JapanLocation = new Location(36, 138);
Location KoreaLocation = new Location(38, 128);
Location MexicoLocation = new Location(23, -102);
Location USLocation = new Location(40, -100);
Location ChinaLocation = new Location(33, 100);
Location ThailandLocation = new Location(14, 101);
Location UKLocation = new Location(54, -2);
Location TanzaniaLocation = new Location(-7, 36);
Location FranceLocation = new Location(46.5, 3);

// reader
BufferedReader myReader;
PFont myFont;
PFont numFont;
PImage starImg;
PImage mapImg;
boolean mode = false;
ArrayList<Hotel> hotelList = new ArrayList();
boolean selectedHotel = false;

//float translate_x = width*0.63;
//float translate_y = height*0.5;
//float diameter = height*0.74;

/* 
 - - - - - Variables to Control - - - - - - - -
*/
//United States, Thailand, Mexico, China, Japan, South Korea, United Kindom, Tanzania, France
String selectedCountry = "Tanzania";
float maxPrice = 1000; 
int numBreak = 1; // higher number, less data to show (1 to 80)
int zoomLevel = 4;
/* 
 - - - - - - - - - - - - - - - - - - - - - - - 
*/

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
  //size(1280, 720, GLConstants.GLGRAPHICS);
  size(1280, 720);
  background(51);
  
  // map
  //map = new UnfoldingMap(this, new MapBox.ControlRoomProvider());
  //map = new UnfoldingMap(this, new Microsoft.RoadProvider());
  map = new UnfoldingMap(this, new Microsoft.AerialProvider());
  //map = new UnfoldingMap(this,new OpenStreetMap.OpenStreetMapProvider());
  //map = new UnfoldingMap(this, new StamenMapProvider.TonerBackground());
  MapUtils.createDefaultEventDispatcher(this, map);
  map.setTweening(true);
  selectZoomArea();
  map.zoomAndPanTo(centerLocation, zoomLevel);

  // reader
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
              if(cntTotal % numBreak == 0) {
                if(n==1 || n==2 || n ==3 || n==4 || n==5) {
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
  background(0); //51
  smooth();

  if(mode) map.draw();
  
  fill(0, 150);
  noStroke();
  rectMode(CORNER);
  rect(0,0,width,height);
  
  if(mode == false) displayStar();
  
  compareDist();

  for(Hotel h: hotelList) {
    if(mode) {
      //h.updateSlow();
      scatter();
      h.updateFast();
      h.render();
    } else { 
      h.updateFast();
      //displayStar();
      if(dist(h.pos.x,h.pos.y,h.tpos.x,h.tpos.y)< 2) {
        //displayStar();
        h.priceRender();
      }
      h.render();
    }
  }
  
  textFont(myFont);
  textAlign(LEFT, TOP);
  textSize(32);
  fill(11, 148, 190, 220);
  text("HOTEL PRICE vs STAR", width*0.1, height*0.12);
  
  textSize(64);
  text(selectedCountry, width*0.1, height*0.16);
}

void countStar() {
  star_1 = numStar_1;
  star_2 = numStar_2;
  star_3 = numStar_3;
  star_4 = numStar_4;
  star_5 = numStar_5;
}

void displayStar() {
  float minAngle = PI/25;
  float maxAngle = PI - PI/25;
  float minA = minAngle + PI;
  float maxA = maxAngle + PI;
  float translate_x2 = width*0.6;
  float translate_y2 = height*0.5;
  float d = height*0.74;
  float r = d/2;
  
  textAlign(CENTER);
  textSize(22);
  fill(255);
  
  pushMatrix();
    translate(translate_x2, translate_y2);
    noFill();
    stroke(180, 100);
    strokeWeight(2);
 
    float star_1_angle = map(star_1, 0, cnt, minA, maxA);
    float star_2_angle = map(star_2 + star_1, 0, cnt, minA, maxA);
    float star_3_angle = map(star_3 + star_2 + star_1, 0, cnt, minA, maxA);
    float star_4_angle = map(star_4 + star_3 + star_2 + star_1, 0, cnt, minA, maxA);
    float star_5_angle = map(star_5 + star_4 + star_3 + star_2 + star_1, 0, cnt, minA, maxA);
    
    strokeWeight(5);
    stroke(104, 162, 26);
    arc(0, 0, d, d, minA, star_1_angle);

    stroke(249, 176, 74);
    arc(0, 0, d, d, star_1_angle, star_2_angle);
    
    stroke(11, 148, 190);
    arc(0, 0, d, d, star_2_angle, star_3_angle);
    
    stroke(226, 41, 55);
    arc(0, 0, d, d, star_3_angle, star_4_angle);
    
    stroke(143, 101, 149);
    arc(0, 0, d, d, star_4_angle, star_5_angle);
    
    stroke(100, 100);
    strokeWeight(4);
    arc(0, 0, d, d, minAngle, maxAngle);
  popMatrix();
}

void scatter() {
  for(Hotel h:hotelList) {
    float tlat = h.lat;
    float tlon = h.lon;
    Location myLocation = new Location(tlat, tlon);
    myMarker = new SimplePointMarker(myLocation);
    ScreenPosition myPos = myMarker.getScreenPosition(map);
    h.tpos.x = myPos.x;
    h.tpos.y = myPos.y;
  }
}

void selectZoomArea() {
  if(selectedCountry.equals("Japan")) centerLocation = JapanLocation;
  if(selectedCountry.equals("South Korea")) centerLocation = KoreaLocation;
  if(selectedCountry.equals("Mexico")) centerLocation = MexicoLocation;
  if(selectedCountry.equals("United States")) centerLocation = USLocation;
  if(selectedCountry.equals("China")) centerLocation = ChinaLocation;
  if(selectedCountry.equals("Thailand")) centerLocation = ThailandLocation;
  if(selectedCountry.equals("United Kingdom")) centerLocation = UKLocation;
  if(selectedCountry.equals("Tanzania")) centerLocation = TanzaniaLocation;
  if(selectedCountry.equals("France")) centerLocation = FranceLocation;
}

void compareDist() {
  float maxDist = 10;
  int selectedI = -1;
  for(int i = 0; i < hotelList.size(); i++) {
    Hotel h = hotelList.get(i);
    h.selected = false;
    float distToMouse = dist(mouseX, mouseY, h.pos.x, h.pos.y);
    if(distToMouse < maxDist) {
      maxDist = distToMouse;
      selectedI = i;
      //selectedHotel = true;
    }
  }
  
  if(selectedI > -1) {
    Hotel h = hotelList.get(selectedI);
    h.selected = true; 
  }
}

void keyPressed() {
  if(key == 's') {
    scatter();
    mode = !mode;
    if(mode) map.zoomAndPanTo(centerLocation, zoomLevel);
    if(mode == false) {
      for(Hotel h:hotelList) {
        h.tpos.x = h.price_x + h.translate_x;
        h.tpos.y = h.price_y + h.translate_y;
      }
    }
  }
}
