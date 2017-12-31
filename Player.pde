public class Player {
  PVector pos, vel;
  ArrayList<PlayerBullet> bullets = new ArrayList<PlayerBullet>();
  int size = 50;
  int health = 5;
  boolean dead = false;
  int controlMode = 0;
  int shootSpeed = 18;
  PImage image;
  int points = 1000;
  int moveSpeed = 5;
  boolean paused = false;
  public Player(int _controlMode) {
    pos = new PVector(width/2, height);
    vel = new PVector(0, 0);
    controlMode = _controlMode;
    image = loadImage("russia.png");
    imageMode(CENTER);
  }
  private void draw() {
    fill(255);
    noStroke();
    //ellipse(pos.x, pos.y-25, size, size);
    image(image, pos.x, pos.y-size/2, size, size);
    if (paused) {
      tint(255, 100);
    } else {
      noTint();
    }
  }
  private void move() {
    pos.add(vel);
    if (pos.x<0) {
      pos.x = 0;
    }
    if (pos.x>width) {
      pos.x = width;
    }
    if (controlMode == 0) {
      if (keyPressed && keyCode == LEFT) {
        vel.x = -moveSpeed;
      } else if (keyPressed && keyCode == RIGHT) {
        vel.x = moveSpeed;
      } else {
        vel.x = 0;
      }
    } else {
      if (keyPressed && key == 'a') {
        vel.x = -5;
      } else if (keyPressed && key == 'd') {
        vel.x = 5;
      } else {
        vel.x = 0;
      }
    }
  }

  private void shoot() {
    if (frameCount%shootSpeed == 0) {
      if (controlMode == 0) {
        if (keyPressed && keyCode == UP) {
          bullets.add(new PlayerBullet(pos, -1, -PI/12));
          bullets.add(new PlayerBullet(pos, -1, 0));
          bullets.add(new PlayerBullet(pos, -1, PI/12));
        }
      } else {
        if (keyPressed && key == 'w') {
          // bullets.add(new Bullet(pos, -1));
        }
      }
    }
    for (int i = 0; i<bullets.size(); i++) {
      if (bullets.get(i).offScreen()) {
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
      if (pos.dist(enemy.bullets.get(i).pos)<=size/2) {
        enemy.bullets.remove(i);
        size-=5;
        if (health>1) {
          health--;
          dead = false;
        } else {
          dead = true;
        }
      }
    }
  }
  public boolean dead() {
    return dead;
  }

  public void update() {
    if (!paused) {
      move();
      shoot();
    }
    for (int i = 0; i<bullets.size(); i++) {
      if (paused) {
        bullets.get(i).paused = true;
      } else {
        bullets.get(i).paused = false;
      }
      bullets.get(i).update();
    }
    draw();
  }
}