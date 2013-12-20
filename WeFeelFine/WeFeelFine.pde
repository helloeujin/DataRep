/* 

We Feel Fine XML Example
ITP Data Rep 2013

http://wefeelfine.org/api.html
http://api.wefeelfine.org:8080/ShowFeelings?returnfields=feeling,sentence&display=xml // this one !!!
view-source:http://api.wefeelfine.org:8080/ShowFeelings?returnfields=feeling,sentence&display=xml

*/

//String endPoint = "http://api.wefeelfine.org:8080/ShowFeelings?returnfields=feeling,sentence&display=xml";
String endPoint = "http://api.wefeelfine.org:8080/ShowFeelings?returnfields=feeling,sentence&display=xml&city=brooklyn";
String testFile = "feelings.txt";//xml";
int happyCount = 0;
IntDict feelingDict;
PFont label;

void setup() {
  size(1280,720);
  background(0);
  
  // load the XML from the endpoint
//  XML feelingsXML = loadXML(endPoint);
  XML feelingsXML = loadXML(testFile);
//  println(feelingsXML);
  
  // get all of the child nodes with the node name 'feeling'
  XML[] feelings = feelingsXML.getChildren("feeling");

  // go through all of child nodes and do something
  fill(255);
  
  //String happyString = "good, awesome, happy, rad, happier, glad";
  feelingDict = new IntDict();
  for(XML x:feelings) {  //for(int i = 0; i < feelings.length ; i++)
    String f = x.getString("feeling");
    if(f != null) {
      feelingDict.increment(f);
      text(f, random(width), random(height));
//      if(happyString.contains(f)) happyCount++;
//      if(f.equals("happy ")) happyCount++;
    }
  }
  
  //println("Happy Count: " + happyCount);
//  feelingDict.sortValues(); // ascending values
    feelingDict.sortValuesReverse();
    label = createFont("Helvetica", 24);
    textFont(label);
}

void draw() {
  background(0);
  String[] keys = feelingDict.keyArray();
  int offset = int(map(mouseX, 0, width, 0, keys.length - 10));
  for(int i =0; i < 10; i++) {
    String txt = keys[i + offset] + ":" + feelingDict.get(keys[i + offset]);
    text(txt, 50, 50 + (i*40));
//    println(keys[i] + ":" + feelingDict.get(keys[i]) );
    
  }
}




