class Food{
  
  boolean next;
  boolean near = false;
  int dia = 15; 
  int rad = dia/2;
  float side = random(0,100);
  
  PVector loc = new PVector(random(0+dia, width/4 *3 - dia), random(0+dia, height- dia));
  
  Food(){
   
    while(dist(loc.x,loc.y,limitw/2, limith/2) <= 200){
        loc = new PVector(random(0+dia, width/4 *3 - dia), random(0+dia, height- dia));
    }
    
  }
  
  void show(){
    
     noStroke();
     fill(0,245,245);
     ellipse(loc.x,loc.y,dia,dia);   
  }
    
}
