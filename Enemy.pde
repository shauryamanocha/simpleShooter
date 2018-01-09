public class Enemy {
  PVector pos, vel;
  int movementStage = 0;
  float size = 40;
  float health = 10;
  PImage img = new PImage();
  int difficulty;
  boolean dead = false;
  boolean paused = false;
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  Player player;
  public Enemy(int xPos, Player _player, int extraHealth) {
    pos = new PVector(xPos, size);
    vel = new PVector(0, 0);
    img = loadImage("dhori.png");
    difficulty = 0;
    player = _player;
    health+=extraHealth;
  }//created all variables


  private void draw() {
    noStroke();
    fill(255, 0, 0);
    textAlign(CENTER,CENTER);
    textSize(10);
    
    //ellipse(pos.x, pos.y, size, size);
    imageMode(CENTER);
    image(img, pos.x, pos.y, size+health, size+health);//draw the image
    text(health,pos.x,pos.y);
    if (paused) {
      tint(255, 100);//lower image opacity if paused
    } else {
      noTint();
    }
  }

  private void move() {
    if (pos.x<width-size/2 && movementStage == 0) {//move the enemy 10 pixels until it reaches the edge
      if (frameCount % 30 == 0) {
        pos.x+=10;
      }
    } else if (pos.x>=width-size/2 && movementStage == 0) {//lower the enemy once it has reached the edge
      pos.y+=size+health;
      movementStage++;
    } else if (pos.x>size/2 && movementStage == 1) {//move the enemy -10 pixles until it reaches the edge
      if (frameCount % 30 == 0) {
        pos.x-=10;
      }
    } else {//move the enemy down and restart the loop
      pos.y+=size+health;
      movementStage = 0;
    }
  }
  private void detectHit() {
    for (int i = 0; i<player.bullets.size(); i++) {//loop through all of the player's bullets
      if (pos.dist(player.bullets.get(i).pos)<=size/2) {
        size-=player.bullets.get(i).damage*2;//check for hit and lower size

        if (health>1) {
          health-=player.bullets.get(i).damage;//lower health if alive
          dead = false;//kill self if health is too low
        } else {
          dead = true;
          player.points++;//increase player points on hit
        }
        player.bullets.remove(i);
      }
    }
  }


  public boolean dead() {
    return dead;
  }
  private void shoot(int probability) {
    if (probability == 1) {
      bullets.add(new Bullet(pos, 1, 1));//shoot a bullet if a random value = 1
    }
  }

  public ArrayList bullets() {
    return bullets;
  }
  public void update() {
    if (!paused) {  //only done if not paused
      if (difficulty<29) {//increase difficulty to shoot faster
        difficulty +=0.005;
      }
      move();
      shoot((int)random(1, 50-difficulty));//shoot based off of difficulty
      detectHit();
    }
    draw();
    for (int i = 0; i<bullets.size(); i++) {
      if (paused) {
        bullets.get(i).paused = true;//pause all bullets
      } else {
        bullets.get(i).paused = false;//unpause all bullets
      }
      bullets.get(i).update();//update all bullets
    }
  }
}