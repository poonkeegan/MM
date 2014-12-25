class Navi implements Object {
  protected Main main;
  protected int x;
  protected int y;
  protected int HP;
  protected boolean redSide;
  protected PImage sprite; 
  protected int scaleOf;
  protected int aniTimer;
  protected int lastTime;
  protected PImage[][]sprites;
  protected String status;
  protected String dir;
  protected int spriteStage;
  protected int spriteStages;

  Navi(boolean red, int xPos, int yPos, PImage img, int scale, Main m) {
    spriteStages = 3;
    main = m;
    status = "normal";
    aniTimer = 10;
    dir = "stop";

    redSide = red;
    if (redSide) {
      x = xPos;
    } else {
      x = xPos+3;
    }
    y = yPos;
    //set starting position

    scaleOf = scale;
    sprite = img;
    sprite.resize(sprite.width*scaleOf, 0);
    sprites = new PImage[spriteStages][1];
    for (int k = 0; k < spriteStages; k++) {
      for (int j = 0; j < 1; j++) {
        sprites[k][j] = sprite.get(k*50*scaleOf, j*60*scaleOf, 50*scaleOf, 60*scaleOf);
      }
    }
    sprite = sprites[0][0];
    //set up sprite sheet array
  }
  public void update() {
    sprite = sprites[spriteStage][0];
    move();
    display(main.getField());
    //println(status);
    //println(spriteStage);
  }
  protected void move() {
    if (status.equals("moving")) {

      if (millis() >= lastTime + aniTimer) {
        lastTime = millis();
        spriteStage += 1;
        if (spriteStage >= spriteStages) {
          spriteStage=0;  

          if (dir.equals("up")) {
            y--;
          } else if (dir.equals("down")) {
            y++;
          } else if (dir.equals("left")) {
            x--;
          } else if (dir.equals("right")) {
            x++;
          }
          dir = "stop";
          status = "normal";
        }
        
      }

      //        int oldX = x;
      //        int oldY = y;
      //        println(dir);
      //          if (dir.equals("up")) {
      //            y--;
      //          } else if (dir.equals("down")) {
      //            y++;
      //          } else if (dir.equals("left")) {
      //            x--;
      //          } else if (dir.equals("right")) {
      //            x++;
      //          }//change position
      //          dir = "stop";
      //  
      //        if (y < 0||y >= fieldY) {
      //          y = oldY;
      //          status = "normal";
      //        }else if (x < 0||x >= fieldX) {
      //          x = oldX;
      //          status = "normal";
      //        }//check bondaries
      //    
      //        else if (main.getTile(x, y).getRedTeam() != redSide) {
      //          x = oldX;
      //          y = oldY;
      //          status = "normal";
      //        }//check side colours
    }
  }

  public void toggleStage() {//cycle animation stage
    if (millis() >= lastTime + aniTimer) {
      lastTime += aniTimer;
    }
  }
  protected boolean canMove() {
    int oldX = x;
    int oldY = y;
    if (dir.equals("up")) {
      y--;
    } else if (dir.equals("down")) {
      y++;
    } else if (dir.equals("left")) {
      x--;
    } else if (dir.equals("right")) {
      x++;
    }//change position
      
    if (y < 0||y >= fieldY) {
      x = oldX;
      y = oldY;
      return false;
    } else if (x < 0||x >= fieldX) {
      x = oldX;
      y = oldY;
      return false;
    }//check bondaries

    else if (main.getTile(x, y).getRedTeam() != redSide) {
      x = oldX;
      y = oldY;
      return false;
    }//check side colours

    else {
      x = oldX;
      y = oldY;
      status = "moving";
      return true;
    }
  }
  public void display(Tile[][] bfield) {
    if (redSide) {
      image(sprite, ((bfield[x][y].getMid()[0])-sprite.width/2), bfield[x][y].getMid()[1]-sprite.height+5*scaleOf);
    } else {
      pushMatrix();
      scale(-1, 1);
      image(sprite, ((bfield[x][y].getMid()[0])-sprite.width/2)*-1-sprite.width, bfield[x][y].getMid()[1]-sprite.height+5*scaleOf);
      popMatrix();
    }
  }


  public void setDir(String s) {
    dir = s;
  }

  public int getX() {
    return x;
  }

  public int getY() {
    return y;
  }
}

