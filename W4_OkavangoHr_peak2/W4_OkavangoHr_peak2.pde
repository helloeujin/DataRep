/*

Into the Okavango JSON Example
Data Rep 2013

*/

import java.util.Date;
import java.text.SimpleDateFormat;
PFont myfont;

// 10th date from the start of the expedition (sep 15, 16 or 17)
String[] urlList  = { "http://www.intotheokavango.org/api/timeline?date=20130908&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130909&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130910&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130911&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130912&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130913&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130914&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130915&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130916&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130917&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130918&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130919&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130920&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130921&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130922&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130923&types=ambit",
                      "http://www.intotheokavango.org/api/timeline?date=20130924&types=ambit"};

IntDict hrDict = new IntDict();
int cnt = 0;
ArrayList<Data> steveData = new ArrayList();
ArrayList<Data> johnData = new ArrayList();
ArrayList<Data> gbData = new ArrayList();
ArrayList<Stat> myStat = new ArrayList();
Table table;

float start = 0;
float end = 0;

void setup() {
  size(1280, 720, P3D);
  background(0);
  smooth(); 
  
  for(int num = 0; num < urlList.length; num++) {
    JSONObject myJSON = loadJSONObject(urlList[num]); 
    JSONArray features = myJSON.getJSONArray("features");
    //println(num + ", " + features.size());
    
    //2013-09-15T15:48:13+0200
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
    for(int i = 0; i < features.size(); i++) {
      JSONObject singleFeature = features.getJSONObject(i);
      JSONObject properties = singleFeature.getJSONObject("properties");
      
      String name = properties.getString("Person");
      String dateTime = properties.getString("DateTime");
      float hr = properties.getFloat("HR", -1);
      
      if(hr != -1) {
        String heartRate = Float.toString(hr);
        hrDict.increment(heartRate);
        cnt++;
        
        Data d = new Data();
        d.hr = hr;
        d.dateTime = dateTime;
        //println(d.dateTime);
        
        // convert date string to date
        try {
          d.date = sdf.parse(d.dateTime);
          //println(d.date);
        } catch (Exception e) {
          println("Error parsing date:" + e); 
        }
        
        d.urlNum = num;
        if(name.equals("Steve"))  steveData.add(d);
        if(name.equals("John"))  johnData.add(d);
        if(name.equals("GB"))  gbData.add(d);
      }
    }
  }
  /*
  table = loadTable("Okavango_Steve.csv", "header");
  for(TableRow row : table.rows()) {
    float AverageHr = row.getFloat("AverageHr");
    float MaxHr = row.getFloat("MaxHr");
    float MinHr = row.getFloat("MinHr");
    
    Stat s = new Stat();
    s.AverageHr = AverageHr;
    s.MaxHr = MaxHr;
    s.MinHr = MinHr;
    myStat.add(s);
  }
  */
  
  
  //2013-09-15T15:48:13+0200
//  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
//  Date tdate = sdf.parse("2013-09-15T15:48:13+0200");
  start = (float) steveData.get(0).date.getTime();
  end = (float) steveData.get(steveData.size() - 1).date.getTime();
  //blendMode(ADD);
  
  strokeWeight(1.5);
  beginShape(); 
  noFill();
  stroke(0, 0, 255, 120);
  for(int i = 0; i < steveData.size(); i++) {
    Data d = steveData.get(i);
    //float x = map(i, 0, steveData.size(), width*0.1, width*0.9);
    float t = (float) d.date.getTime();
    float x = map(t, start, end, width*0.1, width*0.9);
    float y = map(d.hr, 0.8, 3, height*0.9, height*0.1); 
    vertex(x, y);
    
    //line(x, height, x, y);
    //if(y < height*0.4)  text(d.dateTime, x, y);
    //println(x + ", " + y);
  }
  endShape();
  
  beginShape(); 
  noFill();
  stroke(255, 0, 0, 120);
  for(int i = 0; i < johnData.size(); i++) {
    Data d = johnData.get(i);
    //float x = map(i, 0, johnData.size(), width*0.1, width*0.9);
    float t = (float) d.date.getTime();
    float x = map(t, start, end, width*0.1, width*0.9);
    float y = map(d.hr, 0.8, 3, height*0.9, height*0.1); 
    vertex(x, y);
  }
  endShape();
  
  myfont = loadFont("Blanch-Caps-48.vlw");
  fill(180, 180); 
  textFont(myfont);
  textSize(50);
  //text("SEP 16", width*0.1, height*0.1);
  
  //findCrocodile();
  
  
  beginShape(); 
  noFill();
  stroke(0, 255, 0, 80);
  for(int i = 0; i < gbData.size(); i++) {
    Data d = gbData.get(i);
    //float x = map(i, 0, gbData.size(), width*0.1, width*0.9);
    float t = (float) d.date.getTime();
    float x = map(t, start, end, width*0.1, width*0.9);
    float y = map(d.hr, 0.8, 3, height*0.9, height*0.1); 
    vertex(x, y);
  }
  endShape();
  
  
  /*
  String[] keys = hrDict.keyArray();
  for(int i = 0; i < keys.length; i++) {
    float hr = (float) hrDict.get(keys[i]);
    float x = map(i, 0, keys.length, width*0.1, width*0.9);
    float y = map(hr, 0, 5, height, 0);
    stroke(255);
    line(x, height, x, y);
  }
  */
}

void findCrocodile() {
  String[] dates = {"2013-09-16T10:09:00+0200",
                    "2013-09-16T10:50:00+0200",
                    "2013-09-16T11:52:00+0200",
                    "2013-09-16T12:14:00+0200"}; 
                    
//  String[] dates = {"2013-09-17T10:43:00+0200",
//                    "2013-09-17T11:03:00+0200",
//                    "2013-09-17T12:49:00+0200",
//                    "2013-09-17T12:53:00+0200",
//                    "2013-09-17T13:13:00+0200",
//                    "2013-09-17T13:25:00+0200",
//                    "2013-09-17T13:59:00+0200",
//                    "2013-09-17T14:11:00+0200",
//                    "2013-09-17T15:47:00+0200",
//                    "2013-09-17T16:26:00+0200",
//                    "2013-09-17T16:52:00+0200",
//                    "2013-09-17T16:55:00+0200",
//                    "2013-09-17T16:57:00+0200",
//                    "2013-09-17T16:58:00+0200"};
                       
  SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ssZ");
  
  stroke(150, 80);
  strokeWeight(0.8);
  // convert date string to date
  for(int i = 0; i < dates.length; i++) {
    try {
      Date mydate = sdf.parse(dates[i]);
      float t = (float) mydate.getTime();
      float x = map(t, start, end, width*0.1, width*0.9);
      line(x, height*0.1, x, height*0.9);
      //line(x, 0, x, height);
    } catch (Exception e) {
      println("Error parsing date:" + e); 
    }
  } 
}
