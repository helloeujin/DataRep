float[] nums = {4, 4, 4, 3, 2.5, 6, 6, 6, 4.5, 6, 3, 3, 6, 7, 8, 5, 2.5};

void setup() {
 size(1280, 720); 
 background(0);
 
 stroke(255);
 
 for(int i = 0; i < nums.length; i++) { // count
   float n = nums[i];
   float x = map(i, 0, nums.length, 100, width-100);
   float h = map(n, 0, 10, 0, height);
   
   float d = map(sqrt(n), 0, sqrt(10), 0, 100);
   ellipse(x, height/2, d, d);
   //rect(x, height, 10, -h);
   //line(x, height, x, height-h);
 }
 
// for(float n:nums) { // easier, faster
//   
// }
}

void draw() {
  
}
