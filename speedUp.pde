public class speedUp extends Powerup{
   String id;
   PImage symbol;
   public speedUp(){
     super.id = "speed";
     super.symbol = loadImage("fast.png");
     imageMode(CENTER);
   }
   public String id(){
    return id; 
   }
}