/**
 *Keegan Poon
 *17/12/2014
 *Megaman.EXE Clone
 */
//V2

import ddf.minim.*;
Minim minim;
AudioPlayer player;

PImage tilesheet;
PImage[][] tiles;
PImage playerOne;
PImage playerTwo;
Navi naviM;
//Object naviN;
Tile[][] battlefield;
int fieldX;
int fieldY;
int fieldPosX;
int fieldPosY;
int tileX;
int tileY;
int[] defaultTileSet;
int scaleOf;

Tile getTile(int x, int y) {
  return battlefield[x][y];
}
Tile[][] getField() {
  return battlefield;
}

void setup() {
  //set background music and loop points in the music
  /*minim = new Minim(this);
  player = minim.loadFile("background.mp3");
  player.play();
  player.loop();
  player.setLoopPoints(1300, 44000);
  */
  //variable setup
  scaleOf = 2;
  tilesheet = loadImage("tilesheet.png");
  size(400*scaleOf, 300*scaleOf);
  frameRate(240);
  fieldX = 6;
  fieldY = 3;
  tileX = 80;
  tileY = 50;
  battlefield = new Tile[fieldX][fieldY];
  tiles = new PImage[14][24];
  defaultTileSet = new int[2];
  defaultTileSet[0] = 0;
  defaultTileSet[1] = 2;
  playerOne = loadImage("megamanMove.png");
  playerTwo = loadImage("megamantest.png");
  naviM = new Navi(true, 1, 1, playerOne, scaleOf, this);
  fieldPosX = width/2 - 40*scaleOf * fieldX/2;
  fieldPosY = (int)(height/2 + 25*scaleOf * fieldY/2.0);
  //setup horizontal tiles
  for (int i = 0; i < fieldX; i++) {


    //set which side the tile is for
    boolean redSide;
    if (i<(fieldX/2)) {
      redSide = true;
    } else {
      redSide = false;
    }


    //setup vertical tiles
    for (int j = 0; j < fieldY; j++) {
      battlefield[i][j] = new Tile(i*40*scaleOf+fieldPosX, j*25*scaleOf+fieldPosY, redSide, defaultTileSet, scaleOf); 
      //i = panel number horizontal j = vertical
      //40 default tile width, scaleOf scale of the field
      //fieldPosX/Y where the field is located
    }
  }

  //setup tile sprites
  //7 tiles sideways and 24(3*8)
  for (int i = 0; i < 24; i++) {
    for (int j = 0; j <14; j++) {
      tiles[j][i] = tilesheet.get((j*43)+3, i*28+3, 40, 25);
      tiles[j][i].resize(0, tiles[j][i].height*scaleOf);
    }
  }
}

void draw() {
  background(0);
  displayField();
  naviM.update();
}

void displayField() {

  for (int i = 0; i < fieldX; i++) {
    for (int j = 0; j < fieldY; j++) {
      int spriteColour;
      if (battlefield[i][j].getRedTeam()) {
        spriteColour = 0;
      } else {
        spriteColour = 7;
      }
      if (battlefield[i][j].panelType()[1] == 0) {//if it's default cracked ice grass (0)
        battlefield[i][j].display(tiles[  battlefield[i][j].panelType()[0] + spriteColour  ]   [battlefield[i][j].panelType()[1]*3 + j]  );
        //tiles (horizonal type value) 
        //(vertical Value * 3(each panel has 3 versions) 
        //+ j(which of the 3 versions it needs)
      } else if (battlefield[i][j].panelType()[1] >= 1) {//animated tiles (poison, holy)
        battlefield[i][j].display(tiles[  battlefield[i][j].panelType()[0] + spriteColour+ battlefield[i][j].getStage() ]   [battlefield[i][j].panelType()[1]*3 + j]  );
        //tiles (horizonal type value)+ animation cycle stage
      }
      battlefield[i][j].toggleStage();
    }
  }
  //runs through field array and runs each tile's display command
}



void keyPressed()
{
  if (key == CODED) {

    if (keyCode == UP) {
      naviM.setDir("up");
    } else if (keyCode == DOWN) {
      naviM.setDir("down");
    } else if (keyCode == LEFT) {
      naviM.setDir("left");
    } else if (keyCode == RIGHT) {
      naviM.setDir("right");
    }
    if(!naviM.canMove()) {
      naviM.setDir("stop");
    }
  }
}

