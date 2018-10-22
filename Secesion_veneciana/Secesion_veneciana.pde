// All Examples Written by Casey Reas and Ben Fry

// unless otherwise stated.

float theta;  

PImage marco, fondo;
Paleta miPaleta1, miPaleta2, miPaleta3, miPaleta4;
boolean mouseDragged, mousePressed, color1, color2, color3, color4, borrar;
int cant1, cant2, cant3, cant4, paleta, tiempo;
color c;

void setup() {

  size(800, 800);

  fondo = loadImage ("data/fondo.jpg");
  marco = loadImage ("data/marco.png");
  miPaleta1 = new Paleta( "../data/Gustav Klimt.jpg" );
  miPaleta2 = new Paleta( "../data/Koloman Moser.jpg" );
  miPaleta3 = new Paleta( "../data/Ferdinand Andri.jpg" );
  miPaleta4 = new Paleta( "../data/Joseph Maria Olbrich.jpg" );

  //image (fondo, 0, 0);
  background(250, 246, 174);
  image (fondo, 0, 0);

  color1 = true;

  paleta = int(random (1, 4));
}



void draw() {

  tiempo++;

  if (paleta == 1) {
    color1 = true;
  } else if (paleta == 2) {
    color2 = true;
  } else if (paleta == 3) {
    color3 = true;
  } else if (paleta == 4) {
    color4 = true;
  } else {
    color1 = false;
    color2 = false;
    color3 = false;
    color4 = false;
  }

  if (color1) {  
    c = miPaleta1.darUnColor( 100 );
  }
  if (color2) {  
    c = miPaleta2.darUnColor( 100 );
  }
  if (color3) {  
    c = miPaleta3.darUnColor( 100 );
  }
  if (color4) {  
    c = miPaleta4.darUnColor( 100 );
  }

  if (mouseDragged) {

    pushMatrix();

    frameRate(30);

    strokeWeight(random (0,3));

    stroke (0);
    fill (c);


    //float a = (mouseY / (float) height) * 360f;

    theta = radians(mouseY);

    translate(width/2+10, height/2+190);

    branch(400);
    popMatrix();
  }

  if (borrar) {
    image (fondo, 0, 0);
  }

  if (tiempo == 1) {
    tint (c);
  }
  image (marco, 0, 0);

  if (mousePressed) {
    noFill();
    strokeWeight(1);
    stroke (100);
    for (int fila=0; fila<cant1; fila++) {
      ellipse (46*fila+31, 35, random(60), random(60));
    }

    for (int fila=0; fila<cant2; fila++) {
      ellipse (46*fila+31, 764, random(60), random(60));
    }

    for (int columna=0; columna<cant3; columna++) {
      ellipse (33, 46*columna+78, random(60), random(60));
    }

    for (int columna=0; columna<cant4; columna++) {
      ellipse (764, 46*columna+78, random(60), random(60));
    }
  }
}

void mousePressed() {

  mousePressed = true;
  if (mouseY<68 && cant1<17) {   
    cant1++;
  }

  if (mouseY>725 && cant2<17) {
    cant2++;
  }

  if (mouseX<68 && cant3<15) {
    cant3++;
  }

  if (mouseX>725 && cant4<15) {
    cant4++;
  }
}

void mouseDragged() {

  if (mouseX<725 && mouseX>68 && mouseY<725 && mouseY>68) {   
    mouseDragged = true;
  }

  borrar = false;
}

void mouseReleased() {
  mouseDragged = false;
}

void keyPressed() {

  if (keyCode == UP) {
    paleta = 1;
  } else if (keyCode == RIGHT) {
    paleta = 2;
  } else if (keyCode == DOWN) {
    paleta = 3;
  } else if (keyCode == LEFT) {
    paleta = 4;
  }

  if (keyCode == ENTER) {
    borrar = true;
    tiempo = 0;
    cant1 = 0; 
    cant2 = 0; 
    cant3 = 0; 
    cant4 = 0; 
  }
}



void branch(float h) {

  // Each branch will be 2/3rds the size of the previous one

  h *= 0.66f;



  // All recursive functions must have an exit condition!!!!

  // Here, ours is when the length of the branch is 2 pixels or less

  if (h > 1) {

    pushMatrix();    // Save the current state of transformation (i.e. where are we now)

    rotate(theta);   // Rotate by theta

    ellipse (0, 0, random(40), -h);  // Draw the branch

    //line (0, 0, 0, -h);  // Draw the branch

    translate(0, -h); // Move to the end of the branch

    branch(h);       // Ok, now call myself to draw two new branches!!

    popMatrix();     // Whenever we get back here, we "pop" in order to restore the previous matrix state
  }
}


class Paleta {

  PImage imagen;

  Paleta( String nombre ) {
    imagen = loadImage( nombre );
  }

  color darUnColor() {
    int posX = int( random( imagen.width ));
    int posY = int( random( imagen.height ));
    return imagen.get( posX, posY );
  }

  color darUnColor( float alfa ) {
    int posX = int( random( imagen.width ));
    int posY = int( random( imagen.height ));
    color este = imagen.get( posX, posY ); 
    return color( red(este), green(este), blue(este), alfa );
  }
}