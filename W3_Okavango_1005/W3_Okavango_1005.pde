/*

geoInfo.txt => g.dateTime+","+g.person+","+g.lon+","+g.lat;
hrInfo.txt  => h.dateTime+","+h.person+","+h.hr+","+h.temp+","+h.energy;

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

ArrayList <Geo> myGeo = new ArrayList();
ArrayList <HeartRate> myHr = new ArrayList();
String[] geoInfo;
String[] hrInfo;
PVector pos = new PVector(); // location 
PVector tpos = new PVector(); // location

int sel_h = 0;
int sel_mi = 0;
int sel_s = 0;
float sel_lon = 0;
float sel_lat = 0;
float sel_x = 0;
float sel_y = 0;
float sel_hr = 0;

PFont myFont;
PImage myImg;

// for map
UnfoldingMap map;
SimplePointMarker myMarker;
Location okavango = new Location(-19.017923, 22.345266);  // lat lon
Location mappos = new Location(-19.017923, 22.345266);

void setup() {
  size(1280, 720);
  background(0);
  myFont = loadFont("HelveticaNeue-48.vlw");
  myImg = loadImage("heart_icon2.png");
  
  // map
  map = new UnfoldingMap(this, new Microsoft.AerialProvider());
  MapUtils.createDefaultEventDispatcher(this, map);
  map.setTweening(true);
  map.zoomAndPanTo(okavango, 16);
  map.draw();
  pos.x = 22.345266;
  pos.y = -19.017923;
  tpos.x = 22.345266;
  tpos.y = -19.017923;
  // data
  geoInfo = loadStrings("geoInfo.txt");
  hrInfo = loadStrings("hrInfo.txt");
  loadData();
  hrStats();
}

void draw() {
  background(0);
  map.draw();
  
  // geo
  noFill();
  stroke(255);
  for (Geo g: myGeo) {
    g.getPosition();
    g.update();
    g.render();
  }
  // hr
  hrStats();
  displayBar();
  pos.lerp(tpos, 0.07);
  interaction();
  displayTitle();
}

void hrStats() {
  int cnt = 0;
  beginShape();
  noFill();
  //stroke(245, 0, 0, 200);
  stroke(0,80);
  strokeWeight(3);
  for(HeartRate h: myHr) {
    float x = map(cnt, 0, myHr.size(), width*0.05, width*0.95);
    float y = height - map(h.hr, 0, 10, 0, height);
    h.pos = new PVector(x, y);
    vertex(x,y);
    cnt++;
  }  
  endShape();
  
  cnt = 0;
  beginShape();
  noFill();
  //stroke(245, 0, 0, 200);
  stroke(255);
  strokeWeight(1);
  for(HeartRate h: myHr) {
    float x = map(cnt, 0, myHr.size(), width*0.05, width*0.95);
    float y = height - map(h.hr, 0, 10, 0, height);
    h.pos = new PVector(x, y);
    vertex(x,y);
    cnt++;
  }  
  endShape();
  
  stroke(245, 240);
  strokeWeight(2);
  line(width*0.05, height-100, width*0.05, height-200);
  line(width*0.95, height-100, width*0.95, height-200);
}

void displayBar() {
  stroke(255);
  float lx = 0;
  float big = 500;
  
  if(mouseX < width*0.05)  lx = width*0.05;
  else if (mouseX > width*0.95)  lx = width*0.95;
  else lx = mouseX;
  
  strokeWeight(1);
  line(lx, 0, lx, height);
  
  for(HeartRate h: myHr) {
    float temp_big = abs(lx - h.pos.x);
    if (big > temp_big) {
      big = temp_big;
      sel_h = int(h.h);
      sel_mi = int(h.mi);
      sel_s = int(h.s);
      sel_hr = h.hr;
    }
  }
  fill(255, 90);
  textSize(120);
  textAlign(RIGHT);
  text(sel_h+":"+sel_mi+":"+sel_s, width*0.95, height*0.7);
  
  noStroke();
  fill(0, 80);
  rect(lx, height*0.92 - 20, 66, 24);
  
  textAlign(LEFT);
  //fill(255, 0, 0);
  //fill(255, 117, 0);
  fill(242,13,14,220);
  textSize(22);
  text(sel_hr, lx + 1, height* 0.92);//0.92);
  
  float ly = height - map(sel_hr, 0, 10, 0, height);
  imageMode(CENTER);
  noStroke();
  image(myImg, lx, ly, 30, 26);
  imageMode(CORNER);
}

void checkGeo() {
  float big = 5000000;
  
  //if((sel_h > 10) && (sel_h < 18)) {
    for(Geo g: myGeo) {
      float temp_big = abs(g.h-sel_h)*3600 + abs(g.mi-sel_mi)*60 + abs(g.s-sel_s);
      if (big > temp_big) {
          big = temp_big;
          g.getPosition();
          sel_lon = g.lon;
          sel_lat = g.lat;
          sel_x = g.pos.x;
          sel_y = g.pos.y;
          
          tpos.x = sel_lon;
          tpos.y = sel_lat;
        }
      }
  //}
}

void interaction() {
  checkGeo();  
  Location target = new Location(pos.y, pos.x);
  map.zoomAndPanTo(target, 16);
  
  noStroke();
  float hr_map = map(sel_hr, 1, 3, 32, 120);
  //fill(245, 0, 0, 80);
  fill(0, 80);
  ellipse(sel_x, sel_y, hr_map, hr_map);
  
  //fill(251,251,31, 90);
  //fill(255,117,0, 90);
  fill(242,13,14, 90);
  ellipse(sel_x, sel_y, hr_map, hr_map);
  ellipse(sel_x, sel_y, 32, 32);
  ellipse(sel_x, sel_y, 30, 30);
  ellipse(sel_x, sel_y, 28, 28);
  
  fill(255);
  textFont(myFont);
  textSize(20);
  textAlign(CENTER);
  ///text("GB", sel_x, sel_y);
}

void loadData() {
 // geo 
 for (int i = 0; i < geoInfo.length; i++) {
   String[] pieces = split(geoInfo[i], ',');
   Geo g = new Geo();
   g.dateTime = pieces[0];
   g.person = pieces[1];
   g.lon = float(pieces[2]);
   g.lat = float(pieces[3]);
   myGeo.add(g);
   g.getDate();
   g.getLocation();
 } 
 // heart rate
 int cnt = 0;
 for (int i = 0; i < hrInfo.length; i++) {
   String[] pieces = split(hrInfo[i], ',');
   HeartRate h = new HeartRate();
   h.dateTime = pieces[0];
   h.person = pieces[1];
   h.hr = float(pieces[2]);
   h.temp = float(pieces[3]);
   h.energy = float(pieces[4]);
   h.cnt = cnt;
   myHr.add(h);
   h.getDate();
   cnt++;
 }
}

void displayTitle() {
  fill(0, 80);
  noStroke();
  rect(width*0.05, height*0.05, width*0.53, height*0.08);
  
  fill(255);
  textFont(myFont);
  textAlign(LEFT);
  text("ONE DAY IN THE OKAVANGO", width*0.06, height*0.1 + 10);
}

