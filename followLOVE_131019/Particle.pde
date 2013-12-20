class Particle {
  
  // Fireworks class 
  PVector position;
  PVector velocity;
  PVector acceleration;
  float opac = 200;
  
  
  Particle() {
    position = new PVector();
    velocity = new PVector();
    acceleration = new PVector();
  }

  void update() {
    acceleration = new PVector(random(-0.1, 0.1), random(-0.1, 0.1));    
    acceleration.normalize(); 
    acceleration.mult(0.11); // number changes -> speed of fireworks
    velocity.add(acceleration);
    position.add(velocity);
    opac = opac - 1.9;
    if(opac<0) opac = 0;
  }
  
  void render() {
    fill(random(255), random(255), random(255), opac);
    noStroke();
    ellipse(position.x, position.y, 2, 2);
  }
}

