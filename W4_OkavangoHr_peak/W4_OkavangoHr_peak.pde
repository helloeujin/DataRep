/*

Into the Okavango JSON Example
Data Rep 2013

*/

String endPoint = "http://www.intotheokavango.org/api/timeline?date=20130917&types=ambit";
// tenth date from the start of the expedition (sep 16)

IntDict hrDict = new IntDict();
int cnt = 0;
float sumHr = 0;
float maxHr = 0;
float minHr = 100;
float highFreq1 = 0;
float highFreq2 = 0;

void setup() {
  //size(1280, 720);
  background(0);

  JSONObject myJSON = loadJSONObject(endPoint); 
  JSONArray features = myJSON.getJSONArray("features");
  
  for(int i = 0; i < features.size(); i++) {
    JSONObject singleFeature = features.getJSONObject(i);
    JSONObject properties = singleFeature.getJSONObject("properties");
    
    // Get the hr value
    String name = properties.getString("Person");
    float hr = properties.getFloat("HR", -1);
    if((hr != -1) && (name.equals("Steve"))) {
      String heartRate = Float.toString(hr);
      hrDict.increment(heartRate);
      sumHr = sumHr + hr;
      cnt++;
      if(hr > maxHr) maxHr = hr;
      if(hr < minHr) minHr = hr;
      if(hr > 2.5) highFreq1++;
      if(hr > 2.0) highFreq2++;
    }
  }
  float averageHr = sumHr/cnt;
  println("Sum Hr: "+ sumHr);
  println("# of data: "+ cnt);
  println("Average Hr: " + averageHr);
  println("Max Hr: " + maxHr);
  println("Min Hr: " + minHr);
  println("Hr > 2.5: " + highFreq1*100/cnt);
  println("Hr > 2.0: " + highFreq2*100/cnt);
  
//  String[] keys = hrDict.keyArray();
//  for(int i = 0; i < keys.length; i++) {
//    float hr = (float) hrDict.get(keys[i]);
//    float x = map(i, 0, keys.length, width*0.1, width*0.9);
//    float y = map(hr, 0, 5, height, 0);
//    stroke(255);
//    line(x, height, x, y);
//  }
}
