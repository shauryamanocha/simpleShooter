public class Enemy {
  PVector pos, vel;
  int movementStage = 0;
  int size = 50;
  int health = 10;
  PImage img = new PImage();
  int difficulty;
  boolean dead = false;
  boolean paused = false;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  Player player;
  public Enemy(int xPos, Player _player) {
    pos = new PVector(xPos, size);
    vel = new PVector(0, 0);
    img = loadImage("dhori.png");
    difficulty = 0;
    player = _player;
  }


  private void draw() {
    noStroke();
    fill(255, 0, 0);
    //ellipse(pos.x, pos.y, size, size);
    imageMode(CENTER);
    image(img, pos.x, pos.y, size, size);
    if (paused) {
      tint(255, 100);
    } else {
      noTint();
    }
  }

  private void move() {
    if (pos.x<width-size/2 && movementStage == 0) {
      if (frameCount % 30 == 0) {
        pos.x+=10;
      }
    } else if (pos.x>=width-size/2 && movementStage == 0) {
      pos.y+=size;
      movementStage++;
    } else if (pos.x>size/2 && movementStage == 1) {
      if (frameCount % 30 == 0) {
        pos.x-=10;
      }
    } else {
      pos.y+=size;
      movementStage = 0;
    }
  }
  private void detectHit() {
    for (int i = 0; i<player.bullets.size(); i++) {
      if (pos.dist(player.bullets.get(i).pos)<=size/2) {
        player.bullets.remove(i);
        size-=2;

        if (health>1) {
          health--;
          dead = false;
        } else {
          dead = true;
          player.points++;
        }
      }
    }
  }


  public boolean dead() {
    return dead;
  }
  private void shoot(int probability) {
    if (probability == 1) {
      bullets.add(new Bullet(pos, 1));
    }
  }

  public ArrayList bullets() {
    return bullets;
  }
  public void update() {
    if (!paused) {  
      if (difficulty<29) {
        difficulty +=0.005;
      }
      move();
      shoot((int)random(1, 50-difficulty));
      detectHit();
    }
    draw();
    for (int i = 0; i<bullets.size(); i++) {
      if(paused){
        bullets.get(i).paused = true;
      }else{
        bullets.get(i).paused = false;
      }
      bullets.get(i).update();
    }
  }
}