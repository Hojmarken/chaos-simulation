Slider sliderF;
Slider sliderP;
int scale = 1;
int w = 800;
int h = 725;
boolean[][] drawArray;
PVector[] points;
PVector pointer;
int iterations = 200000;
int counter = 0;
float factor;
float holder = 0;
float holderP = 0;
int poly = 5;

  
void setup() {
  size(800, 725);
  textAlign(CENTER, CENTER);
  sliderF = new Slider(50, 700, 200, 0, 1, 0.63, 2);
  sliderP = new Slider(50, 660, 200, 3, 8, 5.67, 1);
  drawFrame();
}

void draw() {
  sliderP.update();
  sliderF.update();
  if (factor!=sliderF.val||floor(sliderP.val)!=poly) {
    drawFrame();
  }
  if (sliderP.val!=holderP) {
    drawX();
  }
}

void drawFrame() {
  factor = sliderF.val;
  poly = floor(sliderP.val);
  holderP = sliderP.val;
  createChaosMap();
  drawX();
}

void drawX() {
  background(255);
  drawChaos();
  sliderF.draw();
  sliderP.draw();
}

void createChaosMap() {
  drawArray = new boolean[h][w];
  points = trianglePoints(poly);
  pointer = new PVector(points[0].x+1, points[0].y+1);
  while (counter<iterations) {
    counter++;
    chaosIteration();
  }
  counter = 0;
}

void mousePressed() {
  sliderF.pressed();
  sliderP.pressed();
}

void keyPressed() {
  if (keyCode==32) {
    drawFrame();
  }
}

PVector[] trianglePoints(int amount) {
  float d = 300;
  PVector[] p = new PVector[amount];
  int count = 0;
  for (int i=0; i<amount; i++) {
    float ang = i*TWO_PI/amount;
    float x=width/2+cos(ang)*d, 
      y=height/2+sin(ang)*d;
    p[count] = new PVector(x, y);
    count++;
  }
  return p;
}

void drawChaos() {
  int sizeHolder = 0;
  loadPixels();
  for (int i=0; i<h; i++) {
    for (int j=0; j<w; j++) {
      if (drawArray[i][j]) {
        pixels[sizeHolder+j] = #000000;
      }
    }
    sizeHolder+=w;
  }
  updatePixels();
}

void chaosIteration() {
  int num = floor(random(0, points.length));
  pointer.x=pointer.x+(points[num].x-pointer.x)*factor;
  pointer.y=pointer.y+(points[num].y-pointer.y)*factor;
  if (!drawArray[floor(pointer.y)][floor(pointer.x)]) {
    drawArray[floor(pointer.y)][floor(pointer.x)] = true;
  }
}
