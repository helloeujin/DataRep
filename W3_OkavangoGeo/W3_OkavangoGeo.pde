String OkavangoGeoFile = "http://www.intotheokavango.org/api/timeline?date=20130908&types=ambit_geo";
//String OkavangoGeoFile = "OkavangoGeoJSON.txt";
ArrayList <Geo> geoInfo = new ArrayList();
Table table;
IntDict name = new IntDict();

void setup() {
  background(0);
  // Load the JSON
  JSONObject myJSON = loadJSONObject(OkavangoGeoFile);
  JSONArray features = myJSON.getJSONArray("features");
  
  for(int i = 0; i < features.size(); i++) {
    JSONObject singleFeature = features.getJSONObject(i);
    JSONObject properties = singleFeature.getJSONObject("properties");
    JSONObject geometry = singleFeature.getJSONObject("geometry");
    JSONArray coordinates = geometry.getJSONArray("coordinates");
    
    String dateTime = properties.getString("DateTime");
    String person = properties.getString("Person");
    float lon = coordinates.getFloat(0); // x
    float lat = coordinates.getFloat(1); // y
    
    if(person.equals("GB")) {
      Geo g = new Geo();
      g.dateTime = dateTime;
      g.person = person;
      g.lon = lon;
      g.lat = lat;
      geoInfo.add(g);
    }
  }
  table = loadTable("geoInfo.csv", "header");
  saveData();
}

void draw() {
}

void saveData() {
  for(Geo g: geoInfo) {
    String info = g.dateTime+","+g.person+","+g.lon+","+g.lat;
    if (g.person.equals("GB")) {
      TableRow row = table.addRow();
      row.setString("geoInfo", info);
      saveTable(table, "data/geoInfo.csv");
    }
  }
}
