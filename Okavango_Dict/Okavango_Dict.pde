/*

Into the Okavango JSON Example
Data Rep 2013

*/

String endPoint = "http://www.intotheokavango.org/api/timeline?date=20130916&types=sighting";
IntDict birdDict = new IntDict();

void setup() {
  //size(1280, 820);
  background(0);
  
  JSONObject myJSON = loadJSONObject(endPoint); 
  JSONArray features = myJSON.getJSONArray("features");
  
  for(int i = 0; i < features.size(); i++) {
    JSONObject singleFeature = features.getJSONObject(i);
    JSONObject properties = singleFeature.getJSONObject("properties");

    String birdName = properties.getString("Bird Name");
    String dateTime = properties.getString("DateTime");
    //int birdCount = (int) properties.getFloat("Count");
    //if(birdName.equals("Crocodile"))  birdDict.increment(birdName);
    if(birdName.equals("Crocodile"))  println(dateTime);
  }
  
//  String[] keys = birdDict.keyArray();
//  for(int i = 0; i < keys.length; i++) {
//    String bird = keys[i];
//    int birdNumber = birdDict.get(keys[i]);
//    println(bird + ": " + birdNumber);
//  }
}

