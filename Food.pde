class Food{
  
  boolean next;
  boolean near = false;
  int dia = 15; 
  int rad = dia/2;
  float side = random(0,100);
  
  PVector loc = new PVector(random(0+dia,1400-28), random(0+dia, height-28));
  
  Food(){
   
    while(dist(loc.x,loc.y,limitw/2, limith/2) <= 225){
      loc = new PVector(random(0+28,1400-28), random(0+28, height-28));
    }
    
  }
  
  void show(){
    
     noStroke();
     fill(0,245,245);
     ellipse(loc.x,loc.y,dia,dia);   
  }
    
}
