
int count = 100;
float[] data;
float roundness = 0;
float troundness = 0;

void setup() {
  size(1280, 720);
  background(255);
  smooth();
  data = new float[count];
  //make some fake data
  for(int i = 0; i < count; i++) {
    //data[i] = map(sin(i * 0.2), -PI, PI, 0, 100) + random(20);
    data[i] = map(noise(i * 0.1), 0, 1, 0, 100);
  }
}

void draw() {
  //roundness = map(mouseX, 0, width, 0, 1);
  roundness = lerp(roundness, troundness, 0.05);
  
  background(255);
  //make a bar chart
  for(int i = 0; i < count; i++) {
    float x = map(i, 0, count, 50, width - 50);
    float y = height/2;
    float h = map(data[i], 0, 100, 0, 200);
    
    pushMatrix();
      translate(width/2 * roundness, height/2);
      float r = map(i, 0, count, 0, TAU);
      rotate(r * roundness);
      rect(x * (1-roundness),0, 5, -h);
    popMatrix();
    //rect(x, y,5,-h);
  }
}

void keyPressed() {
  if(key == 'r') {
    troundness = (troundness == 0) ? (1):(0); // if true, it picks 1 / if not, picks 0
  }
}
