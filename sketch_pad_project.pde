color black=#030303;
color white=#FFFFFF;
color red=#EA381C;
color orange=#EA9C1C;
color yellow=#EAE11C;
color green=#4FB419;
color blue=#1BBAF2;
color pink=#D85CCC;

color selected;

PImage cursor;
boolean cursorOn;
int a=10;
int b=100;

float sliderY;
float shade;
float thickness;

float m, n, k;

void setup(){
  size(600, 600);
  background(255);
  cursor=loadImage("cursor.png");
  cursorOn=false;
  sliderY=425;
  thickness=0;
  
  //initialize m, n, k, j
  m=60;
  n=390;
  k=60;
}

void draw(){
  //toolbar
  stroke(0);
  strokeWeight(1);
  fill(100);
  rect(0, 0, 125, 600);
  
  //color selector
  colorSelector(a, b+20, red);
  colorSelector(a, b+50, orange);
  colorSelector(a, b+80, yellow);
  colorSelector(a, b+110, green);
  colorSelector(a, b+140, blue);
  colorSelector(a, b+170, pink);
  colorSelector(a, b+200, black);
  
  //cursor button
  tactile(a, a, b, b);
  cursorOnOff();
  fill(white);
  ellipse(a+45, a+50, b, b);
  image(cursor, a, a, b, b);
  
  //color indicator
  colorIndicator(60, 360);
  
  //slider
  slider(60, 390, 60);
  
  thickness=map(sliderY, m, n+80, 80, 3);
  
  //new, load, save
  newButton();
  loadButton();
  saveButton();
}
  
void mouseDragged(){
  if (cursorOn==false){
    //squiggly line
    strokeWeight(thickness);
    stroke(selected);
    line(pmouseX, pmouseY, mouseX, mouseY);
  } else {
    //cursor drawing
    image(cursor, mouseX, mouseY, 100, 100);
  }
  controlSlider();
}

void mouseReleased(){
  //cursor button
  if(mouseX>0 && mouseX<100 && mouseY>0 && mouseY<100){
    cursorOn=!cursorOn;
  }
  
  if (mouseY>b+20 && mouseY<b+45 && mouseX>a && mouseX<a+70)
  selected=red;
  else if (mouseY>b+50 && mouseY<b+75 && mouseX>a && mouseX<a+70)
  selected=orange; //<>//
  else if (mouseY>b+80 && mouseY<b+105 && mouseX>a && mouseX<a+70)
  selected=yellow;
  else if (mouseY>b+110 && mouseY<b+135 && mouseX>a && mouseX<a+70)
  selected=green;
  else if (mouseY>b+140 && mouseY<b+165 && mouseX>a && mouseX<a+70)
  selected=blue;
  else if (mouseY>b+170 && mouseY<b+195 && mouseX>a && mouseX<a+70)
  selected=pink;
  else if (mouseY>b+200 && mouseY<b+215 && mouseX>a && mouseX<a+70)
  selected=black;
  
  controlSlider();
  
  //new
  if(mouseX>a && mouseX<a+100 && mouseY>b+390 && mouseY<b+415)
  background(white);
  
  //load
  if(mouseX>a && mouseX<a+100 && mouseY>b+420 && mouseY<b+435)
  selectInput("Pick an Image", "openImage");
  
  //save
  if(mouseX>a && mouseX<a+100 && mouseY>b+450 && mouseY<b+475)
  selectOutput("Choose a Name","saveImage");
}

void tactile(int x, int y, int w, int h){
  if (mouseX>x && mouseX<x+w && mouseY>y && mouseY<y+h)
    strokeWeight(5);

}

void colorSelector(int a, int b, color d){
  strokeWeight(3);
  stroke(black);
  tactile(a, b, 100, 25);
  fill(d);
  rect(a, b, 100, 25);
}

void colorIndicator(int x, int y){
  strokeWeight(thickness);
  stroke(white);
  fill(selected);
  circle(x, y, 40);
}

void slider(float x, float y, float a){
  x=m;
  y=n;
  a=k;
  
  fill(white);
  line(x, y, x, y+80);
  circle(a, sliderY, 10);
}


void controlSlider(){
  if (mouseX>m-5 && mouseX<m+5 && mouseY<n+80 && mouseY>n){
   sliderY=mouseY;
  }
   
   if (mouseX>m-5 && mouseX<m+5 && mouseY<100)
   sliderY=n;
   
   if (mouseX>m-5 && mouseX<m+5 && mouseY>700)
   sliderY=n+80;
}

void cursorOnOff(){
  if(cursorOn==true){
    stroke(255, 0, 0);
    strokeWeight(5);
  } else {
    stroke(0);
    strokeWeight(1);
  }
}

void newButton(){
  stroke(black);
  strokeWeight(2);
  fill(white);
  rect(a, b+390, 100, 25);
  fill(selected);
  textAlign(CENTER, CENTER);
  textSize(15);
  text("New", a+50, b+400);
}

void loadButton(){
  stroke(black);
  strokeWeight(2);
  fill(white);
  rect(a, b+420, 100, 25);
  fill(selected);
  textAlign(CENTER, CENTER);
  textSize(15);
  text("Load", a+50, b+430);
}

void saveButton(){
  stroke(black);
  strokeWeight(2);
  fill(white);
  rect(a, b+450, 100, 25);
  fill(selected);
  textAlign(CENTER, CENTER);
  textSize(15);
  text("Save", a+50, b+460);
}

void openImage(File f){
 if(f!=null){
   int n=0;
   while (n<10){
     PImage pic=loadImage (f.getPath());
     image(pic, 0, 0);
     n=n+1;
   }
 }
}

void saveImage(File f){
   if(f!=null){
     PImage canvas=get(71, 1, width-71, height-1);
     canvas.save(f.getAbsolutePath());
   }
 }
