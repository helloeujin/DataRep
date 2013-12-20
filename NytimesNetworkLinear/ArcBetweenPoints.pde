void arcBetweenPoints(PVector start, PVector end) {
  //ellipse(start.x, start.y, 5, 5);
  //ellipse(end.x, end.y, 5, 5);
  PVector middle = new PVector(start.x, start.y, start.z);
  middle.lerp(end, 0.5);
  rect(middle.x, middle.y, 5, 5);
  
  pushMatrix();
    translate(middle.x, middle.y, middle.z);
    float d = start.dist(end);
    arc(0, 0, d, d, PI, TAU);
    //arc(0, 0, d, d, PI, PI + (PI * fraction);
  popMatrix();
}

void arcBetweenPoints(PVector start, PVector end, float fraction) {
  //ellipse(start.x, start.y, 5, 5);
  //ellipse(end.x, end.y, 5, 5);
  PVector middle = new PVector(start.x, start.y, start.z);
  middle.lerp(end, 0.5);
  rect(middle.x, middle.y, 5, 5);
  
  pushMatrix();
    translate(middle.x, middle.y, middle.z);
    float d = start.dist(end);
    //arc(0, 0, d, d, PI, TAU);
    arc(0, 0, d, d, PI, PI + (PI * fraction));
  popMatrix();
}
