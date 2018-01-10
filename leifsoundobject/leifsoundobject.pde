

import ddf.minim.*;
import ddf.minim.ugens.*;

Minim minim;
AudioInput in;
AudioRecorder recorder;
boolean recorded;

AudioOutput out;
AudioPlayer player;


int buttonheldtime = 1000;

int currentkey;
int timer;

boolean testval = false;

void setup()
{
  size(512, 200, P3D);

  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO, 2048);
  //player = new Sampler( "recording00.wav",1,minim);
  player = minim.loadFile("recording00.wav");


  //out = minim.getLineOut( Minim.STEREO );
  //player.patch( out );

  player.play();

  textFont(createFont("Arial", 12));
}

void draw()
{
  background(0); 
  stroke(255);
  // draw the waveforms
  // the values returned by left.get() and right.get() will be between -1 and 1,
  // so we need to scale them up to see the waveform
  for (int i = 0; i < in.left.size()-1; i++)
  {
    line(i, 50 + in.left.get(i)*50, i+1, 50 + in.left.get(i+1)*50);
    line(i, 150 + in.right.get(i)*50, i+1, 150 + in.right.get(i+1)*50);
  }
  /*
  if ( player.isPlaying() )
   {
   text("playing.", 10, 20 );
   } else
   {
   text("notplaying.", 10, 20 );
   }*/
  /*
  if ( recorder.isRecording() )
   {
   text("Now recording, press the r key to stop recording.", 5, 15);
   } else if ( !recorded )
   {
   text("Press the r key to start recording.", 5, 15);
   } else
   {
   text("Press the s key to save the recording to disk and play it back in the sketch.", 5, 15);
   }
   */
  //println(player.position());

  if (testval) {
    println("playing");
    testval=false;

    player = minim.loadFile("recording"+currentkey+".wav");
    player.play();
  }
}

void keyPressed() {
  currentkey = key;
  timer = millis();
  println("start recording "+currentkey);
  //recorder.endRecord(); //reset the recording
  recorder = minim.createRecorder(in, "recordingtemp.wav");//restart the recording
  recorder.beginRecord();
}

void keyReleased()
{
  if (key==currentkey) {
    if (millis()-timer>buttonheldtime) {
      println("recorded "+currentkey);
      recorder.endRecord();
      //save recording
      recorder.save();
      println("Done saving.");


      String oldname=dataPath(dataPath("recordingtemp.wav"));
      File ff=new File(oldname);
      String newname=dataPath(dataPath("recording"+currentkey+".wav"));
      ff.renameTo(new File(newname));
      

      println("Done renaming.");
    } else {

      recorder.endRecord();
      recorder.save();
      //recorder.endRecord();
      println("playing"+currentkey+".wav");

      testval=true;
      //trash recording
      //player = new FilePlayer( minim.loadFileStream("recording"+currentkey+".wav") );
      /*
      player = new Sampler("\recording"+currentkey+".wav",1,minim);
       player.patch( out );
       player.trigger();
       */
    }
  } else println("releasing a button which was not the last one to be pressed");


  /*

   if ( !recorded && key == 'r' ) 
   {
   if ( recorder.isRecording() ) 
   {
   recorder.endRecord();
   recorded = true;
   } else 
   {
   recorder.beginRecord();
   }
   }
   if ( recorded && key == 's' )
   {
   if ( player != null )
   {
   player.unpatch( out );
   player.close();
   }
   player = new FilePlayer( recorder.save() );
   player.patch( out );
   player.play();
   }
   */
}