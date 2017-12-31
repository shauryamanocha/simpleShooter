public class PlayerBullet extends Bullet {
  public PlayerBullet(PVector _pos, int direction, float angle) {
    super(_pos, direction, angle) ;
  }

  void update() {
    //super.update();
    this.draw();
    if (!paused) {
      move();
    }
  }

  void draw() {
    if (paused) {
      fill(0, 200, 0, 100);
    } else {
      fill(0, 200, 0);
    }
    noStroke();
    ellipse(pos.x, pos.y, 5, 5);
  }
}