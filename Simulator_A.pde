//program to just display the cube 

import peasy.*;

PeasyCam rubik_cam;
//array of colours for different faces of cube- white,yellow,blue,green,red,orange
color[] colors={color(255),color(255,255,0),color(0,0,255),color(0,255,0),color(255,0,0),color(255,165,0)};

//has features of individual cubies and methods to display the cube
class Cubie
{
  PVector position;
  float len;
  Cubie(float x, float y, float z, float leng)
  {
    position=new PVector(x,y,z);  //keeps track of position of cubie
    len=leng;  //side length of cubie
  }
  void display()
  {
    fill(255);
    stroke(0);
    strokeWeight(8);
    pushMatrix();
    translate(position.x,position.y,position.z);
    beginShape(QUADS);
    
    float shift=len/2;
    
    //y-fixed
    fill(colors[0]); //white face
    vertex(shift,-shift,shift);
    vertex(-shift,-shift,shift);
    vertex(-shift,-shift,-shift);
    vertex(shift,-shift,-shift);
    
    fill(colors[1]);  //yellow face
    vertex(shift,shift,shift);
    vertex(-shift,shift,shift);
    vertex(-shift,shift,-shift);
    vertex(shift,shift,-shift);
    
    //z-fixed
    
    fill(colors[2]);  //blue-face  
    vertex(shift,shift,-shift);
    vertex(shift,-shift,-shift);
    vertex(-shift,-shift,-shift);
    vertex(-shift,shift,-shift);
    
    fill(colors[3]);  //green face
    vertex(shift,shift,shift);
    vertex(shift,-shift,shift);
    vertex(-shift,-shift,shift);
    vertex(-shift,shift,shift);
    
    //x-fixed
    
    fill(colors[4]);  //red face
    vertex(shift,shift,shift);
    vertex(shift,-shift,shift);
    vertex(shift,-shift,-shift);
    vertex(shift,shift,-shift);
 
    fill(colors[5]);  //orange face
    vertex(-shift,shift,shift);
    vertex(-shift,-shift,shift);
    vertex(-shift,-shift,-shift);
    vertex(-shift,shift,-shift);
    
    endShape();
    popMatrix();
  }
}

Cubie[][][] cube= new Cubie[3][3][3];
void setup()
{
  size(600,600,P3D);   //to display cube in 3D
  background(100);
  rubik_cam=new PeasyCam(this,400);
  for(int i=0;i<3;i++)
  {
    for(int j=0;j<3;j++)
    {
      for(int k=0;k<3;k++)
      {
        float len=50;
        float x=len*(i-1);
        float y=len*(j-1);
        float z=len*(k-1);
        cube[i][j][k]=new Cubie(x,y,z,len);
      }
    }
  }
}
        
void draw()
{
  clear();
  for(int i=0;i<3;i++)
  {
    for(int j=0;j<3;j++)
    {
      for(int k=0;k<3;k++)
      {  
         cube[i][j][k].display();
      }
    }
  }
}
