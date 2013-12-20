/*

Into the Okavango JSON Example
Data Rep 2013

*/

String endPoint = "http://www.intotheokavango.org/api/timeline?date=20130908&types=sighting";
IntDict birdDict = new IntDict();

void setup() {
  //size(1280, 820);
  background(0);
  
  JSONObject myJSON = loadJSONObject(endPoint); 
  JSONArray features = myJSON.getJSONArray("features");
  println(features);
  
  for(int i = 0; i < features.size(); i++) {
    JSONObject singleFeature = features.getJSONObject(i);
    JSONObject properties = singleFeature.getJSONObject("properties");

    String birdName = properties.getString("Bird Name");
    int birdCount = properties.getInt("Count");
    //println("They saw " + birdCount + " " + birdName);
    
//    fill(255);
//    textSize(map(birdCount,0,50,10,36));
//    text(birdName, random(width), random(height));
  }
}

