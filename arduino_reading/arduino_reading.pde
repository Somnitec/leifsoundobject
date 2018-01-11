import processing.serial.*;

Serial myPort;    // The serial port
String inString;  // Input string from serial port
int lf = 10;      // ASCII linefeed
int pinAmount =70;
String previousinString;

color on = color(4, 20, 50);
color off = color(200, 145, 158);

String[] pinMapping = new String[pinAmount];


void setup() {
  previousinString="1111111111111111111111111111111111111111111111111111111111111111111111";
  mapPins();


  size(880, 540);
  // List all the available serial ports:
  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[3], 9600);
  myPort.bufferUntil(lf);
}

void draw() {
  background(255);
  text("received: " + inString, 10, 500);
  stroke(on);
  for (int i = 0; i < pinAmount; i++) {
    if (inString.charAt(i) == '1')
      fill(on);
    else
      fill(off);

    text(pinMapping[i], 100 + (i % 8) * 30, 30 + (i ) / 8 * 30);
    if (previousinString.charAt(i)=='1'&&inString.charAt(i)=='0' )buttonPressed(i);
    if (previousinString.charAt(i)=='0'&&inString.charAt(i)=='1' )buttonReleased(i);
  }
  previousinString=inString;
}

void buttonPressed(int button){
  println("pressed "+pinMapping[button]);
}

void buttonReleased(int button){
  println("released "+pinMapping[button]);
}

void serialEvent(Serial p) {
  inString = p.readString();
}

void mapPins() {
  for (int i = 0; i < pinAmount; i++) {
    pinMapping[i]="";
  }
  pinMapping[22]="A1";
  pinMapping[23]="A2";
  pinMapping[24]="A3";
  pinMapping[25]="A4";
  pinMapping[26]="A5";
  pinMapping[27]="A6";
  pinMapping[28]="A7";
  pinMapping[29]="A8";
  pinMapping[32]="B1";
  pinMapping[33]="B2";
  pinMapping[34]="B3";
  pinMapping[35]="B4";
  pinMapping[36]="B5";
  pinMapping[37]="B6";
  pinMapping[38]="B7";
  pinMapping[39]="B8";
  pinMapping[2]="C1"; 
  pinMapping[3]="C2"; 
  pinMapping[4]="C3"; 
  pinMapping[5]="C4";
  pinMapping[6]="C5";
  pinMapping[7]="C6";
  pinMapping[8]="C7";
  pinMapping[9]="C8";

  pinMapping[54]="D1";
  pinMapping[55]="D2";
  pinMapping[56]="D3";
  pinMapping[57]="D4";
  pinMapping[58]="D5";
  pinMapping[59]="D6";
  pinMapping[60]="D7";
  pinMapping[61]="D8";
  pinMapping[62]="E1";
  pinMapping[63]="E2";
  pinMapping[64]="E3";
  pinMapping[65]="E4";
  pinMapping[66]="E5";
  pinMapping[67]="E6";
  pinMapping[68]="E7";
  pinMapping[69]="E8";
  pinMapping[46]="F1";
  pinMapping[47]="F2";
  pinMapping[48]="F3";
  pinMapping[49]="F4";
  pinMapping[50]="F5";
  pinMapping[51]="F6";
  pinMapping[52]="F7";
  pinMapping[53]="F8";
}