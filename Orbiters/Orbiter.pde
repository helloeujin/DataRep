class Orbiter {
  
  float radius = 100;
  float theta = 0;
  float thetaSpeed = 0.01;
  float depth = 0;
  
  int generation = 0;
  
  ArrayList<Orbiter> children = new ArrayList();
  
  void update() {
    theta += thetaSpeed * flatness;
  }
  
  void render() {
    pushMatrix();
      rotate(theta);
      line(0, 0, 0, radius, 0, depth * (1-flatness));
      translate(radius, 0, depth * (1-flatness));    
      ellipse(0, 0, 5, 5);
      
      // render/update kids
      for(Orbiter kid:children) {
        kid.update();
        kid.render();
      }
    popMatrix();
  }
  
  void spawn() {
    // make between 1 and 3 kids
    for(int i = 0; i < ceil(random(3)); i++) {
      Orbiter kid = new Orbiter();
      children.add(kid);
      kid.thetaSpeed = random(-0.01, 0.01);
      kid.radius = random(50, 100);
      kid.generation = generation + 1;
      kid.depth = 50;
      if(generation < 4) {
        kid.spawn();
      }
    }
  }
}
