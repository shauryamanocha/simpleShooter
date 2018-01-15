public class Explosion {
  PVector pos;
  float rate;
  int siz;
  int time;
  ArrayList<PImage> frames;
  boolean running;
  public Explosion(PVector _pos, float _rate, int _siz) {
    pos = new PVector();
    pos.set(_pos);
    rate = _rate;
    siz = _siz;
    running = false;
    frames = new ArrayList<PImage>();
    for(int i = 0;i<12;i++){
     frames.add(loadImage("explosion"+i+".png")); 
    }
  }
  
  public void draw(){
    if(running){
    image(frames.get(time%12),pos.x,pos.y,siz,siz);
    }
  }
  
  public boolean done(){
    if(frameCount%rate==0){
    time++;
    }
    if(time<frames.size()){
     return false; 
    }else{
     running = false;
     return true; 
    }
  }
  
  public void update(PVector _pos){
    pos.set(_pos);

  }
}