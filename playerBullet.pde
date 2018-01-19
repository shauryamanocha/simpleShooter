//this class creates bullets for the player
//inherits from the bullet class with different shape and color

public class PlayerBullet extends Bullet {
  public PlayerBullet(PVector _pos, int direction, float angle, float damage) {
    super(_pos, direction, angle, damage) ;
  }//inherits from bullet super class

  void update() {//overrites update function
    //super.update();
    this.draw();
    if (!paused) {//move if not paused
      move();
    }
  }

  void draw() {//draw with a different color
    if (paused) {
      fill(0, 200, 0, 100);//lower opacity if paused
    } else {
      fill(0, 200, 0);
    }
    noStroke();
    ellipse(pos.x, pos.y, 5, 5);//draw self
  }
}