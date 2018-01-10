public class Player {
  PVector pos, vel;
  ArrayList<PlayerBullet> bullets = new ArrayList<PlayerBullet>();
  int size = 50;
  int health = 5;
  boolean dead = false;
  int controlMode = 0;
  int shootSpeed = 18;
  PImage image;
  int points = 50;
  int moveSpeed = 5;
  int shootMode = 0;
  float damage = 1;
  boolean paused = false;
  public Player(int _controlMode) {
    pos = new PVector(width/2, height);
    vel = new PVector(0, 0);
    controlMode = _controlMode;
    image = loadImage("russia.png");
    imageMode(CENTER);
  }//created all variables
  private void draw() {//draw image at position
    fill(255);
    noStroke();
    //ellipse(pos.x, pos.y-25, size, size);
    image(image, pos.x, pos.y-size/2, size, size);
    if (paused) {
      tint(255, 100);//lower opacity if paused
    } else {
      noTint();
    }
  }
  private void move() {
    pos.add(vel);//move player
    if (pos.x<0) {//make sure player doesnt go off screen
      pos.x = 0;
    }
    if (pos.x>width) {
      pos.x = width;
    }
    if (controlMode == 0) {//if using arrow keys
      if (keyPressed && keyCode == LEFT) {//move left
        vel.x = -moveSpeed;
      } else if (keyPressed && keyCode == RIGHT) {//move right
        vel.x = moveSpeed;
      } else {
        vel.x = 0;//stop moving
      }
    } else {//if using wasd keys
      if (keyPressed && key == 'a') {//move left
        vel.x = -moveSpeed;
      } else if (keyPressed && key == 'd') {//move right
        vel.x = moveSpeed;
      } else {
        vel.x = 0;//stop moving
      }
    }
  }

  private void shoot() {
    if (frameCount%shootSpeed == 0) {//if enough time has passed since last bullet was fired
      if (controlMode == 0) {
        if (keyPressed && keyCode == UP || key =='w') {
          if (shootMode == 0) {//if shooting has no upgrade
            bullets.add(new PlayerBullet(pos, -1, 0,damage));//shoot 1 straight bullet
          }
          
          else if(shootMode == 10){//shooting first upgrade
           bullets.add(new PlayerBullet(pos,-1,-PI/24,damage/2));//shoot 2 bullets at different angles
           bullets.add(new PlayerBullet(pos,-1,PI/24,damage/2)); 
          }

          if (shootMode == 20) {//shooting second upgrade
            bullets.add(new PlayerBullet(pos, -1, -PI/12,damage/3));//shoot 3 bullets at different angles
            bullets.add(new PlayerBullet(pos, -1, 0,damage/3));
            bullets.add(new PlayerBullet(pos, -1, PI/12,damage/3));
          }
        }
      } else {
      }
    }
    for (int i = 0; i<bullets.size(); i++) {
      if (bullets.get(i).offScreen()) {//remove bullets if offscreen
        bullets.remove(i);
      }
    }
  }

  public ArrayList bullets() {
    return bullets;
  }

  public int health() {
    return health();
  }

  public void detectHit(Enemy enemy) {
    for (int i = 0; i<enemy.bullets.size(); i++) {
      if (pos.dist(enemy.bullets.get(i).pos)<=size/2) {//check if enemy bullet hit player
        enemy.bullets.remove(i);//remove the bullet that hit
        size-=5;//remove size
        if (health>1) {
          health--;//lower health if not dead
          dead = false;
        } else {
          dead = true;//kill self
        }
      }
    }
  }
  public boolean dead() {
    return dead;
  }

  public void update() {
    if (!paused) {//move and shoot if not paused
      move();
      shoot();
    }
    for (int i = 0; i<bullets.size(); i++) {
      if (paused) {
        bullets.get(i).paused = true;//pause all bullets
      } else {
        bullets.get(i).paused = false;//unpause all bullets
      }
      bullets.get(i).update();//update all bullets
    }
    draw();//draw self
  }
}