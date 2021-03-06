

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

int currentkey;

String file;

int buttonheldtime = 1000;
int timer;

void setup()
{
  size(512, 200, P3D);

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 2048);

  out   = minim.getLineOut();
  player = minim.loadFile(sketchPath("temp/temp.wav"));


  //beep = minim.loadFile("beep.mp3");
  //boop =  minim.loadFile("booper.wav" );


  //println("the newest file is "+lastFileModified(sketchPath("97")));
}


void draw()
{
  background(0); 
  stroke(255);
  for (int i = 0; i < in.left.size()-1; i++)
  {
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
}

void keyPressed() {
  player.close();
  currentkey = key;
  println(currentkey);
  timer = millis();

  //createOutput(sketchPath(currentkey+"/nothi.ng"));
  if (new File(sketchPath(currentkey+"")).mkdirs())println("folder created");
  else println("folder failed");

  file = sketchPath(currentkey+"\\leifinstallationrecording-"+day()+"."+month()+"."+year()+"-"+hour()+"."+minute()+"."+second()+".wav");
  recorder = minim.createRecorder(in, sketchPath("temp/temp.wav"));//restart the recording
  recorder.beginRecord();
  println("started recording to "+file);

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
  if (key==currentkey) {
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


      file=""+lastFileModified(sketchPath(currentkey+""));
      println("playing most recent file "+file);
      player = minim.loadFile(file);
      player.play();
    }
  } else println("another button was pressed in the mean time");

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