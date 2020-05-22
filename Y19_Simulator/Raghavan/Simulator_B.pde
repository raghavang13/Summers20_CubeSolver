import peasy.*;

PeasyCam rubik_cam;

class Face
{
  PVector normal;
  color c;
  Face(PVector normal,color c)
  {
    this.normal=normal;
    this.c=c;
  }
  void show()
  {
    pushMatrix();
    fill(c);
    rectMode(CENTER);
    translate(0.5*normal.x,0.5*normal.y,0.5*normal.z);
    if(abs(normal.x)>0)
    {
      rotateY(HALF_PI);
    }
    else if(abs(normal.y)>0)
    {
      rotateX(HALF_PI);
    }
    square(0,0,1);
    popMatrix();
  }
  
  
  void turnX(float angle)
  {
    PVector v1=new PVector();
    v1.y=round(normal.y*cos(angle)-normal.z*sin(angle));
    v1.z=round(normal.y*sin(angle)+normal.z*cos(angle));
    v1.x=round(normal.x);
    normal=v1;
  }
 
  void turnY(float angle)
  {
    PVector v1=new PVector();
    v1.x=round(normal.x*cos(angle)-normal.z*sin(angle));
    v1.z=round(normal.x*sin(angle)+normal.z*cos(angle));
    v1.y=round(normal.y);
    normal=v1;
  }
  
  void turnZ(float angle)
  {
    PVector v1=new PVector();
    v1.x=round(normal.x*cos(angle)-normal.y*sin(angle));
    v1.y=round(normal.x*sin(angle)+normal.y*cos(angle));
    v1.z=round(normal.z);
    normal=v1;
  }
  
}

class Cubie
{
  PMatrix3D matrix;
  int x=0;
  int y=0;
  int z=0;
  color colour;
  Face[] faces=new Face[6];
  
  Cubie(PMatrix3D m, int x,int y, int z)
  {
    this.matrix=m;
    this.x=x;
    this.y=y;
    this.z=z;
    colour=color(255);
    faces[0]=new Face(new PVector(0,0,-1),color(0,0,255));
    faces[1]=new Face(new PVector(0,0,1),color(0,255,0));
    faces[2]=new Face(new PVector(0,1,0),color(255,255,0));
    faces[3]=new Face(new PVector(0,-1,0),color(255));
    faces[4]=new Face(new PVector(1,0,0),color(255,0,0));
    faces[5]=new Face(new PVector(-1,0,0),color(255,150,0)); 
  }
  
  void turnFacesX(int direction)
  {
    for (Face f:faces)
    {
      f.turnX(direction*HALF_PI);
    }
  }
  void turnFacesY(int direction)
  { 
    for (Face f:faces)
    {
      f.turnY(direction*HALF_PI);
    }
  }
  void turnFacesZ(int direction)
  { 
    for (Face f:faces)
    {
      f.turnZ(direction*HALF_PI);
    }
  }
  
  void update(int x, int y, int z)
  {
    matrix.reset();
    matrix.translate(x,y,z);
    this.x=x;
    this.y=y;
    this.z=z;
  }
  
  
  void display()
  {
    noFill();
    stroke(0);
    strokeWeight(0.1);
    pushMatrix();
    applyMatrix(matrix);
    box(1);
    for(Face f:faces)
    {
      f.show();
    }
    popMatrix();
  }
}

Cubie[] cube= new Cubie[27];

void setup()
{
  size(600,600,P3D);
  background(100);
  rubik_cam=new PeasyCam(this,400);
  int ind=0;
  for(int x=-1;x<=1;x++)
  {
    for(int y=-1;y<=1;y++)
    {
      for(int z=-1;z<=1;z++)
      {        
        PMatrix3D matrix= new PMatrix3D();
        matrix.translate(x,y,z);
        cube[ind]=new Cubie(matrix,x,y,z);
        ind++;  
      }
    }
  }
  cube[2].colour=color(0,0,255);
  cube[0].colour=color(255,0,0);
}

void rotate_right(int index,int direction)
{
  for(int i=0;i<cube.length;i++)
  {
    if(cube[i].x==index)
    {
      PMatrix2D matrix= new PMatrix2D();
      matrix.rotate(direction*HALF_PI);
      matrix.translate(cube[i].y,cube[i].z);
      cube[i].turnFacesX(direction);
      cube[i].update(cube[i].x,round(matrix.m02),round(matrix.m12));
    }
  }
}


void rotate_up(int index,int direction)
{
  for(int i=0;i<cube.length;i++)
  {
    if(cube[i].y==index)
    {
      PMatrix2D matrix= new PMatrix2D();
      matrix.rotate(direction*HALF_PI);
      matrix.translate(cube[i].x,cube[i].z);
      cube[i].turnFacesY(direction);
      cube[i].update(round(matrix.m02),cube[i].y,round(matrix.m12));
    }
  }
}


void rotate_front(int index,int direction)
{
  for(int i=0;i<cube.length;i++)
  {
    if(cube[i].z==index)
    {
      PMatrix2D matrix= new PMatrix2D();
      matrix.rotate(direction*HALF_PI);
      matrix.translate(cube[i].x,cube[i].y);
      cube[i].turnFacesZ(direction);
      cube[i].update(round(matrix.m02),round(matrix.m12),cube[i].z);      
    }
  }
}

void keyPressed()
{
   switch (key)
   {
       case 'L':
         rotate_right(-1,-1);
         break;
       case 'l':
         rotate_right(-1,1);
         break;
       case 'R':
         rotate_right(1,1);
         break;  
       case 'r':
         rotate_right(1,-1);
         break;
       case 'U':
         rotate_up(-1,1);
         break;
       case 'u':
         rotate_up(-1,-1);
         break;  
       case 'D':
         rotate_up(1,-1);
         break;
       case 'd':
         rotate_up(1,1);
         break;
       case 'F':
         rotate_front(1,1);
         break;
       case 'f':
         rotate_front(1,-1);
         break;
       case 'B':
         rotate_front(-1,-1);
         break;
       case 'b':
         rotate_front(-1,1);
         break;
   }      
}
        
void draw()
{
  scale(50);
  clear();
  for(int i=0;i<cube.length;i++)
         cube[i].display();
}
