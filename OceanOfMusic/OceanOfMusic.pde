import ddf.minim.*;
import ddf.minim.analysis.*;

float[][] before;
float[][] current;

int r;
int c;

Minim minim;
AudioPlayer song;
BeatDetect beat;

float eRadius;
boolean pressSwitch = true;

void setup()
{
  size(1000, 1000, P3D);
  
  
  //frameRate(1);
  r = height;
  c = width;

  current = new float[c][r];
  before = new float[c][r];
  
  
  minim = new Minim(this);
  song = minim.loadFile("015b.mp3", 2048);
  song.play();
  // a beat detection object song SOUND_ENERGY mode with a sensitivity of 10 milliseconds
  beat = new BeatDetect();
  
  ellipseMode(RADIUS);
  eRadius = 20;
}

void mouseClicked() {
    pressSwitch = false;
}

void draw()
{
  background(0);
  beat.detect(song.mix);
  //float a = map(eRadius, 20, 80, 60, 255);
  //fill(60, 255, 0, a);
  if ( beat.isOnset() ) eRadius = 80;
  
  if (eRadius> 79 && eRadius<81) {
    before[(int)random(1000)][(int)random(1000)] = 255;
  }
  
  if(pressSwitch == true) { 
    eRadius *= 0.95;
    if ( eRadius < 20 ) eRadius = 20;
  }
  
  //if ( eRadius < 20 && pressSwitch == true) eRadius = 20; 
   
  
  //여기부터 inst 아니면 목소리 나올 때부터 
  //if ( eRadius < 20 ) eRadius = 20;
  //println(eRadius);
  
  loadPixels();
    for (int i = 1; i < c - 1; i++) {
      for (int j = 1; j < r - 1; j++) {

        current[i][j] = (before[i + 1][j]
          + before[i - 1][j]
          + before[i][j - 1]
          + before[i][j + 1]) / 2
          - current[i][j];

        int index = i + j * c;
        //black version
        //pixels[index] = color(current[i][j]);
        //blue version
        pixels[index] = color(before[i][j],current[i][j],50);
      }
    }
  updatePixels();

  float[][] temp = before;
  before = current;
  current = temp;
  
}
