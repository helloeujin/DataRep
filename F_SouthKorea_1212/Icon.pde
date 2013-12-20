class Icon {

   PVector pos = new PVector();
   PVector tpos = new PVector();
   float diameter = 50;
   boolean clicked = false;
   float opac = 255;
  
   Icon() {
   }
   
   void update() {
     pos.lerp(tpos, 0.1);
   }
   
   void render() {
   }
   
   void displayArrow() {
     opac=opac-2;
     if(opac<-255) opac = 255;
     pushMatrix();
       translate(pos.x, pos.y, pos.z);
       noFill();
       stroke(#FF9900, opac);
       strokeWeight(2);
       triangle(0, 0, -10, -12, -10, 12);
     popMatrix();
   }
   
   void checkClicked() {
     if(pos.dist(mpos) < 20 && mousePressed)  clicked = true;
   }
}
