

import ddf.minim.*;
import ddf.minim.ugens.*;
import java.util.Date;
import java.io.*;
import java.nio.file.*;

Minim minim;
AudioInput in;
AudioRecorder recorder;
boolean recorded;

AudioOutput out;
AudioPlayer player;


AudioPlayer beep;
AudioPlayer boop;

String currentButton;

String file;

int buttonheldtime = 1000;
int timer;

import processing.serial.*;

Serial myPort;    // The serial port
String inString;  // Input string from serial port
int lf = 10;      // ASCII linefeed
int pinAmount =70;


String previousinString;

color on = color(4, 20, 50);
color off = color(200, 145, 158);

String[] pinMapping = new String[pinAmount];


void setup()
{
  size(800, 200, P3D);

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 2048);

  out   = minim.getLineOut();
  player = minim.loadFile(sketchPath("temp/temp.wav"));

  previousinString="1111111111111111111111111111111111111111111111111111111111111111111111";

  mapPins();

  printArray(Serial.list());
  // Open the port you are using at the rate you want:
  myPort = new Serial(this, Serial.list()[3], 9600);
  myPort.bufferUntil(lf);
}


void serialEvent(Serial p) {
  inString = p.readString();
}

void draw()
{
  
  background(0); 
  stroke(255);
  text("received: " + inString, 10, 20);
  
  for (int i = 0; i < in.left.size()-1; i++)
  {
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
  for (int i = 0; i < pinAmount; i++) {
    if (previousinString.charAt(i)=='1'&&inString.charAt(i)=='0' )buttonPressed(i);
    if (previousinString.charAt(i)=='0'&&inString.charAt(i)=='1' )buttonReleased(i);
  }
  previousinString=inString;
}

void buttonPressed(int button) {
  
  
  player.close();
  currentButton = pinMapping[button];
  println("pressed "+currentButton);
  timer = millis();

  //createOutput(sketchPath(currentkey+"/nothi.ng"));
  if (new File(sketchPath(currentButton+"")).mkdirs())println("folder created");
  else println("folder failed");

  file = sketchPath(currentButton+"/leifinstallationrecording-"+day()+"."+month()+"."+year()+"-"+hour()+"."+minute()+"."+second()+".wav");
  recorder = minim.createRecorder(in, sketchPath("temp/temp.wav"));//restart the recording
  recorder.beginRecord();
  println("started recording to "+file);
}

void buttonReleased(int button) {
  
  println("released "+pinMapping[button]);
  if (pinMapping[button]==currentButton) {
    recorder.endRecord();
    //save recording
    recorder.save();

    //recorder = minim.createRecorder(in, "waste.wav");

    if (millis()-timer>buttonheldtime) {

      Path source = Paths.get(sketchPath("temp/temp.wav"));

      Path destination = Paths.get(file);
      try {
        Files.copy(source, destination);
        println("copied");
      }
      catch (IOException e) {
        println("couldn't copy");
      }

      println("long press -> recorded file");
    } else {
      println("short press -> playback");


      file=""+lastFileModified(sketchPath(currentButton+""));
      println("playing most recent file "+file);
      player = minim.loadFile(file);
      player.play();
    }
  } else println("another button was pressed in the mean time");

}


void keyPressed() {
  //buttonPressed(key);

  /*
  if(currentkey ==97){
   beep.rewind();
   beep.play();
   }
   if(currentkey ==115){
   boop.rewind();
   boop.play();
   }
   println("start recording ");
   //recorder.endRecord(); //reset the recording
   
   file = sketchPath(currentkey+"\\leifinstallationrecording-"+day()+"."+month()+"."+year()+"-"+hour()+"."+minute()+"."+second()+".wav");
   println(file);
   
   createOutput(file);
   println("created ");
   recorder = minim.createRecorder(in, file);//restart the recording
   recorder.beginRecord();
   */
}


void keyReleased() {
  //buttonReleased(key);
  /*
  recorder.endRecord();
   //save recording
   recorder.save();
   
   player = minim.loadFile(file);
   player.play();
   */
}



public static File lastFileModified(String dir) {
  File fl = new File(dir);
  File[] files = fl.listFiles(new FileFilter() {          
    public boolean accept(File file) {
      return file.isFile();
    }
  }
  );
  long lastMod = Long.MIN_VALUE;
  File choice = null;
  for (File file : files) {
    if (file.lastModified() > lastMod) {
      choice = file;
      lastMod = file.lastModified();
    }
  }
  return choice;
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