class DataSet {

  ArrayList myData;
  ArrayList myYear;
  Continent myContinent;
  int[] years;
  int[] time = new int[2010 - 1890 + 1];
  int cnt = 0;
  String[] nations = new String[15];
  String[] nation_color = new String[15];
  
  //for axis
  float unit_x = width*0.05;
  float unit_y = height*0.1;

  float min_x = unit_x;
  float max_x = width - unit_x;
  float min_y = height - unit_y*3; // from the bottom
  float max_y = unit_y*4;

  float pos_y = min_y + unit_y*2;
  float temp_x = min_x;
  int selectedYear = 1890;
  boolean drawChart = false;

  int sum_af = 53;
  int sum_as = 45;
  int sum_er = 47;
  int sum_nt = 23;
  int sum_st = 12;
  int sum_oc = 14;

  int cnt_af = 0;
  int cnt_as = 0;
  int cnt_er = 0;
  int cnt_nt = 0;
  int cnt_st = 0;
  int cnt_oc = 0;
  
  float ratio_af = 0;
  float ratio_as = 0;
  float ratio_er = 0;
  float ratio_nt = 0;
  float ratio_st = 0;
  float ratio_oc = 0;
  
  boolean onYear = false;
  boolean done = false;
  int selectedI = 0;
  float selectedX = max_x;
  float preselectedX = max_x;
  float easing = 0.05;
  String temp_country = "country";
  int sum = 0;

  DataSet() {
    myData = new ArrayList();
    myYear = new ArrayList();
    myContinent = new Continent();
    loadData();
    getYears();  
    getStatic();
  }

  void display() {
    if (done == false) {
      displayScrollAuto();
      myContinent.displayCircle(ratio_af, ratio_as, ratio_er, ratio_nt, ratio_st, ratio_oc);
    } else {
      displayScroll();
      myContinent.displayCircle(ratio_af, ratio_as, ratio_er, ratio_nt, ratio_st, ratio_oc);
    }
  }

  void getYears() {
    years = new int[myData.size()];   
    for (int i = 0; i < myData.size(); i++) {
      Data d = (Data) myData.get(i);
      years[i] = d.voteYear;
    }
  }

  void getStatic() {
    for (int i = 0; i < time.length; i++) {
      float temp_time = 1890 + i;
      int cnt_t = 0;

      for (int j = 0; j < years.length; j++) {
        if (temp_time == years[j]) {
          cnt_t++;
        }
      }
      time[i] = cnt_t;
    }
  }
  
  void displayScroll() {
    displayChart3();
    displayArea();
      
    // draw guide line
    stroke(69, 71, 84);
    strokeWeight(4);
    for(int j = 0; j < 11; j ++) {
      float guide_y = map(j, 0, 11, pos_y, min_y - unit_y);
      line(min_x, guide_y, max_x, guide_y);
    }   
    
    float x = 0;
    if (mousePressed) {
      for(int i = 0; i < time.length; i++) {
        if ((pos_y - 10 < mouseY) && (pos_y + 10 > mouseY)) {
          if ((min_x < mouseX) && (max_x > mouseX)) {        
            x = map(i, 0, time.length, min_x, max_x);
            if (dist(x, pos_y, mouseX, mouseY) < 5) {
              onYear = true;
              selectedI = i;
              selectedX = x;
              selectedYear = i + 1890;
            }
          }
        }
      }
    } else {
      onYear = false;
    }

    // find selectedYear
    textSize(18);
    textAlign(CENTER);
    fill(245, 247, 255);
    text(selectedYear, selectedX+35, pos_y + 25);

    // arrow
    fill(212, 99, 206);
//    fill(78, 78, 95);
    noStroke();
    float target_x = selectedX;
    float dx = target_x - preselectedX;
    if(abs(dx) > 1) {
        preselectedX += dx * easing;
     }
    triangle(preselectedX, pos_y, preselectedX-10, pos_y+30, preselectedX+10, pos_y+30);

    // for counting each country on each year
    fill(245, 247, 255);
    textAlign(CORNER);
    textSize(14);
    
    if(onYear) {
      // count # of countries in each continent at selected year
      cnt_af = 0;
      cnt_as = 0;
      cnt_er = 0;
      cnt_nt = 0;
      cnt_st = 0;
      cnt_oc = 0;
      int cnt_sum = 0;
      
      for (int j = 0; j < myData.size(); j++) {
        Data d = (Data) myData.get(j);
  
        if (d.voteYear == selectedYear) {
          if (d.continent.equals("Asia")) cnt_as++;
          if (d.continent.equals("Africa")) cnt_af++;
          if (d.continent.equals("Europe")) cnt_er++;
          if (d.continent.equals("North America")) cnt_nt++;
          if (d.continent.equals("South America")) cnt_st++;
          if (d.continent.equals("Oceania")) cnt_oc++;

          nation_color[cnt_sum] = d.continent;
          nations[cnt_sum] = d.country;              
          cnt_sum++;
          sum = cnt_sum;
        }
      }
      
      ratio_af = cnt_af*100/sum_af;
      ratio_as = cnt_as*100/sum_as;
      ratio_er = cnt_er*100/sum_er;
      ratio_nt = cnt_nt*100/sum_nt;
      ratio_st = cnt_st*100/sum_st;
      ratio_oc = cnt_oc*100/sum_oc;
      onYear = false;
    }
    
    textSize(12);
    textAlign(CORNER, BOTTOM);

    for(int i = 0; i < sum; i ++) {   
      String nation_name = nations[i];
      String nation_colors = nation_color[i];
      float ty = map(i, 0, 11, pos_y, min_y - unit_y);

      fill(245, 247, 255);
//      fill(0);
      text(nation_name, selectedX + 12, ty - 2);

      if (nation_colors.equals("Africa")) fill(78, 185, 205);
      if (nation_colors.equals("Asia")) fill(255);
      if (nation_colors.equals("Europe")) fill(109, 202, 116);
      if (nation_colors.equals("North America")) fill(144,120,219);
      if (nation_colors.equals("South America")) fill(200,94,200);
      if (nation_colors.equals("Oceania")) fill(230, 213, 76);
      
      noStroke();
      ellipse(selectedX, ty - 9, 8, 8);
    }
  }

