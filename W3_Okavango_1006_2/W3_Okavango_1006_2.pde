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
import de.fhpotsdam.212,21unfolding.geo.Location;
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
float lx = 0;
float ly = 0;
String stTime;
String sh, sm, ss;

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
  noStroke();
  fill(0, 80);
  //rect(width*0.05, height*0.85, width*0.9, height*0.1);
  
  // WHITE BAR
  int cnt = 0;
  noFill();
  stroke(0,80);
  strokeWeight(2);
  beginShape();
  for(HeartRate h: myHr) {
    float x = map(cnt, 0, myHr.size(), width*0.05, width*0.95);
    float y = height - map(h.hr, 0, 10, 0, height)  + height*0.1;
    h.pos = new PVector(x, y);
    //if((cnt%20)==0) //line(x, height*0.95, x, height*0.85);
    vertex(x,y);
    cnt++;
  } 
  endShape();
  
  // RED GRAPH
  cnt = 0;
  noFill();
  stroke(255, 220);
  strokeWeight(1);
  beginShape();
  for(HeartRate h: myHr) {
    float x = map(cnt, 0, myHr.size(), width*0.05, width*0.95);
    float y = height - map(h.hr, 0, 10, 0, height) + height*0.1;
    h.pos = new PVector(x, y);
    vertex(x,y);
    cnt++;
  }
  endShape();
  noStroke();
  
  stroke(245, 240);
  strokeWeight(2);
  line(width*0.05, height*0.95, width*0.05, height*0.85);
  line(width*0.95, height*0.95, width*0.95, height*0.85);
}

void displayBar() {
  stroke(255);
  //float lx = 0;
  float big = 500;
  
  if(mouseX < width*0.05)  lx = width*0.05;
  else if (mouseX > width*0.95)  lx = width*0.95;
  else lx = mouseX;
  
  strokeWeight(1);
  //stroke(255, 0, 0);
  stroke(255);
  //line(lx, 0, lx, height);
  //line(lx, height*0.95, lx, height*0.85);
  
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
  //text(sel_h+":"+sel_mi+":"+sel_s, width*0.95, height*0.7);
  checkNum();
  String stTime = sh + ":" + sm + ":" + ss; 
  text(stTime, width*0.95, height*0.8);
  
  noStroke();
  fill(0, 80);
  //rect(lx, height*0.92 - 20, 66, 24);
  //rect(lx, height*0.85, 66, height*0.1);
  
  textAlign(LEFT);
  fill(242,13,14,220);
  textSize(18);
  //text("HeartRate: "+sel_hr, lx + 1, height* 0.92);//0.92);
  
  ly = height - map(sel_hr, 0, 10, 0, height);
  imageMode(CENTER);
  noStroke();
  image(myImg, lx, ly + height*0.1, 30, 26);
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
  //Location target = map.getLocation(lx, ly);
  map.panTo(target);
  
  noStroke();
  float hr_map = map(sel_hr, 1, 3, 24, 150);
  fill(0, 80);
  ellipse(sel_x, sel_y, hr_map, hr_map);
  
  fill(242,13,14, 90);
  ellipse(sel_x, sel_y, hr_map, hr_map);
  ellipse(sel_x, sel_y, 24, 24);
  ellipse(sel_x, sel_y, 22, 22);
  ellipse(sel_x, sel_y, 20, 20);
  
  fill(255);
  textFont(myFont);
  textSize(20);
  textAlign(CENTER);
  //text("GB", sel_x, sel_y);
  
  stroke(255,0,0);
  strokeWeight(1);
  //line(sel_x, sel_y, sel_x, sel_y-hr_map/2);
  
  noStroke();
  fill(0, 80);
  rect(sel_x, sel_y, width*0.13, height*0.035);
  
  textAlign(LEFT, TOP);
  fill(255);
  textSize(16);
  text("Heart rate: "+sel_hr, sel_x+2, sel_y);//0.92);
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

void checkNum() {
  if(sel_h < 10)  sh = "0"+ sel_h;
  else  sh = str(sel_h);
  
  if(sel_mi < 10)  sm = "0"+ sel_mi;
  else  sm = str(sel_mi);
  
  if(sel_s < 10)  ss = "0"+ sel_s;
  else  ss = str(sel_s);
}
