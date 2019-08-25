ArrayList<Ball> b;             //Array List of population of Balls
ArrayList<Food> f;             //Array List of food
ArrayList<Graph> colors;       //Array List of colors of individual Balls in population
ArrayList<Graph> fittest;      //Array List of colors of the fittest Ball in population

int limitw;                    //width limit
int limith;                    //height limit

int pop = 100;                 //initialize population
int amount = 45;               //initialize amount of food

int count = 0;                 //initialize frame counter

int genCount = 1;              //initialize generation counter
int families = 0;              //initialize counter of number of families 


//Setup

void setup(){
  size(2000,1200);
  limitw = width - 600;
  limith = height;
  
  //surface.setResizable(true);
  background(0);
  //frameRate(60);
  
  f = new ArrayList<Food>();
  b = new ArrayList<Ball>();
  colors = new ArrayList<Graph>();
  fittest = new ArrayList<Graph>();
  
  for(int i = 0; i < pop; i++){
     b.add(new Ball());
  }
  for(int i = 0; i < amount; i++){
    f.add(new Food());
  }
  updateGraph(); 
}

void draw(){
  background(0);
  
   for(int i = 0; i < f.size(); i++){
      f.get(i).show();            
    } 
      
  for(int i  = 0; i < b.size(); i++){
    for(int j = 0; j < f.size(); j++){
      ifNear(i,j);
      if(b.get(i).near == true){
        break;
      }
      ate(i,j);
    }    
     off(i); 
     b.get(i).update();
     b.get(i).show(); 
  }
  rectMode(CENTER);
  stroke(255);
  strokeWeight(20);
  noFill();
  rect(limitw/2,limith/2, limitw+10, limith+25);
   
  rectMode(CORNER);
  noStroke();
  fill(0);
  rect(limitw,0,600,height);
   
  
  if(count == 1500 || f.size() == 0){
    if(families == 1){      
      reColor();
      newGen(); 
      updateGraph();      
    }
    else{
      newGen();
      updateGraph();
    }
    count = 0;
  }
     
  textSize(35);
  fill(255);
  text("Food Available: " + f.size(),limitw + 10, 35);
  text("Population: " + pop, limitw + 10, 70); 
  text("Families: " + families, limitw + 10, 105);   
  
  if(fittest.size() != 0 && pop != 0){
    for(int i = 0; i < fittest.size(); i++ ){
      text("Fittest Color: " , limitw + 10, 140 + (i * 35)); 
      fill(fittest.get(i).r,fittest.get(i).g,fittest.get(i).b);
      text("#####", limitw + 240, 140 + (i * 35));
      fill(255);
      println(fittest.size());
    }
  }
  
  text("Gen: " + genCount, limitw + 10, limith-5); 
  
  if(pop == 0){
    saveFrame("Fittest-Population-Results.png"); 
    exit();
  }
  
  count++;
}

void updateGraph(){
  
  for(int i = colors.size(); i > 0; i--){
    colors.remove(colors.size()-1);
  }
  
  for(int i =0; i < b.size(); i++){
    colors.add(new Graph(b.get(i).r,b.get(i).g,b.get(i).b, 1));
  }
  
  if(colors.size() == 0){
    return;
  }
  
  
  if(families == 1 ){
    fittest.add(new Graph(colors.get(0).r ,colors.get(0).g , colors.get(0).b , 1));
  }
  
  families = 1;
  
    for (int i = 1; i < colors.size(); i++){ 
        int j = 0; 
        for (j = 0; j < i; j++){
            if (colors.get(i).r == colors.get(j).r && colors.get(i).g == colors.get(j).g && colors.get(i).b == colors.get(j).b){
                break; 
            }
        }
   
      if (i == j){
        families++;
      }
    }  
}
 
//This function is in charge of checking to see if individuals are heading off screen
void off(int i){
      if(b.get(i).loc.x >= limitw - b.get(i).rad  || b.get(i).loc.x <= 0 + b.get(i).rad){
        b.get(i).vel.x = (b.get(i).vel.x * -1);        
      }
      
      if(b.get(i).loc.y >= limith - b.get(i).rad|| b.get(i).loc.y <= 0 + b.get(i).rad){
         b.get(i).vel.y = (b.get(i).vel.y * -1);        
      }
}


//This function is in charge of creating new generations
void newGen(){
  pop = b.size();
  if(pop == 0){
    return;
  }
  
  for(int i = f.size(); i > 0; i--){
    f.remove(f.size()-1);
  }
    
  //println(f.size());
  for(int i = 0; i < amount; i++){
    f.add(new Food());
     //println(f.size());
  }
  
  int curSize = b.size();
  
  
  for(int i =0; i < curSize; i++){
    if(b.get(i).fed == 0){
        b.remove(i);
        i--;
        curSize--;
      }      
      
      if(curSize == 0){
        return;
      }
    }
  
  
  for(int i = 0; i < b.size(); i++){
    if(b.get(i).fed >= 2){
      b.get(i).loc.x = limitw/2;
      b.get(i).loc.y = limith/2;
      b.get(i).fed = 0;
      mut(i); // copies bob and mutation occurs 
     
    }
    
    if(b.get(i).fed == 1){
      b.get(i).loc.x = limitw/2;
      b.get(i).loc.y = limith/2;
      b.get(i).fed = 0;
    }
   
  }
  
  for(int i =0; i < b.size(); i++){
      b.get(i).fed = 0;
  }
  
  pop = b.size();
  genCount++;
}

