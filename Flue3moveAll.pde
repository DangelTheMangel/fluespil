// dette er listen over alle fluerne
ArrayList<Flue> flueListe = new ArrayList<Flue>();

// størrelse på lille flue
float s = 1;

// hvor nemt det er at smække fluerne en på hovdet
float delta = 20;

//motorsav 
PImage img;

//størrelse på vindue
void setup() {
  size(500, 500);
  img = loadImage("p.png");
}

void draw() {
  clear();
  background(180);

  //tegn og flyt fluer
  for (int i=0; i<flueListe.size(); i++) {
    Flue f = flueListe.get(i);
    f.tegnFlue();
    f.flyt();
  }
}

void keyPressed() {
  // når e bliver trykket laver den stor flue 
  if (key=='e') {
    flueListe.add(new Flue(random(0, 500), random(0, 500), 2));
  }
}

void mousePressed() {
  //tilføjer lille flue ved musen
  if (key =='w') {
    cursor(HAND);
    flueListe.add(new Flue(mouseX, mouseY, s));
  }
  // dræb fluer ved at klikke på dem
  if (key =='k') {
    cursor(CROSS);
    for (int i=0; i<flueListe.size(); i++) {
      Flue f = flueListe.get(i);
      float x = cos(f.vinkel) * (f.distanceFlyttet*f.size)  + f.positionX;
      float y = sin(f.vinkel) * (f.distanceFlyttet*f.size)  + f.positionY;
      
      if(abs(x - mouseX) < delta && abs(y - mouseY) < delta){
        f.dead = true;
      }
    }
  }
}

// definere jeg hvad en flue er 
class Flue {

  //variabler
  boolean dead = false;
  float positionX, positionY, size;
  float distanceFlyttet;
  float vinkel = 0; 
  float speed = 0.5;

  Flue() {
    //sæt flue tilfældigt
    positionX  = random(0, height);
    positionY  = random(0, width);
    vinkel     = random(0, 2*PI);
  }

  Flue(float a, float b, float c) {
    //sær flue på bestem plads
    positionX = a;
    positionY = b;
    vinkel    = random(0, 2*PI);
    size = c;
  }

  void flyt() {


    //sørger for fluer blive inden for vinduet
    if ((cos(vinkel) * (distanceFlyttet*size)  + positionX) > width ||
      (cos(vinkel) * (distanceFlyttet*size)  + positionX) < 0) {
      speed *= -1;
    }
    if ((sin(vinkel) * (distanceFlyttet*size)  + positionY) > height ||
      (sin(vinkel) * (distanceFlyttet*size)  + positionY) < 0) {
      speed *= -1;
    }
    if (dead == false) {
      distanceFlyttet +=  speed;
    }
  }

  void tegnFlue() {

    //definere hvordan fluen ser ud med: størrelse, vinkel og form
    pushMatrix();
    translate(positionX, positionY);
    scale(size);
    rotate(vinkel);
    translate(distanceFlyttet, 0);
    if ( dead == false) {
      ellipse(0, 0, 20, 8);
      ellipse(0, 0-8, 15, 10);
      ellipse(0, 0+8, 15, 10);
      ellipse(0+6, 0, 8, 8);
    } else {
      noStroke();
      fill(255, 0, 0, 100);
      ellipse(0, 0, 20, 20);
      fill(255);
      stroke(0);
    }
    popMatrix();
  }
}
