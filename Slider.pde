class Slider {
  float x, y, w, min, max, val, square=20;
  boolean moving = false, showNum = true;
  int deci;

  Slider(float x_, float y_, float w_, float min_, float max_, float val_, int deci_) {
    x=x_;
    y=y_;
    w=w_;
    val = val_;
    min=min_;
    max=max_;
    deci=deci_;
  }
  void draw() {
    pushMatrix();
    strokeWeight(5);
    stroke(100, 100, 100, 100);
    line(x, y, x+w, y);
    noStroke();
    fill(50, 50, 50);
    if (moving) {
      fill(90, 90, 90);
    }
    rect(x-square/2+(val-min)*w/(max-min), y-square/2, square, square);
    fill(50, 50, 50);
    if (showNum) {
      if (deci!=-1) {
        text(String.format("%."+deci+"f", val), x+w+30, y);
      } else {
      text(floor(val), x+w+30, y);
      }
    }
    popMatrix();
  }
  void pressed() {
    float x1 = x-square/2+(val-min)*w/(max-min);
    float y1 = y-square/2;
    float mX = mouseX;
    float mY = mouseY;
    if (mX>x1&&mX<x1+square&&mY>y1&&mY<y1+square) {
      moving = true;
    }
  }
  void update() {
    if (mousePressed==true) {
      if (moving==true) {
        val = (max-min)*(mouseX-x)/w+min;
        if (val<min) {
          val = min;
        } else if (val>max) {
          val = max;
        }
      }
    } else {
      moving = false;
      drawX();
    }
  }
}
