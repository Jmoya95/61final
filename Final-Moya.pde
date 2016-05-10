//Julio Moya
// Project 5 - Final

String title=  "Project 5 - Final";
String author= "Julio Moya";

String instruction1= "click 't' to move the tallest at the end";
String instruction2= "click 'w' to move the widest at the end";
String instruction3= "click 'r' to reset the guys with a new random weight and height";
String instruction4= "click 'o' to order from the shortest to the tallest";
String instruction5= "click 'q' quit";

String name[]= {"Julio", "rob", "kate", "john", "phil", "jose", "kim", "kathy", "bam"};
int many=9;

Person[] people=  new Person[many];

float surface;
float sky;

float cloudX = 90, cloudY = 85;
float cloudMovement = 3;
float amountCloud=9;

int last;

int buttonY = 620;
int buttonx = 200;
int buttonSize = 100;

boolean buttonOver1 = false;
boolean buttonOver2 = false;
boolean buttonOver3 = false;
boolean buttonOver4 = false;
 
int [] buttonX = {520, 640, 760, 880};

//Setup
void setup() {
  size(1000, 640);
  surface = height-200;
  sky = height/3;
  display();
}

void display() {
  for (int j = 0; j < many; j+= 1) {
    people[j]=  new Person(name[j]);
  }
}


void draw() {
  background(90, 120, 180);

  scene();
  displayPeople();
  cloud();
  button();
  update();
  message();
}

void keyPressed() {
  if      (key == 'q') exit();
  else if (key == 't') tall(people, many);
  else if (key == 'w') fat(people, many);
  else if (key == 'o') order(people, many);
  else if (key == 'r') rand(people, many);
}

void scene() {
  noStroke();
  fill(0, 255, 0);
  rectMode(CORNERS);
  rect(0, surface, width, height);
}

void displayPeople() {
  float x=100, y=surface;  // First person 
  
 // Height & Weight
  fill(255);
  text("Height:\nWeight:", 9, surface+35);  
  for (int j = 0; j < many; j+= 1) {
    people[j].show(x, y);
    x =  x + 100;
  }
}  

class Person {
  float x, w, h;
  float r, g, b;
  String name;

  Person( String friend ) {
    w = random(20, 100);     // Random weight from 20 to 50
    h = random(20, 100);    // Random height from 50 to 100
    r = random(255);        // Random red 
    g = random(255);        // Random green 
    b = random(255);        // Random blue 
    name = friend;
  }

  void show(float x, float y) {
    fill(r, g, b);
    rectMode(CENTER);
    stroke(0);
    rect(x, y-h/2, w, h);            // Body
    float shoulder=  y-h;            // Shoulder height
    float hh=  h/2.2;                  // Head height
    head(x, shoulder-hh/2, hh);

// Weight, Height, Name
    fill(0);                         // Name
    text( name, 2+x-w/2, y-h/2 );  
    fill(0);     
    text(int(h), x-20, y+36);        // Height
    text(int(w), x-20, y+54);        // Weight

  }
  void head(float x, float headY, float hh) {
    // Head
    ellipse(x, headY, hh, hh);
    fill(255, 0, 0);                  // Mouth Lips
    rect(x, headY+6, 4+w/4, 6);
    fill(255);                        // White teeth
    rect(x, headY+6, w/4, 2);
    fill(255);                        // White eyes
    ellipse(x-6, headY-6, 8, 8);
    ellipse(x+6, headY-6, 8, 8);
    fill(0, 0, 255);                  // Blue eyes
    ellipse(x-6, headY-6, 4, 4);
    ellipse(x+6, headY-6, 4, 4);
     // Hat
    fill( 255-r, 255-g, 255-b );
    triangle( x-hh/2,headY+3-hh/2, x+hh/2,headY+3-hh/2, x,headY-15-hh/2 );
  }
}

//values exchange
void xchange(Person[] p, int a, int b) {
  Person temp;
  temp=  p[a];
  p[a]=  p[b];
  p[b]=  temp;
}

// tallest to end
void tall( Person[] p, int last ) {
  int k=0;
    for (int j = 1; j < last; j+=1 ) {
    if (p[j].h > p[k].h) k=j;
  }
  xchange(p, k, last-1);
}

// widest to end
void fat( Person[] p, int last ) {
  int k=0;
    for (int j = 1; j < last; j+=1 ) {
    if (p[j].w > p[k].w) k=j;
  }
  xchange(p, k, last-1);
}

// Order from smallest to the biggest
void order ( Person[] p, int last) {
    for (int j = last; j > 1; j-= 1) {
    tall(p, j);
  }
}


// Reset random value
void rand(Person[] p, int last) {

  for (int j = 0; j < last; j+=1) {
    p[j].w = random(20, 100);
    p[j].h = random(20, 100);
  }
} 


void message() {
  int space = 20;

  fill(0);
  textSize(16);

  text(title, 20, 638);
  text(author, 20, 620);

  text(instruction1, width/15, 80);
  text(instruction2, width/15, 80 + space);
  text(instruction3, width/15, 80 + (space*2));
  text(instruction4, width/15, 80 + (space*3));
  text(instruction5, width/15, 80 + (space*4));
  
  text("Tallest", buttonX[0]-20, buttonY+5);
  text("Widest", buttonX[1]-20, buttonY+5);
  text("Order", buttonX[2]-15, buttonY+5);
  text("Random", buttonX[3]-18, buttonY+5);
}

void cloud() {
  fill(128, 128, 128);

  float tempX = cloudX, tempY = cloudY, tempW = 60, tempH = 25;

  for (int j=0; j < amountCloud; j+=1) {  // Loop the clouds
    ellipse(tempX, tempY, tempW, tempH);
    tempX = tempX - tempW;
    tempY = tempY + tempH;
    tempW *= 0.8;
    tempH *= 0.8;
  }
  cloudX = cloudX + cloudMovement;   // Movement

  if (cloudX > width + 250) {  // Reset the cloud at random height
    cloudX = 6;
    cloudY = random(0, sky);
    amountCloud = random(1, 9);
  }
}

void mousePressed() {
    if      (buttonOver1) {
      tall(people, many);
  } else if (buttonOver2) {
      fat(people, many);
  } else if (buttonOver3) {
      order(people, many);
  } else if (buttonOver4) {
      rand(people, many);
  }
}

void button() {
  float last = 4;

  fill(220, 20, 55);

  for ( int j = 0; j < last; j+=1) {
    ellipse(buttonX[j], buttonY, buttonSize, buttonSize);
  }
}

void update() {
  if (overButton (buttonX[0], buttonY, buttonSize, buttonSize) ) {
    buttonOver1 = true;
    buttonOver2 = false;
    buttonOver3 = false;
    buttonOver4 = false;
  } else if (overButton (buttonX[1], buttonY, buttonSize, buttonSize) ) {
    buttonOver1 = false;
    buttonOver2 = true;
    buttonOver3 = false;
    buttonOver4 = false;
  } else if (overButton (buttonX[2], buttonY, buttonSize, buttonSize) ) {
    buttonOver1 = false;
    buttonOver2 = false;
    buttonOver3 = true;
    buttonOver4 = false;
  } else if (overButton (buttonX[3], buttonY, buttonSize, buttonSize) ) {
    buttonOver1 = false;
    buttonOver2 = false;
    buttonOver3 = false;
    buttonOver4 = true;
  }
}

boolean overButton(int x, int y, int width, int height) {
  if (mouseX >= x-40 && mouseX <= x+40 && mouseY >= y-40 && mouseY <= y+40) {
    return true;
  } else {
    return false;
  }
}
