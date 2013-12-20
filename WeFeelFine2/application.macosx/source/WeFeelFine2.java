import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class WeFeelFine2 extends PApplet {

/* 

We Feel Fine XML Example
ITP Data Rep 2013

http://wefeelfine.org/api.html
http://api.wefeelfine.org:8080/ShowFeelings?returnfields=feeling,sentence&display=xml // this one !!!
view-source:http://api.wefeelfine.org:8080/ShowFeelings?returnfields=feeling,sentence&display=xml

*/

String endPoint = "http://api.wefeelfine.org:8080/ShowFeelings?returnfields=feeling,sentence,gender&display=xml&city=brooklyn"; //&limit=1500";
String testFile = "feelings.xml";
int happyCount = 0;
IntDict feelingDict;
PFont label;

ArrayList <FeelingObject> feelingList = new ArrayList();

public void setup() {
  size(1280,720,P3D);
  background(0);
  label = createFont("Helvetica", 24);
  
  XML feelingsXML = loadXML(endPoint);
//  XML feelingsXML = loadXML(testFile);

  XML[] feelings = feelingsXML.getChildren("feeling");
  fill(255);
  
  feelingDict = new IntDict();
  
  for(XML x:feelings) {  //for(int i = 0; i < feelings.length ; i++)
    
    String f = x.getString("feeling");
    if(f != null) {
      feelingDict.increment(f);
      
      // create a new feeling object
      FeelingObject fo = new FeelingObject();
      fo.feeling = f;
      fo.sentence = x.getString("sentence");
      fo.sex = x.getString("gender");
      fo.pos = new PVector(0, 0);
      fo.tpos = new PVector(random(width), random(height));
      
      // put it in arraylist
      feelingList.add(fo);
    }
  }
}

public void draw() {
  background(0);
  
  for(FeelingObject fo:feelingList) {
    fo.update();
    fo.render();
  }
}

public void scatter() {
  for(FeelingObject fo:feelingList) {
    fo.tpos = new PVector(random(width), random(height));
  }
}

public void positionByPopularity() {
  for(FeelingObject fo:feelingList) {
    fo.tpos.y = height - (map(feelingDict.get(fo.feeling), 0, max(feelingDict.valueArray()), 0, height-50)) + random(-5, 5);
  }
}

public void positionBySex() {
  for(FeelingObject fo:feelingList) {
     if(fo.sex == null) {
      fo.tpos.x = -100; 
     } else {
      fo.tpos.x = (fo.sex.equals("1")) ? 200 + random(-100, 100): width - 200 + random(-100, 100); 
     }
  }
}

public void keyPressed() {
 if(key == 'x') scatter(); 
 if(key == 'p') positionByPopularity();
 if(key == 's') positionBySex();
}



class FeelingObject {
  
  String feeling;
  String sentence;
  String sex; // "1" = male, "0" = female
  
  PVector pos = new PVector(); // x, y, z
  PVector tpos = new PVector(); // target position
  
  FeelingObject() {
  
  }
  
  public void update() {
    pos.lerp(tpos, 0.1f);
  }
  
  public void render() { // easy to transform to 3d
    pushMatrix();
      translate(pos.x, pos.y);
      text(feeling, 0, 0);
    popMatrix();
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "WeFeelFine2" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
