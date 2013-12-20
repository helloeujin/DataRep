//String OkavangoFile = "http://www.intotheokavango.org/api/timeline?date=20130908&types=ambit";
String OkavangoFile = "OkavangoHeartrate.txt";
ArrayList <HeartRate> heartRates = new ArrayList();
Table table;
IntDict name = new IntDict();

void setup() {
  size(1280, 820);
  background(0);
  
  // Load the JSON
  JSONObject myJSON = loadJSONObject(OkavangoFile);
  JSONArray features = myJSON.getJSONArray("features");
  
  for(int i = 0; i < features.size(); i++) {
    JSONObject singleFeature = features.getJSONObject(i);
    JSONObject properties = singleFeature.getJSONObject("properties");
    
    // in order to filter out data without 'hr' value in it
    float hr = properties.getFloat("HR",-1);
    float speed = properties.getFloat("Speed",-1);
    float energyConsumption = properties.getFloat("EnergyConsumption");
    float temperature = properties.getFloat("Temperature");
    String person = properties.getString("Person");
    String dateTime = properties.getString("DateTime");
      
    if ((hr != -1) && (speed != -1)) {
      if (person.equals("GB")) {
        HeartRate h = new HeartRate();
        h.hr = hr;
        h.temp = temperature;
        h.energy = energyConsumption;
        h.person = person;
        h.dateTime = dateTime;
        heartRates.add(h);
      }
    }
  }
  table = loadTable("hrInfo.csv", "header");
  saveData();
}

void draw() {
  background(0);
  for(HeartRate h: heartRates) {
    h.update();
    h.render();
  }
}

void scatter() {
  for(HeartRate h: heartRates) {
    h.hr_tpos = new PVector(random(width), random(height));
    h.temp_tpos = new PVector(random(width), random(height));
  }  
}

void hrStats() {
  int cnt = 0;
  for(HeartRate h: heartRates) {
    float x = map(cnt, 0, heartRates.size(), 0, width);
    float y = height - map(h.hr, 0, 6, 0, height);
    h.hr_tpos = new PVector(x, y);
    
    float y2 = height - map(h.temp, 0, 600, 300, height-600);
    h.temp_tpos = new PVector(x, y2);
    cnt++;
  }  
}

void keyPressed() {
  if(key == 's')  scatter();
  if(key == 'h')  hrStats();
}

void mouseClicked() {
 fill(255,0,0);  
 ellipse(mouseX, mouseY, 200, 200);
 noFill();
}

void saveData() {
  for(HeartRate h: heartRates) {
    String info = h.dateTime+","+h.person+","+h.hr+","+h.temp+","+h.energy;
    TableRow row = table.addRow();
    row.setString("hrInfo", info);
    saveTable(table, "data/hrInfo.csv");
  }
}
