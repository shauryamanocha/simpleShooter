public class Menu {
  boolean pressed = false;
  int menuItems = 2;
  int speed = 1;
  int shootSpeed = 1;
  Player player;
  public Menu(Player _player) {
    player = _player;
  }
  private void control() {
    if (keyPressed && !pressed) {
      pressed = true;
      if (key == '1') {
        if (player.points>=speed) {
          player.points-=speed;
          speed++;
        }
      }
      else if(key == '2' && shootSpeed<18){
       if(player.points>=shootSpeed){
        player.points-=shootSpeed;
        shootSpeed++;
       }
      }
    } else if (!keyPressed) {
      pressed = false;
    }
  }

  private void draw() {
    fill(255);
    textAlign(CENTER,CENTER);
    text("COST = CURRENT LEVEL", width/2, 30);
    textAlign(LEFT, CENTER);
    textSize(20);
    text("1 TO INCREASE SPEED  CURRENT SPEED:" + speed, 40, 1*(height/menuItems)-30);
    text("2 TO INCREASE  SHOOTING SPEED  CURRENT SHOOTING SPEED:" + shootSpeed, 40, 2*(height/menuItems)-30);
  }
  
  private void updatePlayer(){
   player.moveSpeed = speed+4; 
   player.shootSpeed = 19-shootSpeed;
  }

  public void update() {
    draw();
    control();
    updatePlayer();
  }
}