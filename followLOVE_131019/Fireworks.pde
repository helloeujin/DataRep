class Fireworks {
  
  ArrayList<Particle> myParticle= new ArrayList();
  float x = 0;
  float y = 0;
  int cnt = 0;
  
  Fireworks() {
    for(int i = 0; i < 200; i ++) {
       Particle p = new Particle();
       myParticle.add(p);
    }
  }
  
  void update() {
   cnt++; 
   int num = 2;
   if(cnt > num) myParticle.remove(cnt-num);     
  }
  
  void display() {
    pushMatrix();
    for(int i = 0; i< myParticle.size(); i++) {
       Particle p = myParticle.get(i);
       p.update();
       p.render(); 
    }
    popMatrix();
  }
}
