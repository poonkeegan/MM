class Tile {
  protected boolean redSide;
  protected int[] type;
  //which type of tile e.g. poison cracked etc.
  protected String occupyingObject;
  //Is there an object on the tile
  protected int xPos;
  protected int yPos;
  //position
  protected int xW;
  protected int yL;
  protected int panelStage;
  protected int aniDir;
  protected int aniTimer;
  protected int lastTime;
  //width and length
  Tile(int x, int y, boolean red, int[] types, int scale) {
    type = types;
    occupyingObject = "none";
    xPos = x;
    yPos = y;
    xW = 40*scale;
    yL = 25*scale;
    redSide = red;
    panelStage = 0;
    aniDir = 1;
    aniTimer = 100;
    lastTime = 0;
  }

  public void display(PImage tile) {
    image(tile, xPos, yPos);
  }

  public int getX() {
    return xPos;
  }
  public int getY() {
    return yPos;
  }
  public int[] getMid() {
    int[] arrayXY = {
      xPos+xW/2, yPos+yL/2
    };
    return arrayXY;
  }
  //return coordinated of the panels

  public boolean getRedTeam() {
    return redSide;
  }//return team side

    public int[] panelType() {
    return type;
  }//return panel type

    public void setType(int[] setting) {
    type = setting; 
    panelStage = 0;
    aniDir = 1;
  }//set panel type

  public int getStage() {
    return panelStage;
  }//return animation cycle stage

    public void toggleStage() {//cycle animation stage
    if (millis() >= lastTime + aniTimer) {
      lastTime += aniTimer;
      if (type[1] != 0) {
        panelStage+=aniDir;
        if (type[1] == 1) {
          if (panelStage >= 5) {
            //poison panel has 5 animation stages and animates backwards
            aniDir*=-1;
            panelStage-=2;
          }
        } else if (type[1] == 2) {
          if (panelStage >= 7) {
            //holy panel has 7 animation stages
            panelStage=0;
          }
        } else {
          if (panelStage >= 4) {
            //moving panel has 4 animation stages
            panelStage=0;
          }
        }
        if (panelStage < 0 ) {
          aniDir*=-1;
          panelStage+=2;
        }
      }
    }
  }
}

