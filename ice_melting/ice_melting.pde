import java.util.Random;

PVector location;  // Location of shape
PVector velocity;  // Velocity of shape
PVector gravity;   // Gravity acts at the shape's acceleration
PShape s;  // The PShape object
PShape ice;
PShape water;
int tallestIcicle = 0;

Random rand = new Random();
int maxTide = rand.nextInt(500) + 300;
int seaLevel = 0; //rand.nextInt(100) + 100;
int meltedIce = 0;

int numDrops = 8;
Droplet[] droplets = new Droplet[numDrops];

float yoff = 0.0;

void setup() {
  size(1280, 720);
  background(184, 243, 255);
  for (int i = 0; i < numDrops; i++) {
    droplets[i] = new Droplet(random(width), random(-100,100), random(10, 40), i);
    noStroke();
    fill(255);
  }
}

void draw() {
 background(184, 243, 255);
 
 ice = createShape();
  ice.beginShape(); 
  
  float xoff_ice = 0;       // Option #1: 2D Noise
  
  // Iterate over horizontal pixels
  for (float x = 0; x <= width; x += 10) {
    // Calculate a y value according to noise, map to 
     float y = map(noise(xoff_ice), 0, 1, 0,700 - meltedIce);    // Option #2: 1D Noise
    
    // Set the vertex
    ice.vertex(x, y); 
    // Increment x dimension for noise
    xoff_ice += 0.4;
  }

  ice.vertex(width, -height);
  ice.vertex(0, -height);
  ice.endShape();
  
 shape(ice, 0,0);
 ice.setFill(color(255,255,255));
  
  // We are going to draw a polygon out of the wave points
 water = createShape();
 water.beginShape(); 
  
  float xoff = 0;       // Option #1: 2D Noise
  
  // Iterate over horizontal pixels
  for (float x = 0; x <= width; x += 10) {
    // Calculate a y value according to noise, map to 
    if (690-seaLevel <= 0) {
       seaLevel = 0;
       meltedIce = 0;
       
    }
    if (seaLevel >= 250){
    }
    // icicles fall away here, fill up screen quickly --> restart
    
    float y = map(noise(xoff, yoff), 0, 1, 600-seaLevel,700-seaLevel); // Option #1: 2D Noise
    
    // Set the vertex
    water.vertex(x, y); 
    water.fill(75, 192, 217);
    // Increment x dimension for noise
    xoff += 0.05;
  }

  // increment y dimension for noise
  yoff += 0.01;
  water.vertex(width, height);
  water.vertex(0, height);
  water.endShape();
  
  shape(water, 0,0);
  water.setFill(color(75, 192, 217));
  
  
  for (Droplet droplet : droplets) {
    //noStroke();
    //fill(75, 192, 217);
    droplet.move();
    droplet.display();  
 }
}


class Droplet {
  
  float x, y;
  float diameter;
  float vx = 0;
  float vy = 0;
  int id;
  
  float spring = 0.05;
  float gravityDrop = 0.03;
  float friction = -0.9;
 
  Droplet(float xin, float yin, float din, int idin) {
    x = xin;
    y = yin;
    diameter = din;
    id = idin;
  } 
  
  void move() {
    vy += gravityDrop;
    x += vx;
    y += vy;
    if (x + diameter/2 > width) {
      x = width - diameter/2;
      vx *= friction; 
    }
    else if (x - diameter/2 < 0) {
      x = diameter/2;
      vx *= friction;
    }
    if (y + diameter/2 > height) {
      seaLevel++;
      meltedIce++;
      x = random(width);
      y = random(-100,100);
      
    } 
    else if (y - diameter/2 < 0) {
      y = diameter/2;
      vy *= friction;
    }
  }
  
  void display() {
    ellipse(x, y, diameter, diameter);
  }
}
