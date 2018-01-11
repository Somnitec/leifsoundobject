import processing.serial.*;

import cc.arduino.*;

Arduino arduino;

color on = color(4, 20, 50);
color off = color(200, 145, 158);

int pinAmount =100;

void setup() {
  size(880, 540);

  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[3], 57600);
  for (int i = 0; i <= pinAmount; i++)
    arduino.pinMode(i, Arduino.INPUT_PULLUP);
}

void draw() {
  background(255,255,255);
  stroke(on);
  for (int i = 0; i <= pinAmount; i++) {
    if (arduino.digitalRead(i) == Arduino.HIGH)
      fill(on);
    else
      fill(off);

    text(i,100 + (i % 8) * 30, 30 + (i ) / 8 * 30);
  }
}


//A3 =57 , A4=58