  void displayScrollAuto() {
    // speed of time change
    temp_x = temp_x + 2; 
    
    // final chart
    if (temp_x > max_x ) {
      temp_x = max_x;
      drawChart = true;
    }

    // find selectedYear
    textSize(18);
    textAlign(CENTER, TOP);
    fill(245, 247, 255);
    
    int tempYear = int(map(temp_x, min_x, max_x, 1890, 2010));
    text(tempYear, temp_x, pos_y + 10);
    if (tempYear == 2010)  text(1890, min_x, pos_y + 10);
    
    if (tempYear > selectedYear) {
      selectedYear = tempYear;
      onYear = true;
    }

    // draw numbers
    if (drawChart) {
      displayChart();
      displayArea();
    } else {
      displayChart();
    }
    
    // draw guide line
    stroke(69, 71, 84);
    strokeWeight(4);
    for(int j = 0; j < 11; j ++) {
      float guide_y = map(j, 0, 11, pos_y, min_y - unit_y);
      line(min_x, guide_y, max_x, guide_y);
    }

    // arrow
    fill(212, 99, 206);
    noStroke();
    triangle(temp_x, pos_y, temp_x-10, pos_y-60, temp_x+10, pos_y-60);

    int cnt_sum = 0;
    // for counting each country on each year
    if(onYear) {
//      fill(245, 247, 255);
//      textAlign(CORNER, TOP);
//      textSize(11);
      // count # of countries in each continent at selected year
      for (int j = 0; j < myData.size(); j++) {
        Data d = (Data) myData.get(j);
  
        if (d.voteYear == selectedYear) {
          if (d.continent.equals("Asia")) cnt_as++;
          if (d.continent.equals("Africa")) cnt_af++;
          if (d.continent.equals("Europe")) cnt_er++;
          if (d.continent.equals("North America")) cnt_nt++;
          if (d.continent.equals("South America")) cnt_st++;
          if (d.continent.equals("Oceania")) cnt_oc++;
          
          cnt_sum++;
        }
      }
      
      ratio_af = cnt_af*100/sum_af;
      ratio_as = cnt_as*100/sum_as;
      ratio_er = cnt_er*100/sum_er;
      ratio_nt = cnt_nt*100/sum_nt;
      ratio_st = cnt_st*100/sum_st;
      ratio_oc = cnt_oc*100/sum_oc;
      onYear = false;
    }
  }
 

  void displayChart() {
    for (int i = 0; i < time.length; i++) {
      stroke(245, 247, 255);
      strokeWeight(1);

      // x and y axis value
      float x = map(i, 0, time.length, min_x, max_x);
      float y = map(time[i], 0, 11, pos_y, min_y - unit_y);
      if (i + 1890 <= selectedYear) {
        line(x, pos_y, x, y);
      }
    }
  }
  
  void displayChart2() {
    for (int i = 0; i < time.length; i++) {
      stroke(245, 247, 255);
      strokeWeight(5);

      // x and y axis value
      float x = map(i, 0, time.length, min_x, max_x);
      float y = map(time[i], 0, 11, pos_y, min_y - unit_y);
      if (i + 1890 == selectedYear) {
        line(x, pos_y, x, y);
      }
    }
  }
  
  void displayChart3() {
    for (int i = 0; i < time.length; i++) {
      stroke(245, 247, 255, 100);
      strokeWeight(1);

      // x and y axis value
      float x = map(i, 0, time.length, min_x, max_x);
      float y = map(time[i], 0, 11, pos_y, min_y - unit_y);
        line(x, pos_y, x, y);
    }
  }

  void displayArea() {
    noStroke();
    beginShape();
    for (int i = 0; i < time.length; i++) {
      fill(78, 185, 205, 100);
      if(done) fill(69, 71, 84, 140);
      float temp_x = map(i, 0, time.length, min_x, max_x);
      float temp_y = map(time[i], 0, 11, pos_y, min_y - unit_y);
      vertex(temp_x, temp_y);
    }
    endShape(CLOSE);
  } 

  void loadData() {
    for (TableRow row : table.rows()) {
      String continent = row.getString("Continent");
      String country = row.getString("Country");
      String right2vote = row.getString("Year women got right to vote");
      int voteYear = 0;

      if (right2vote.length() == 4) { //right2vote.equals("..") == false
        voteYear = int(right2vote);
        myData.add(new Data(continent, country, voteYear));
      } else if (right2vote.length() > 4) {
        // severa years, it means the women's right to vote attained gradually
        String[] years = trim(split(right2vote, ","));
        int numYear = years.length;
        int firstYear = int(years[0]);
        int lastYear = int(years[numYear - 1]);

        voteYear = firstYear;
        myData.add(new Data(continent, country, voteYear));
      }
    }
  }
}

