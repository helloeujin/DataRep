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

void setup() {
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

void draw() {
  background(0);  
  for(FeelingObject fo:feelingList) {
    fo.update();
    fo.render();
  }
}

void scatter() {
  for(FeelingObject fo:feelingList) {
    fo.tpos = new PVector(random(width), random(height));
  }
}

void positionByPopularity() {
  for(FeelingObject fo:feelingList) {
    fo.tpos.y = height - (map(feelingDict.get(fo.feeling), 0, max(feelingDict.valueArray()), 0, height-50)) + random(-5, 5);
  }
}

void positionBySex() {
  for(FeelingObject fo:feelingList) {
     if(fo.sex == null) {
      fo.tpos.x = -100; 
     } else {
      fo.tpos.x = (fo.sex.equals("1")) ? 200 + random(-100, 100): width - 200 + random(-100, 100); 
     }
  }
}

void keyPressed() {
 if(key == 'x') scatter(); 
 if(key == 'p') positionByPopularity();
 if(key == 's') positionBySex();
}



