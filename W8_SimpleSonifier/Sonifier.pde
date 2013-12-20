import beads.*;

class Sonifier {
  
  AudioContext ac;
  String country;
  float[] numbers = new float[5];;
  float maxNum = 0;
  float minNum = 0;
  float lowFreq = 0;
  float highFreq = 0;
  
  float pace = 100;
  float decay = 60; // lingering time
  int count = 0;
  color fore = color(255,30,0);
  color back = color(0,0,0);
  float num_0 = 0;
  float num_1 = 0;
  float num_2 = 0;
  float num_3 = 0;
  float num_4 = 0;
  
  int cnt = 0;

  Sonifier() {
  }

  void init(float low, float high, float p) {
    lowFreq = low;
    highFreq = high;
    pace = p;
    //numbers = na;
    //maxNum = max(numbers);
    //minNum = min(numbers);
    maxNum = 100;
    minNum = 0;
    ac = new AudioContext();

    Clock clock = new Clock(ac, pace);
    clock.addMessageListener(
      new Bead() {
        public void messageReceived(Bead message) {
          Clock c = (Clock)message;
          if(c.isBeat()) {
            WavePlayer wp = new WavePlayer(ac,(float) map(numbers[count],minNum,maxNum,lowFreq,highFreq),Buffer.SINE);
            Gain g = new Gain(ac, 1, new Envelope(ac, 0.1));
            ((Envelope)g.getGainEnvelope()).addSegment(0, decay, new KillTrigger(g));
            g.addInput(wp);
            ac.out.addInput(g);
            count++;
            if (count == numbers.length) count = 0 ;
          }
        }
      }
    );
    ac.out.addDependent(clock);
  }
  
  void start() {
    ac.start(); 
  }
  
  void stop() {
    ac.stop(); 
  }

  void render() {
    stroke(150);
    strokeWeight(0.8);
    beginShape();
    stroke(252, 37, 70, 180);
    noFill();
    for(int i = 0; i < numbers.length; i++) {
      float x = map(i, 0, numbers.length-1, width*0.2, width*0.9);
      float y = map(numbers[i], 0, 100, height*0.4, height*0.9);
      vertex(x, y);
    }
    endShape();
    
    fill(80);
    textFont(myFont);
    textSize(16);
    for(int i = 0; i < numbers.length; i++) {
      float x = map(i, 0, numbers.length-1, width*0.2, width*0.9);
      float y = map(numbers[i], 0, 100, height*0.4, height*0.9);
      if(i == 0) text("Eat fruits", x+8, y);
      if(i == 1) text("Eat breakfast", x+8, y);
      if(i == 2) text("Excercise", x+8, y);
      if(i == 3) text("Life satisfaction", x+8, y);
      if(i == 4) text("Like school", x+8, y);
    }
    
    rectMode(CENTER);
    for(int i = 0; i < numbers.length; i++) {
      float x = map(i, 0, numbers.length-1, width*0.2, width*0.9);
      float y = map(numbers[i], 0, 100, height*0.4, height*0.9);
      fill(0, 238, 217, 180);
      stroke(20);
      strokeWeight(0.5);
      rect(x, y, 5, 5);
    }
    rectMode(CORNER);


    /*
    loadPixels();
    java.util.Arrays.fill(pixels, back);
    for(int i = 0; i < width; i++) {
      int buffIndex = i * ac.getBufferSize() / width;
      int vOffset = (int)((1 + ac.out.getValue(0, buffIndex)) * height / 2);
      pixels[vOffset * height + i] = fore;
    }
    updatePixels();
    */
  }
  
  void init_start() {
    numbers[0] = num_0;
    numbers[1] = num_1;
    numbers[2] = num_2;
    numbers[3] = num_3;
    numbers[4] = num_4;
  }
}

