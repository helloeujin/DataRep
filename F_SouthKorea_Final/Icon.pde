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
   
   void displayArrow2() {
     opac=opac-6;
     if(opac<-255) opac = 255;
     pushMatrix();
       translate(pos.x, pos.y, pos.z);
       //noFill();
       //stroke(#FF9900, opac);
       //strokeWeight(2);
       //fill(#FF9900, opac);
       fill(#FF9900);
       noStroke();
       triangle(0, 0, -9, -32, 9, -32);
     popMatrix();
   }
   
   void displayArrow3() {
     opac=opac-6;
     if(opac<-255) opac = 255;
     pushMatrix();
       translate(pos.x, pos.y, pos.z);
       noFill();
       stroke(#FF9900, opac);
       strokeWeight(2);
       triangle(0, 0, -4, -6, -4, 6);
       
       //fill(#FF9900,240);
       fill(140);
       textAlign(RIGHT, CENTER);
       textSize(24);
       text("home", -10, 0);
     popMatrix();
   }
   
   void checkClicked() {
     if(pos.dist(mpos) < 50 && mousePressed)  {
       clicked = true;
     }
   }
}
