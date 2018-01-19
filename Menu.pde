//this class creates a menu for the player to upgrade themself

public class Menu {
  boolean pressed = false;
  int menuItems = 4;
  int speed = 1;
  int shootSpeed = 1;
  int shootMode = 10;
  int damage = 1;
  Player player;
  public Menu(Player _player) {
    player = _player;
  }//created all variables
  private void control() {
    if (keyPressed && !pressed) {//waits for key to be released before checking if pressed again
      pressed = true;
      if (key == '1') {
        if (player.points>=speed) {//if player has enough points and a key is pressed increase speed
          player.points-=speed;
          speed++;
        }
      } else if (key == '2' && shootSpeed<18) {//if player has enough points and a key is pressed increase shooting speed
        if (player.points>=shootSpeed) {
          player.points-=shootSpeed;
          shootSpeed++;
        }
      } else if (key == '3' && shootMode<30) {//if player has enough points and a key is pressed increase shooting speed
        if (player.points>=shootMode) {
          player.points-=shootMode;
          shootMode+=10;
        }
      }
      else if (key == '4') {//if player has enough points and a key is pressed increase shooting speed
        if (player.points>=damage) {
          player.points-=damage;
          damage+=1;
        }
      }
    } else if (!keyPressed) {//update a variable when key is released
      pressed = false;
    }
  }

  private void draw() {
    fill(255);//information text
    textAlign(CENTER, CENTER);
    text("COST = CURRENT LEVEL", width/2, 30);
    textAlign(LEFT, CENTER);
    textSize(20);
    text("PRESS 1 TO INCREASE SPEED  CURRENT SPEED:" + speed, 40, 1*(height/menuItems)-30);//draws text at a height based off of number of menu items
    text("PRESS 2 TO INCREASE SHOOTING SPEED  CURRENT SHOOTING SPEED:" + shootSpeed, 40, 2*(height/menuItems)-30);
    text("PRESS 3 TO UPGRADE SHOOT MODE (REDUCES DAMAGE) CURRENT MODE:" + shootMode, 40, 3*(height/menuItems)-30);
    text("PRESS 4 TO UPGRADE DAMAGE CURRENT DAMAGE:" + damage, 40, 4*(height/menuItems)-30);
  }

  private void updatePlayer() {
    player.moveSpeed = speed+4; //update the player based off of menu upgrades
    player.shootSpeed = 19-shootSpeed;
    player.shootMode = shootMode-10;
    player.damage = damage;
  }
  
  public void reset(){
   speed = 1;
   shootSpeed = 1;
   shootMode = 10;
   damage = 1;
  }

  public void update() {//call all menu functions
    draw();
    control();
    updatePlayer();
  }
}