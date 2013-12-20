class Data {
  
  String country;
  String continent;
  int voteYear;
  float x = 0;
  float y = 0;
  int num = 0;
  
  float unit_x = width*0.05;
  float unit_y = height*0.1;
  
  //for axis
  float min_x = unit_x;
  float max_x = width - unit_x;
  float min_y = height - unit_y*3; // from the bottom
  float max_y = unit_y*4;

  int selectedYear = 0;
  float temp_y = min_y;
  float vel = 0;
  float acc = 0.8;
  boolean start = false;
  
  Data(String continent_, String country_, int voteYear_) {
    country = country_;
    voteYear = voteYear_;
    continent = continent_;
  }
  
  void display(int i_, int selectedYear_) {
    num = i_;
    selectedYear = selectedYear_;
    x = map(num, 0, 184, min_x, max_x);
    y = map(voteYear, 1890, 2010, min_y, max_y);
    
    if(voteYear == selectedYear) {
      start = true;
    } 
    
    if(start) {
      if(temp_y > max_y) {
        temp_y = temp_y - vel;
        vel = vel + acc;
      } else {
        temp_y = max_y;
      }
    }
    
    fill(255);
    stroke(255);
    strokeWeight(0.5);
    line(x, min_y, x, temp_y);
    ellipse(x, temp_y, 3, 3);
  }
}
