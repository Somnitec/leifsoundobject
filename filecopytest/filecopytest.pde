import java.nio.file.*;

void setup(){
  size(100,100);
}

void draw(){
  
}

void keyPressed(){
  Path source = Paths.get(sketchPath("testfolder/test.txt"));
  Path destination = Paths.get(sketchPath("dest/dest.txt"));
  try{Files.copy(source, destination);println("copied");}catch (IOException e){println("couldn't copy");}
}