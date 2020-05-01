PVector arm(float f, float p, float a, float t) {
  // represents an arm of a harmonograph
  // f = frequency, p = phase, a = amplitude, t = time

  // the PVector.fromAngle function returns a unit vector pointing in a direction specified by an angle in radians
  // it is then multiplied by the amplitude a, to scale it to correct size
  return PVector.fromAngle((f * t + p) * TAU).mult(a);
}

float osc(float f, float p, float v, float d, float t) {
  // an oscillator function, it oscillates around a value (v), with deviation (d)
  // frequency (f), and phase (p)
  return v + d * sin((f * t + p) * TAU);
}

PVector example1(float t) {
  // this is how you simply add two arms (which are PVectors)
  // one of frequency 3, and the other of frequency -2 (rotating against the first)
  return arm(3, 0, 2, t).add(arm(-2, 0, 1, t));
}

PVector example2(float t) {
  // now we add an oscillator on the phase of the first arm
  // because our figure has five fold symmetry, we need a frequency that's a multiple of 5
  // we choose a low deviation of 0.1 and leave the phase and value at 0
  float p1 = osc(10, 0, 0, 0.1, t);
  return arm(3, p1, 2, t).add(arm(-2, 0, 1, t));
}

// the phase and the value of the oscillator can be chosen randomly
// and so can the phase of the second arm
float r0 = random(1), r1 = random(1), r2 = random(1);
PVector example3(float t) {
  float p2 = osc(10, r0, r1, 0.1, t);
  return arm(3, p2, 2, t).add(arm(-2, r2, 1, t));
}

void setup() {
  size(500, 500);
  background(0);
  noFill();
  stroke(255);
  
  int N_points = 4096;
  float scale = 50.0;
  PVector centre = new PVector(0.5 * width, 0.5 * height);

  beginShape();
  for (int i = 0; i < N_points; i++) {
    float t = (float) i / N_points;
    PVector p = example1(t); // p represents the (x, y) coordinate of our function at moment t
    p.mult(scale);
    p.add(centre);
    vertex(p.x, p.y);
  }
  endShape(CLOSE);
}
