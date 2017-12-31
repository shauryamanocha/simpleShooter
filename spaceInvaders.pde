Enemy enemy;
Player player;
Menu menu;
int gameState = 0;
int spawnInterval = 0;
boolean paused = false;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
void setup() {
  size(800, 800); 
  frameRate(60);
  player = new Player(0);
  menu = new Menu(player);
  for (int i = 0; i < 5; i++) {
    enemies.add(new Enemy(i*80, player));
  }
  //powerups.add(new speedUp());
}

void draw() {
  background(0); 
  if (gameState == 0) {
    textSize(30);
    textAlign(CENTER, CENTER);
    text("ARROW KEYS TO MOVE", width/2, height/2);
    text("UP TO SHOOT", width/2, height/2-100);
    if (frameCount>=120) {
      gameState++;
    }
  } else {
    for (int i = 0; i<enemies.size(); i++) {
      enemies.get(i).update();
      player.detectHit(enemies.get(i));
      if (enemies.get(i).dead) {
        enemies.remove(i);
      }
    }

    if (!player.dead) {
      player.update();
    }
  }

  if (gameState == 1) {
    spawnInterval++;
    player.paused = false;
    if (keyPressed && key == 'm') {
      gameState = 2;
    }
    for (int i = 0; i<enemies.size(); i++) {
      enemies.get(i).paused = false;
    }
    if (player.dead) {
      text("GAME OVER", width/2, height/2);
    }

    textAlign(CENTER, CENTER);
    text("PRESS M FOR MENU", width-200, 100);
    text("POINTS:" + player.points, width-200, 50);


    if (spawnInterval % 240 == 0) {
      enemies.add(new Enemy(0, player));
    }
  }

  if (gameState == 2) {
    player.paused = true;
    text("BACKSPACE TO GO BACK       POINTS REMAINING:" + player.points, 40, 100);
    if (keyPressed && key == BACKSPACE || key == DELETE) {
      println("bkspace");
      gameState = 1;
    }
    for (int i = 0; i<enemies.size(); i++) {
      enemies.get(i).paused =  true;
    }
    menu.update();
  }
  /*for (int i = 0; i<powerups.size(); i++) {
   if (!powerups.get(i).dead) {
   powerups.get(i).update();
   if(powerups.get(i).detectHit(player)){
   if(powerups.get(i).id == "speed"){
   player.shootSpeed = 5;
   }
   }
   }else{
   player.shootSpeed = 18; 
   }
   }*/
}