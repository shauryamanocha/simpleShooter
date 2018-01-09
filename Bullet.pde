public class Bullet {
  PVector pos, vel, endPos;
  boolean paused = false;
  float damage;
  
  public Bullet(PVector _pos, int direction, float _damage) {
    pos = new PVector(_pos.x, _pos.y);
    vel = new PVector(0, 5*direction);
    endPos = new PVector(pos.x+vel.x*4, pos.y+vel.y*4);
    damage = _damage;
  }//created all variables
  public Bullet(PVector _pos, int direction, float angle, float _damage) {
    pos = new PVector(_pos.x, _pos.y);
    vel = new PVector(0, 5*direction);
    vel.rotate(angle);
    endPos = new PVector(pos.x+vel.x*4, pos.y+vel.y*4);
    damage = _damage;
  }//different constructor in order to have burst fire
  private void draw() {
    if (paused) {
      stroke(255, 100);//lower opacity if paused
    } else {
      stroke(255);
    }
    line(pos.x, pos.y, endPos.x, endPos.y);
  }

  protected void move() {//move the bullet
    endPos.add(vel);
    pos.add(vel);
  }
  public boolean offScreen() {//return if the bullet is offscreen
    if (pos.y<0) {
      return true;
    } else {
      return false;
    }
  }
  public PVector position() {
    return pos;
  }
  public float length() {
    return pos.y-endPos.y;
  }

  public void update() {//update function for bullet
    draw(); 
    if(!paused){//only move if not paused
    move();
    }
  }
}