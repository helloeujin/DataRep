Orbiter seed = new Orbiter();

float flatness = 1;
float tflatness = 1;

void setup() {
  size(1280, 720, P3D);
  smooth();
  seed.spawn();
}

void draw() {
  
  flatness = lerp(flatness, tflatness, 0.1);
  
  background(255);
  translate(width/2, height/2 + (300 * (1 - flatness)));
  rotateX(PI/2 * (1-flatness));
  seed.update();
  seed.render();
}

void keyPressed() {
  if(key == 'f') {
    tflatness = (tflatness == 0) ? 1:0;
  }
}