//This function is in charge of checking if the individuals can see the food
void ifNear(int i, int j){
  
      //Check if near
      if(dist(b.get(i).loc.x,b.get(i).loc.y,f.get(j).loc.x,f.get(j).loc.y) <= b.get(i).sight/2){
        
        b.get(i).vel = new PVector((f.get(j).loc.x - b.get(i).loc.x),(f.get(j).loc.y - b.get(i).loc.y));  
        b.get(i).temp = b.get(i).mag;
        b.get(i).mag = b.get(i).eatTime;
        b.get(i).vel.normalize();
        b.get(i).near = true;
        ate(i,j);
      //println("Ball number: ",i," and Food number: ", j , " is near: ", b.get(i).near);
     }
     
     else{
       b.get(i).temp = b.get(i).mag;
       b.get(i).mag = b.get(i).temp;
       b.get(i).vel.normalize();
       b.get(i).near = false;
     }
          
}


//This function is in charge of checking which individuals have eatan and removing the food
void ate(int i, int j){
  
  float growthsp = .9;
  float growthsz = 1.05;
  
  if(dist(b.get(i).loc.x,b.get(i).loc.y,f.get(j).loc.x,f.get(j).loc.y) <= (b.get(i).rad +f.get(j).rad)){
    f.get(j).loc = new PVector(random(f.get(j).rad,limitw-f.get(j).rad), random(f.get(j).rad, limith-f.get(j).rad));
    b.get(i).mag = b.get(i).mag * growthsp;
    b.get(i).dia = b.get(i).dia * growthsz;    
    b.get(i).fed++;       
    f.remove(j);
  }
  
}

//This function is in charge of the mutaion that occurs in the population
void mut(int i){
  
  float gain = 1.1;
  float loss = .9;
  
  b.add(new Ball());
  b.get(b.size()-1).famid = b.get(i).famid;
  b.get(b.size()-1).r = b.get(i).r; 
  b.get(b.size()-1).g = b.get(i).g; 
  b.get(b.size()-1).b = b.get(i).b; 
  
  b.get(b.size()-1).sight = b.get(i).sight;
  b.get(b.size()-1).diacap = b.get(i).diacap; 
  b.get(b.size()-1).sightcap = b.get(i).sightcap; 
  b.get(b.size()-1).magcap = b.get(i).magcap; 
  
  int mutChance = 5; //out of 100
  float rand = random(0,100);
  
  if(rand <= mutChance){
    rand = random(0,100);
    b.get(b.size()-1).r = random(0,255);
    b.get(b.size()-1).g = random(0,255);
    b.get(b.size()-1).b = random(0,255);
    
    b.get(b.size()-1).famid = random(0,1000);
    
    rand = random(0,100);
    
    if(rand > 50){
      b.get(b.size()-1).sight = b.get(i).sight + 5;
      b.get(b.size()-1).diacap = b.get(i).diacap + 5; 
      b.get(b.size()-1).sightcap = b.get(i).sightcap + 5; 
      b.get(b.size()-1).magcap = b.get(i).magcap; 
    }
    else{
      b.get(b.size()-1).sight = b.get(i).sight - 5;
      b.get(b.size()-1).diacap = b.get(i).diacap - 5; 
      b.get(b.size()-1).sightcap = b.get(i).sightcap - 5; 
      b.get(b.size()-1).magcap = b.get(i).magcap; 
    }

    rand = random(0,100);
    
    if(rand > 50){
      b.get(b.size()-1).dia = b.get(i).dia * gain;
    }
    else{
      b.get(b.size()-1).dia = b.get(i).dia * loss;
    }
    
    rand = random(0,100);
    
    if(rand > 50){
      b.get(b.size()-1).mag = b.get(i).vel.mag() * gain;
     }
     else{
       b.get(b.size()-1).mag = b.get(i).vel.mag() * loss;
     }
     
     rand = random(0,100);
    
     if(rand > 50){
       b.get(b.size()-1).eatTime = b.get(i).eatTime * gain;
     }
     else{
       b.get(b.size()-1).eatTime = b.get(i).eatTime * loss;
     }  
    
  }
  
  else{
    b.get(b.size()-1).sight = b.get(i).sight;
    b.get(b.size()-1).dia = b.get(i).dia;
    b.get(b.size()-1).mag = b.get(i).vel.mag();
    b.get(b.size()-1).eatTime = b.get(i).eatTime;
  }
   
  b.get(b.size()-1).vel = PVector.random2D();
  
}

//when only one familiy is left reset population 
void reColor(){
  if(families != 1){
    for(int i = 1; i < b.size(); i++){
      b.get(i).famid = random(0,1000);
      b.get(i).r = random(0,255);
      b.get(i).g = random(0,255);
      b.get(i).b = random(0,255);
    }
  }
  
  
}
 
