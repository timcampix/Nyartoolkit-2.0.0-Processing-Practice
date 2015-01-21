import processing.video.*;
import jp.nyatla.nyar4psg.*;
import saito.objloader.*;



Capture cam;
MultiMarker nya;
OBJModel model;
//PImage tex;


void setup() {
  size(640, 480, P3D);
  colorMode(RGB, 100);
  frameRate(25);
  println(MultiMarker.VERSION);
  cam=new Capture(this, 640, 480);
  nya= new MultiMarker(this, width, height, "camera_para.dat", NyAR4PsgConfig.CONFIG_PSG);
  nya.addARMarker("patt.hiro", 80);
  model=new OBJModel (this, "BL_WHALE.obj", "absolute", TRIANGLES);
  //MTL file delete everything between map_Kd and texture.jpg
  
  model.enableDebug();
  // tex=loadImage("BL_WHALEtexture.jpg");
  model.scale(5);
  model.translateToCenter();
  model.enableTexture();
  noStroke();
  cam.start();
}
void draw() {
  if (cam.available()!=true) {
    return;
  }
  cam.read();
  nya.detect(cam);
  nya.drawBackground(cam);
  if ((!nya.isExistMarker(0))) {
    return;
  }

  nya.beginTransform(0);
  lights();
  model.draw();
  nya.endTransform();

  if (keyPressed) {
    if (key=='s') {
      
      saveFrame("thrD-####");
      println("saved");
      if (frameRate<250){ //25*10=250frames
        noLoop();
      }
    }
  }
}

