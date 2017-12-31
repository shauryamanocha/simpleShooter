public class Powerup{
  PVector pos;
  int size = 50;
  int timeLeft = 1000;
  boolean dead = false;
  boolean visible = true;
  PImage symbol;
  String id;
 public Powerup(){
   pos = new PVector(random(width),height-size/2);
   textSize(30);
   symbol = loadImage("dhori.png");
 }
 
 private void draw(){
  noStroke();
  fill(66,191,244);
  ellipse(pos.x,pos.y,size,size);
 }
 
 private void countDown(){
   if(timeLeft>0){
     timeLeft--;
     dead = false;
   }
   else{
     dead = true;
   }
 }
 
 private void drawImage(){
   image(symbol,pos.x,pos.y,size,size);
 }
 public void update(){
   if(visible){
       draw();
       drawImage();
   }
   text(timeLeft/100,50,50);
  countDown();
 }
 
 public boolean detectHit(Player player){
   if(pos.dist(player.pos)<=size/2+player.size/2){
    visible = false;
    timeLeft = 1000;
    return true;
   }
   else{
     return false;
   }
  }
}