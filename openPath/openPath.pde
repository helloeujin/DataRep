import java.util.Date;
import java.text.SimpleDateFormat;

PImage textureImg;
PImage nightImg;

ArrayList<GeoPoint> pointList = new ArrayList();
ArrayList<GeoPoint> pointList2 = new ArrayList();

void setup() {
  size(1280, 720, P3D); // P3D -> good for big data
  
  textureImg = loadImage("texture.png");
  nightImg = loadImage("night2.jpg"); // night.png
  smooth(4);
  
  println("hi");
  //loadOpenPathsCSV("openpaths_meggonagul.csv", 1);
  loadOpenPathsCSV("openpaths_blprnt.csv", 2);
  plotMap();
}

void draw() {
  background(0);
  imageMode(CORNER);
  //image(nightImg, 0, 0, width, height);
  
  imageMode(CENTER);
  
  blendMode(ADD);
  /*
  translate(width/2, height/2);
    rotateX( map(mouseY, 0, height, 0, PI/2) );
    rotateZ( map(mouseX, 0, width, 0, PI*2) ); // TAU = 2*PI
  translate(-width/2, -height/2);
  */
  for(GeoPoint gp:pointList) {
    gp.update();
    gp.render(); 
  }
  mapLine();
}

void mapLine() {
  noFill();
  beginShape();
  stroke(255, 40);
    float x = 0;
    float y = 0;
    for(int i = 0; i < int(frameCount/2) % pointList.size(); i++) {
      GeoPoint gp = pointList.get(i);
      x = gp.pos.x;
      y = gp.pos.y;
      vertex(gp.pos.x, gp.pos.y, gp.pos.z);
    }
  endShape();
  //tint(0, 255, 255); 
  image(textureImg, x, y, 20,20);
  
  /*
  int tail = 3;
  beginShape();
    for(int i = 0; i < tail ; i++) {
      GeoPoint gp = pointList.get((i + int(frameCount / 10)) % pointList.size());
      vertex(gp.pos.x, gp.pos.y, gp.pos.z); 
    }
  endShape();
  */
}

void plotMap() {
  // -74.231622,40.649336,-73.687912,40.886192
  // get start & end epoch time for mappin
  float start = (float) pointList.get(0).date.getTime();
  float end = (float) pointList.get(pointList.size() - 1).date.getTime();
   
  for(GeoPoint gp:pointList) {
    float x = map(gp.lon,  -74.231622, -73.687912, 0, width);
    float y = map(gp.lat, 40.649336, 40.886192, height, 0);

    float t = (float) gp.date.getTime(); // epoch time (start from JAN 1970)
    float z = map(t, start, end, 0, 100);
    //println(z);
    gp.tpos = new PVector(x + random(-5, 5), y + random(-5, 5), z);
  }
}

void loadOpenPathsCSV(String url, int n) {
  //lat,lon,alt,date,device,os,version
  //0           1             2             3                   4               5
  //40.77555086,-73.91421635,-27.7999992371,1970-01-01 00:00:00,"samsung d2att",4.1.1,1.0
  
  // Make the SimpleDateFormatObject
  // 2011-06-07 11:11:11
  // 9/29/13 17:37
  //println(n);
  //if(n == 1)  { SimpleDateFormat sdf = new SimpleDateFormat("MM/dd/yy HH:mm"); }
  //if(n == 2)  { SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); }
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); 
  
  Table opTable = loadTable(url, "header");
  for(int i = 0; i < opTable.getRowCount(); i++) {
    TableRow r = opTable.getRow(i);
    GeoPoint gp = new GeoPoint();
    gp.lat = r.getFloat("lat"); // r.getFloat(0);
    gp.lon = r.getFloat("lon");
    gp.dateString = r.getString("date");
    
    // convert date string to date
    try {
      gp.date = sdf.parse(gp.dateString);
      //println(gp.dateString);
      //println(gp.date);
    } catch (Exception e) {
      println("Error parsing date:" + e);
    }
    pointList.add(gp);
  }
}


