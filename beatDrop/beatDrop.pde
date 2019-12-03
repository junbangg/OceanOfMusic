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

Table table;
int i = 0;

void setup()
{
  size(1000, 1000, P3D);
  
  table = new Table();
  
  table.addColumn("#");
  table.addColumn("eRadius");
  //table.addColumn("duration");
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
  
  //eRadius = 20;
  
}

void newRow(float eRadius) {
  
  TableRow newRow = table.addRow();
  newRow.setInt("#", table.getRowCount() - 1);
  newRow.setFloat("eRadius", eRadius);
  //newRow.setInt("duration", song.position());
  saveTable(table, "data/data.csv");
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
  if ( beat.isOnset() ) {
    //println(song.position());
    eRadius = 80;
  }
  
  //println(eRadius);
  //newRow(eRadius);
  
  //if (eRadius> 75 && eRadius<81) {
  if (eRadius> 70 && eRadius<81) {  
    
    if (pressSwitch == true) {
      before[(int)random(1000)][(int)random(1000)] = 255;
      before[(int)random(1000)][(int)random(1000)] = 255;
      before[(int)random(1000)][(int)random(1000)] = 255;
      //before[(int)random(250,750)][(int)random(250,750)] = 255;
      //before[(int)random(400,600)][(int)random(400,600)] = 255;
      //before[(int)random(400)][(int)random(400)] = 255;
      //before[(int)random(100)][(int)random(100)] = 255;
    }
    else {
      before[(int)random(1000)][(int)random(1000)] = 255;
      before[(int)random(1000)][(int)random(1000)] = 255;
      before[(int)random(1000)][(int)random(1000)] = 255;
      before[(int)random(1000)][(int)random(1000)] = 255;
      before[(int)random(1000)][(int)random(1000)] = 255;
    }
    
  }
  //if (eRadius 
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
        pixels[index] = color(before[i][j],current[i][j],70);
      }
    }
   
   if(eRadius == 20) {
      rect(200,800,200,800); 
   }
  updatePixels();

  float[][] temp = before;
  before = current;
  current = temp;
  
}
