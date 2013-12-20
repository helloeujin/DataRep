/* 
 
 Week 2 assignment
 Resource at Guardian Data store
 http://www.theguardian.com/news/datablog/interactive/2013/jan/14/all-our-datasets-index
 
*/

Table table;
int totalRow;
DataSet mySet;

PFont mono;
float unit_x = 1280*0.05;
float unit_y = 720*0.1;

void setup() {
  size(1280, 720);
  background(0);
  mono = loadFont("Helvetica-48.vlw");

  // load table
  table = loadTable("Final.csv", "header"); 
  totalRow = table.getRowCount();
  
  // get DataSet
  mySet = new DataSet();
}

void draw() {
  background(69, 71, 84);
  
  fill(78, 78, 95);
  noStroke();
  rect(0, 0, width, unit_y*1.8);
  
  fill(245, 247, 255);
  noStroke();
  textFont(mono);
  textSize(32);
  
  textAlign(CENTER);
  text("WOMEN GOT RIGHT TO VOTE", width/2, unit_y*1.45);
  
  mySet.display();
}

void guideline() { 
  stroke(255, 0, 0);
  line(unit_x, 0, unit_x, height);
  line(width-unit_x, 0, width-unit_x, height);
}

void mouseClicked() {
  
  if(mouseY < unit_y*1.8) {
    if(mySet.done == false) {
       mySet.selectedYear = 2010;
       mySet.done = true;
    }
//   else if(mySet.done == true) {
//       mySet.done = false;
//       mySet.selectedYear = 1890; 
//    }
  }
}


