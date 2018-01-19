import ddf.minim.*;
/*
Shaurya Manocha
simpleShooter v3.0
January 15th - Game now has background music
*/
Enemy enemy;
Player player;
Menu menu;
int gameState = 0;
int spawnInterval = 0;
int enemyDifficulty = 0;
boolean paused = false;
PImage bg;
Minim music;
AudioPlayer musicPlayer;
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
void setup() {
  size(800, 800); 
  frameRate(60);
  player = new Player(0);
  menu = new Menu(player);
  music = new Minim(this);
  musicPlayer = music.loadFile("music.mp3");
  for (int i = 0; i < 5; i++) {
    enemies.add(new Enemy(i*80, player, enemyDifficulty));
  }
  bg = loadImage("bg.jpg");
  musicPlayer.loop();
}//created all variables and objects

void resetEnemies() {
  enemies.clear();
  for (int i = 0; i < 5; i++) {
    enemies.add(new Enemy(i*80, player, enemyDifficulty));
  }
}

void draw() {
  background(0);
  image(bg, width/2, height/2);
  if (gameState == 0) {//intro screen
    textSize(30);
    textAlign(CENTER, CENTER);
    text("ARROW KEYS TO MOVE", width/2, height/2);
    text("HOLD UP ARROW TO SHOOT", width/2, height/2-100);
    if (frameCount>=120) {
      gameState++;
    }
  } else {
    for (int i = 0; i<enemies.size(); i++) {//update enemies
      enemies.get(i).update();
      if (enemies.get(i).explosion.running) {
        enemies.get(i).explode();
      }
      player.detectHit(enemies.get(i));//check if player is hit by enemy bullet
      if (enemies.get(i).dead && enemies.get(i).explosion.done()) {
        enemies.remove(i);//stop updating enemy
        player.points++;
      }
    }

    if (!player.dead) {
      player.update();//update player
    }
  }

  if (gameState == 1) {
    if (spawnInterval%2400 == 0) {
      enemyDifficulty+=2;//increase enemy starting health
    }
    spawnInterval++;//keeps track of time since last enemy was spawned
    player.paused = false;//unpause player
    if (keyPressed && key == 'm') {//go into menu screen
      gameState = 2;
    }
    for (int i = 0; i<enemies.size(); i++) {//unpause all enmies
      enemies.get(i).paused = false;
    }
    if (player.dead) {
      text("PRESS 'R' TO RESTART", width/2, height/2+100);
      text("GAME OVER", width/2, height/2);//end screen
      if (keyPressed&&key == 'r') {
        menu.reset();
        player = new Player(0);
        resetEnemies();
      }
    }
    textSize(20);
    textAlign(CENTER, CENTER);//menu text
    text("PRESS M FOR MENU", width-200, 100);
    text("POINTS:" + player.points, width-200, 50);


    if (spawnInterval % 240 == 0) {
      enemies.add(new Enemy(0, player, enemyDifficulty));//add a new enemy if there has been enough time since the last enemy spawned
    }
  }

  if (gameState == 2) {//menu state
    player.paused = true;//pause the player
    text("BACKSPACE TO GO BACK       POINTS REMAINING:" + player.points, 40, 100);//menu text
    if (keyPressed && key == BACKSPACE || key == DELETE) {
      println("bkspace");
      gameState = 1;//go into main game state
    }
    for (int i = 0; i<enemies.size(); i++) {
      enemies.get(i).paused =  true;//pause all enemies
    }
    menu.update();//update menu
  }
}