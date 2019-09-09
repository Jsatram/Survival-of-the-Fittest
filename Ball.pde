class Ball {
  Boolean dead = false;
  PVector loc;
  PVector vel;
  Boolean near = false;
  
  float r = random(0,255);
  float g = random(0,255);
  float b = random(0,255);
  
  float mag = 0;
  float eatTime; 
  
  float temp = 0;
  
  float ro = 255;
  float go = 255;
  float bo = 255;
  
  float px;
  float py;
  float angle = random(0,360);
  
  float sight = random(50,150);
  
  float dia = random(15,25);
  float rad = dia/2;
  int fed = 0;
  int count = 0;
  
  float diacap;
  float sightcap;
  float magcap;
  
  float famid = random(0,1000);

  Ball(){
    sight = random(50,200);
    dia = random(10,20);
    rad = dia/2;
    loc = new PVector(((width/4)*3)/2, height/2);
    vel = new PVector(random(-4,4),random(-4,4));
    mag = vel.mag();
    eatTime = random(0,mag);
    vel.normalize();
    px = (sight/2) * cos(angle);
    py = (sight/2) * sin(angle);
     
     sightcap = sight;
     diacap = sightcap * .30;
     magcap = mag;
    
  }
  
  void show(){
    
    strokeWeight(8);
    
      if(near == true){
        ro = 0;
        go = 255;
        bo = 0;
        noStroke();
        fill(r,g,b);
        ellipse(loc.x,loc.y,dia,dia); 
        
        noFill();
        stroke(ro,go,bo);
        strokeWeight(6);
        ellipse(loc.x,loc.y,sight,sight);
        strokeWeight(6);
        
      }
      
      else{
        ro = 255;
        go = 255;
        bo = 255;
        noStroke();
        fill(r,g,b);
        ellipse(loc.x,loc.y,dia,dia);  
        
        noFill();
        stroke(ro,go,bo,230);
        ellipse(loc.x,loc.y,sight,sight);
        strokeWeight(10);
        point(loc.x+px,loc.y+py);
        strokeWeight(6);
      }    
   }
  
   void update(){    
     
       if(dead){
         vel.set(0,0);         
       }
       
       if(dia > diacap){
         dia = diacap;
       }
       
       if(sight > sightcap){
         sight = sightcap;
       }
       
       if(mag >= magcap){
         mag = magcap;
       }

       rad = dia/2;
       px = (sight/2) * cos(angle);
       py = (sight/2) * sin(angle);
       angle = angle + .075;     

       vel.mult(mag); 
       vel.limit(mag);
       loc.add(vel);      
   }
}
