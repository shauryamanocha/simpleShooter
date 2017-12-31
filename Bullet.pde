public class Bullet {
  PVector pos, vel, endPos;
  boolean paused = false;
  public Bullet(PVector _pos, int direction) {
    pos = new PVector(_pos.x, _pos.y);
    vel = new PVector(0, 5*direction);
    endPos = new PVector(pos.x+vel.x*4, pos.y+vel.y*4);
  }
  public Bullet(PVector _pos, int direction, float angle) {
    pos = new PVector(_pos.x, _pos.y);
    vel = new PVector(0, 5*direction);
    vel.rotate(angle);
    endPos = new PVector(pos.x+vel.x*4, pos.y+vel.y*4);
  }
  private void draw() {
    if (paused) {
      stroke(255, 100);
    } else {
      stroke(255);
    }
    line(pos.x, pos.y, endPos.x, endPos.y);
  }

  protected void move() {
    endPos.add(vel);
    pos.add(vel);
  }
  public boolean offScreen() {
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

  public void update() {
    draw(); 
    if(!paused){
    move();
    }
  }
}