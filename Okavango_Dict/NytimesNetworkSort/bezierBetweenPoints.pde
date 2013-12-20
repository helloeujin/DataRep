void bezierBetweenPoints(PVector start, PVector end, PVector middle) {
  PVector cp1 = new PVector(start.x, start.y, start.z);// control points  
  cp1.lerp(middle, 0.5);
  
  PVector cp2 = new PVector(end.x, end.y, end.z);// control points 
  cp2.lerp(middle, 0.5);
  
  bezier(start.x, start.y, cp1.x, cp1.y, cp2.x, cp2.y, end.x, end.y); // anchor, control 
}
