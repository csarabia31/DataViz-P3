import java.util.Arrays;

//creating rectangle class for the y axis of the different data 
class Rectangle implements Comparable{

  //data for each rectangle
  float xpos;
  float ypos;
  float w;
  float h;
  String name;
  boolean click = false;
  
  //constructor for rectangle class
  Rectangle(float _xpos, float _ypos, float _w, float _h, String _name)
  {
 
    name = _name;
    xpos = _xpos;
    ypos = _ypos;
    w = _w;
    h = _h;
    
  }
  
  //displaying the actual rectangle
  void display(){
    
     fill(0);
     rect(xpos, ypos, w, h);
    
  }
  
  
  //comparator function used for sorting the array of objects
  int compareTo(Object o){
            Rectangle r = (Rectangle)o;
            float result = xpos-r.xpos;
            int value =  (int) result; // 3
            return value;
      }
}

class Ellipse implements Comparable{
  
  float xpos;
  float ypos;
  float w;
  float h;
  
  Ellipse(float _xpos, float _ypos, float _w, float _h)
  {
 
    xpos = _xpos;
    ypos = _ypos;
    w = _w;
    h = _h;
    
  }
  
  void display(){
    
     fill(255,0,0);
     ellipse(xpos, ypos, 5, 5);
    
  }
  
  int compareTo(Object o){
            Ellipse r = (Ellipse)o;
            float result = xpos-r.xpos;
            int value =  (int) result; // 3
            return value;
      }
}

class ParallelCoordinate extends Frame {

  

  //variables to get  the information from the csv file
  String satm, satv, act, gpa;
  float minSatm, minSatv, minAct, minGpa, maxSatm, maxSatv, maxAct, maxGpa;
  float [] satmData, satvData, actData, gpaData; 
  float y1, y2, y3,y4;
  
  //setting a margin
  float xMargin = 120;
  int startPos = 120;
  float temp;
  
  //means
  float meanSatm = 0;
  float meanSatv = 0;
  float meanAct = 0;
  float meanGpa=0;
  
  //standard deviations
  float stdSatm=0;
  float stdSatv=0;
  float stdGpa = 0;
  float stdAct = 0;
  
  //std part 2
  float stdSatmRank;
  float stdSatvRank;
  float stdGpaRank ;
  float stdActRank ;
  
  //pearson correlation coefficient
  float satmSatvPcc;
  float satmActPcc;
  float satmGpaPcc;
  float satvActPcc;
  float satvGpaPcc;
  float actGpaPcc;
  
  //spearman correlation
  float satmSatvSp;
  float satmActSp;
  float satmGpaSp;
  float satvActSp;
  float satvGpaSp;
  float actGpaSp;
  
  
  //booleans to be used for mouse pressed and mouse released function
  boolean locked;
  boolean locked2;
  boolean locked3;
  boolean locked4;
  
  float SatmSatvCov;
  float SatmActCov;
  float SatmGpaCov;
  float SatvActCov;
  float SatvGpaCov;
  float ActGpaCov;
  
  
  float satmRank[] = new float[myTable.getRowCount()];
  float satvRank[] = new float[myTable.getRowCount()];
  float actRank[] = new float[myTable.getRowCount()];
  float gpaRank[] = new float[myTable.getRowCount()];
  
  float satmRankMean;
  float satvRankMean;
  float actRankMean;
  float gpaRankMean;
  
  //Pvectors to get positions of all of the points
  PVector[] positions1 = new PVector[myTable.getRowCount()];
  PVector[] positions2 = new PVector[myTable.getRowCount()];
  PVector[] positions3 = new PVector[myTable.getRowCount()];
  PVector[] positions4 = new PVector[myTable.getRowCount()];
  
  //getting the positions of barchart
  PVector[] barPositions = new PVector[myTable.getRowCount()];
    
  
  //creating the rectangle objects
  Rectangle rect1 = new Rectangle(startPos,50, 0, 250, "SATV");
  Rectangle rect2 = new Rectangle((startPos*2),50, 0, 250, "SATM");
  Rectangle rect3 = new Rectangle((startPos*3),50, 0, 250, "ACT");
  Rectangle rect4 = new Rectangle((startPos*4),50, 0, 250, "GPA");
  
  //public vector <Rectangle> objVector = new vector <Rectangle>(50);
  
  //creating an array of objects (rectangles) to be sorted later according to their x position
  Rectangle[] rects = new Rectangle[4];
  { 
    rects[0] = rect1;
    rects[1] = rect2;
    rects[2] = rect3;
    rects[3] = rect4;
  }
  
  float x,y;
  float w = 1;
  float h = 1;
  int rectWidth = 90;
  float rectHeight = 80;
  
  //ellipse
  Ellipse[] elps1 = new Ellipse[myTable.getRowCount()];
  
  //scatterplot
  Ellipse[] elps = new Ellipse[myTable.getRowCount()];
  
  
  
 ParallelCoordinate( String _satm, String _satv, String _act, String _gpa ) {
   //constructor
    satm = _satm;
    satv = _satv;
    act = _act;
    gpa = _gpa;
    
  
    //getting the data from the file
    satmData = myTable.getFloatColumn(satm);
    satvData = myTable.getFloatColumn(satv);
    actData = myTable.getFloatColumn(act);
    gpaData = myTable.getFloatColumn(gpa);
    
    //getting max and min values of each of the four types of data to be used for y axis labeling
    minSatm = min(satmData);
    maxSatm = max(satmData);
    
    minSatv = min(satvData);
    maxSatv = max(satvData);
    
    minAct = min(actData);
    maxAct = max(actData);
    
    minGpa = min(gpaData);
    maxGpa = max(gpaData);
    
  }
  
  
  

void draw() { 
    
  
  //legend
  
  
  
  background(175);
  stroke(0);
  
  fill(255,0,0);
  text ("*Hover the mouse over\n any data points\n green ellipses\n appear  on the \n highlighted data\n rectangles are \n highlighted red\n", 5,12);
  fill(0);
  //text("SATV SCORES (BARCHART)", 800, 365);
  text("S\nA\nT\nV", 790, 500);
  text("SATM", 1000, 680);
  text("S\nA\nT\nV", 5, 500);
  text("SATM", 200, 680);
  
  
  //legend
  //fill(150,0,0);
  //text("*Drag any line and drop it inbetween the two lines you want to locate it at", 5, 20);
  //text("*Hover over any point to get the respective data", 5, 40);
  
  //displaying the rectangles
  rect1.display();
  rect2.display();
  rect3.display();
  rect4.display();
  
  //displaying each of the names of the data 
  text(rect1.name, rect1.xpos-5, 320);
  text(rect2.name, rect2.xpos-5, 320);
  text(rect3.name, rect3.xpos-5, 320);
  text(rect4.name, rect4.xpos-5, 320);
  
  
  for(int i = 0; i<myTable.getRowCount(); i++)
  {
    //mapping values to their respective rectangles (y axis)
    y1=map(satvData[i], minSatv, maxSatv, 300, 50);
    y2=map(satmData[i], minSatm, maxSatm, 300, 50);
    y3=map(actData[i], minAct, maxAct, 300, 50);
    y4=map(gpaData[i], minGpa, maxGpa, 300, 50);
    stroke(0);
    fill(255);
    
    fill(255,0,0);
    //displaying min and max values for each of the different types of data
    text(maxSatv, rect1.xpos, 30);
    text(minSatv, rect1.xpos, 310);
    
    text(maxSatm, rect2.xpos, 30);
    text(minSatm, rect2.xpos, 310);
    
    text(maxAct, rect3.xpos, 30);
    text(minAct, rect3.xpos, 310);
    
    text(maxGpa, rect4.xpos, 30);
    text(minGpa, rect4.xpos, 310);
   
   //settong color for the lines depending on values 
       if(y1 < (400/3)+25)
         stroke(0);
       else if(y1<(400/3)*2)
         stroke(0,0,255);
       else if (y1 > (400/3)*2 && y1 < (400/3) *3)
         stroke(0,255,0);
       else stroke(255,0,0);
   
     //if-else function to pick where the data lines are going to be mapped to
     //satv
    
    
    if(rect1.xpos>=xMargin && rect1.xpos<=width-xMargin)
    {
       
       if(rect1.xpos+xMargin == rect2.xpos)
           line(rect1.xpos, y1, rect2.xpos, y2);
           
       else if(rect1.xpos+xMargin == rect3.xpos)
           line(rect1.xpos, y1, rect3.xpos, y3);
           
       else if(rect1.xpos+xMargin == rect4.xpos)   
           line(rect1.xpos, y1, rect4.xpos, y3);
         
   }
   //satm
   if(rect2.xpos>=xMargin && rect2.xpos<=width-xMargin)
    {
       if(rect2.xpos+xMargin == rect1.xpos)
           line(rect2.xpos, y2, rect1.xpos, y1);
           
       else if(rect2.xpos+xMargin == rect3.xpos)
           line(rect2.xpos, y2, rect3.xpos, y3);
           
       else if(rect2.xpos+xMargin == rect4.xpos)   
           line(rect2.xpos, y2, rect4.xpos, y4);
         
   }
   //act
   if(rect3.xpos>=xMargin && rect3.xpos<=width-xMargin)
    {
       if(rect3.xpos+xMargin == rect1.xpos)
           line(rect3.xpos, y3, rect1.xpos, y1);
           
       else if(rect3.xpos+xMargin == rect2.xpos)
           line(rect3.xpos, y3, rect2.xpos, y2);
           
       else if(rect3.xpos+xMargin == rect4.xpos)   
           line(rect3.xpos, y3, rect4.xpos, y4);
         
   }
   //gpa
   if(rect4.xpos>=xMargin && rect4.xpos<=width-xMargin)
    {
       if(rect4.xpos+xMargin == rect1.xpos)
           line(rect4.xpos, y4, rect1.xpos, y1);
           
       else if(rect4.xpos+xMargin == rect2.xpos)
           line(rect4.xpos, y4, rect2.xpos, y2);
           
       else if(rect4.xpos+xMargin == rect3.xpos)   
           line(rect4.xpos, y4, rect3.xpos, y3);
         
   }
     
      fill(255);
      stroke(0);
      //drawing the elipses(data points) in each of the y axis rectangles
      //and getting their respective positions which are stored in Pvector
      positions1[i]= new PVector(rect1.xpos,y1);
      ellipse(rect1.xpos,y1, 5,5);
      
      positions2[i]= new PVector(rect2.xpos,y2);
      ellipse(rect2.xpos,y2, 5,5);
      
      positions3[i]= new PVector(rect3.xpos,y3);
      ellipse(rect3.xpos,y3, 5,5);
      
      positions4[i]= new PVector(rect4.xpos,y4);
      ellipse(rect4.xpos,y4, 5,5);
      
      //using position of ellipses so that when the mouse is over a certain point it'll show information
      //for that respective point
       float d = dist(mouseX, mouseY, positions1[i].x, positions1[i].y);
       if (d < 2.5) 
       {
         
               
               //barchart
               fill(255,0,0);
               //rect(barPositions[i].x, barPositions[i].y-35, 2, 350-barPositions[i].y);
               
                //linechart
                fill(0,125,0);
                ellipse(elps1[i].xpos, elps1[i].ypos ,15,15);
               
               //parallel coordinate
               ellipse(positions1[i].x, positions1[i].y , 15, 15);
               ellipse(positions2[i].x, positions2[i].y , 15, 15);
               ellipse(positions3[i].x, positions3[i].y , 15, 15);
               ellipse(positions4[i].x, positions4[i].y , 15, 15);
               
               
               
               //scatterplot
               ellipse(elps[i].xpos, elps[i].ypos, 15,15);
               
               
               
               
               text("SATV:", width-80, height-65); 
               text(myTable.getInt(i,1), width-40, height-65);
               
       }
       
       float d2 = dist(mouseX, mouseY, positions2[i].x, positions2[i].y);
       if (d2 < 2.5) 
       {
         
         
               fill(255,0,0);
               //rect(barPositions[i].x, barPositions[i].y-35, 2, 350-barPositions[i].y);
               fill(0,125,0);
                //linechart
               ellipse(elps1[i].xpos, elps1[i].ypos , 15, 15);
               
               //parallel coordinate
               ellipse(positions1[i].x, positions1[i].y , 15, 15);
               ellipse(positions3[i].x, positions3[i].y , 15, 15);
               ellipse(positions4[i].x, positions4[i].y , 15, 15);
               
               
               
               //scatterplot
               ellipse(elps[i].xpos, elps[i].ypos, 15,15);
               
               //pc
               ellipse(positions2[i].x, positions2[i].y , 5, 5);
               
             
               
               
               text("SATM:", width-80, height-65); 
               text(myTable.getInt(i,0), width-40, height-65);
               
       }
       
       float d3 = dist(mouseX, mouseY, positions3[i].x, positions3[i].y);
       if (d3 < 2.5) 
       {
               
               fill(255,0,0);
               //rect(barPositions[i].x, barPositions[i].y-35, 2, 350-barPositions[i].y);
               
                //linechart
                fill(0,125,0);
                ellipse(elps1[i].xpos, elps1[i].ypos , 15, 15);
               
               //parallel coordinate
               ellipse(positions1[i].x, positions1[i].y , 15, 15);
               ellipse(positions2[i].x, positions2[i].y , 15, 15);
               ellipse(positions3[i].x, positions3[i].y , 15, 15);
               ellipse(positions4[i].x, positions4[i].y , 15, 15);
               
               
               
               //scatterplot
               ellipse(elps[i].xpos, elps[i].ypos, 15,15);
               text("ACT:", width-80, height-65); 
               text(myTable.getInt(i,2), width-40, height-65);
               
       }
       
       float d4 = dist(mouseX, mouseY, positions4[i].x, positions4[i].y);
       if (d4 < 2.5) 
       {
               //rectangle
               fill(255,0,0);
               //rect(barPositions[i].x, barPositions[i].y-35, 2, 350-barPositions[i].y);
               
                //linechart
                fill(0,125,0);
                ellipse(elps1[i].xpos, elps1[i].ypos , 15, 15);
               
               //parallel coordinate
               ellipse(positions1[i].x, positions1[i].y , 15, 15);
               ellipse(positions2[i].x, positions2[i].y , 15, 15);
               ellipse(positions3[i].x, positions3[i].y , 15, 15);
               ellipse(positions4[i].x, positions4[i].y , 15, 15);
               
               
               
               //scatterplot
               ellipse(elps[i].xpos, elps[i].ypos, 15,15);
               text("GPA:", width-80, height-65); 
               text(myTable.getFloat(i,3), width-40, height-65);
               
       }
     
     
   }
  
   //calling mouse dragged function defined below
   mouseDragged();
   
   
   //calling the functions
   //drawBarchart();
   drawHistogram1();
   drawHistogram2();
   drawHistogram3();
   drawHistogram4();
   
   drawLineChart();
   drawScatterPlot();
   graphStructure();
   
   PearsonCoefficient();
   
   
   satmRank = rank(satmData);
   satvRank = rank(satvData);
   actRank = rank(actData);
   gpaRank = rank(gpaData);
   
   
   
   satmRank();
   satvRank();
   gpaRank();
   actRank();
   spearmanCorrelation();
  
   
}


  void mousePressed() { 
 
    
    //if mouse is in the position of any of the rectangles, their respective locked value  = true
    if(mouseX>=rect1.xpos-10 && mouseX<=rect1.xpos+10 && mouseY>=50 && mouseY<=300)
          locked = true;
    
    
    if(mouseX>=rect2.xpos-10 && mouseX<=rect2.xpos+10 && mouseY>=50 && mouseY<=300)
          locked2 = true;
          
    if(mouseX>=rect3.xpos-10 && mouseX<=rect3.xpos+10 && mouseY>=50 && mouseY<=300)
          locked3 = true;
          
          
    if(mouseX>=rect4.xpos-10 && mouseX<=rect4.xpos+10 && mouseY>=50 && mouseY<=300)
          locked4 = true;
    
    
    
  }

  void mouseReleased() {  
    
    //when the mouse is released, sort the array and set that position to a fixed position
     Arrays.sort(rects);
    rects[0].xpos = 120;
    rects[1].xpos = 240;
    rects[2].xpos = 360;
    rects[3].xpos = 480;
    
    //when mouse is released all locked values become false
     locked = false;
     locked2 = false;
     locked3 = false;
     locked4 = false;
  }
  
  void mouseDragged(){
    
    //when mouse is dragged in between the screen, move the x position according to the locked value that is true
    if(mouseX >= 0 && mouseX<=width)
    {
      if(locked==true)
         rect1.xpos += mouseX-pmouseX;
        
          
      if(locked2==true)
          rect2.xpos += mouseX-pmouseX;
      if(locked3==true)
          rect3.xpos += mouseX-pmouseX;
      if(locked4==true)
          rect4.xpos += mouseX-pmouseX;
    }
    
        
  }
 
 
void drawHistogram1(){
  
  
  
  int bin1=0 , bin2=0, bin3=0, bin4=0, bin5=0;
  
  //for SATM
  for(int i = 0;i<myTable.getRowCount();i++)
  {
    if(myTable.getFloat(i,0) >= 280 && myTable.getFloat(i,0) < 384)
            bin1++;
    if(myTable.getFloat(i,0) >= 384 && myTable.getFloat(i,0) < 488)
            bin2++;
    if(myTable.getFloat(i,0) >= 488 && myTable.getFloat(i,0) < 592)
            bin3++;
    if(myTable.getFloat(i,0) >= 592 && myTable.getFloat(i,0) < 696)
            bin4++;
    if(myTable.getFloat(i,0) >= 696 && myTable.getFloat(i,0) < 800)
            bin5++;
            
  }

  int[] bins1 = new int[5];
  bins1[0] = bin1;
  bins1[1] = bin2;
  bins1[2] = bin3;
  bins1[3] = bin4;
  bins1[4] = bin5;
  
  int maxBins = max(bins1);
  //int minBins = min(bins);
  
  float ypos1 = map(bin1,0,maxBins,350,200);
  float ypos2 = map(bin2,0,maxBins,350,200);
  float ypos3 = map(bin3,0,maxBins,350,200);
  float ypos4 = map(bin4,0,maxBins,350,200);
  float ypos5 = map(bin5,0,maxBins,350,200);
  
  fill(0,0,200);
  stroke(255);
  rect(600,ypos1,50,350-ypos1);
  rect(650,ypos2,50,350-ypos2);
  rect(700,ypos3,50,350-ypos3);
  rect(750,ypos4,50,350-ypos4);
  rect(800,ypos5,50,350-ypos5);
  
  fill(0);
  text(bin1, 620, ypos1);
  text(bin2, 670, ypos2+10);
  text(bin3, 720, ypos3+10);
  text(bin4, 770, ypos4+10);
  text(bin5, 820, ypos5+10);
  
  
  //lines for axis
  
  stroke(0);
  line(590,350,590,195);
  line(590,350,860,350);
  
  fill(0);
  text("Satm", 720, 362);
  
  
  
  //calculating mean
  
  float sum = 0;
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum += satmData[i];
  meanSatm = sum/myTable.getRowCount();
  
  
  //calculating standard deviation
  float stdTemp = 0;
  float[] std = new float[myTable.getRowCount()];
  for(int i = 0 ;i<myTable.getRowCount();i++)
  {
     stdTemp = satmData[i] - meanSatm;
     stdTemp *= stdTemp;
     std[i] = stdTemp;
  }
  
  float sum2=0;
  float mean2=0;
  
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum2+=std[i];
  mean2=sum2/myTable.getRowCount();
  
  stdSatm = sqrt(mean2);
  //println(stdSatm);
  //println(mean);
 
  fill(0);
  text("Mean = ", 590, 300);
  text(meanSatm,630,300);
  text("Std = ", 590, 270);
  text(stdSatm,630,270);
}

void drawHistogram2(){
  //for SATV
  int bin1=0 , bin2=0, bin3=0, bin4=0, bin5=0;

  for(int i = 0;i<myTable.getRowCount();i++)
  {
    if(myTable.getFloat(i,1) >= 280 && myTable.getFloat(i,1) < 384)
            bin1++;
    if(myTable.getFloat(i,1) >= 384 && myTable.getFloat(i,1) < 488)
            bin2++;
    if(myTable.getFloat(i,1) >= 488 && myTable.getFloat(i,1) < 592)
            bin3++;
    if(myTable.getFloat(i,1) >= 592 && myTable.getFloat(i,1) < 696)
            bin4++;
    if(myTable.getFloat(i,1) >= 696 && myTable.getFloat(i,1) <= 800)
            bin5++;
            
  }
  
  int[] bins = new int[5];
  bins[0] = bin1;
  bins[1]=bin2;
  bins[2]=bin3;
  bins[3] = bin4;
  bins[4] = bin5;
  
  //for(int i = 0;i<5;i++)
    //println(bins[i]);
    
  int maxBins = max(bins);
  
  float ypos1 = map(bin1,0,maxBins,350,200);
  float ypos2 = map(bin2,0,maxBins,350,200);
  float ypos3 = map(bin3,0,maxBins,350,200);
  float ypos4 = map(bin4,0,maxBins,350,200);
  float ypos5 = map(bin5,0,maxBins,350,200);
  
  stroke(255);
  fill(0,0,255);
  rect(900,ypos1,50,350-ypos1);
  rect(950,ypos2,50,350-ypos2);
  rect(1000,ypos3,50,350-ypos3);
  rect(1050,ypos4,50,350-ypos4);
  rect(1100,ypos5,50,350-ypos5);
  
  fill(0);
  text(bin1, 920, ypos1+10);
  text(bin2, 970, ypos2+10);
  text(bin3, 1020, ypos3+10);
  text(bin4, 1070, ypos4+10);
  text(bin5, 1120, ypos5+10);
  
  
  stroke(0);
  line(890,350,890,195);
  line(890,350,1160,350);
  
  fill(0);
  text("Satv", 1020, 365);
  
  //calculating mean
  
  float sum = 0;
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum += satvData[i];
  meanSatv = sum/myTable.getRowCount();
  
  
  //calculating standard deviation
  float stdTemp = 0;
  float[] std = new float[myTable.getRowCount()];
  for(int i = 0 ;i<myTable.getRowCount();i++)
  {
     stdTemp = satvData[i] - meanSatv;
     stdTemp *= stdTemp;
     std[i] = stdTemp;
  }
  
  float sum2=0;
  float mean2=0;
  
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum2+=std[i];
  mean2=sum2/myTable.getRowCount();
  
  stdSatv= sqrt(mean2);
  //println(stdSatv);
  
  //println(mean);
  fill(0);
  text("Mean = ", 890, 300);
  text(meanSatv,930,300);
  text("Std = ", 890, 270);
  text(stdSatv,930,270);
  
}

void drawHistogram3(){
  //for ACT
  int bin1=0 , bin2=0, bin3=0, bin4=0, bin5=0;

  for(int i = 0;i<myTable.getRowCount();i++)
  {
    if(myTable.getFloat(i,2) >= 15 && myTable.getFloat(i,2) < 19)
            bin1++;
    if(myTable.getFloat(i,2) >= 19 && myTable.getFloat(i,2) < 23)
            bin2++;
    if(myTable.getFloat(i,2) >= 23 && myTable.getFloat(i,2) < 27)
            bin3++;
    if(myTable.getFloat(i,2) >= 27 && myTable.getFloat(i,2) < 31)
            bin4++;
    if(myTable.getFloat(i,2) >= 31  && myTable.getFloat(i,2) <= 35)
            bin5++;
            
  }
  
  int[] bins = new int[5];
  bins[0] = bin1;
  bins[1]= bin2;
  bins[2]= bin3;
  bins[3] = bin4;
  bins[4] = bin5;
  
  //for(int i = 0;i<5;i++)
    //println(bins[i]);
    
  int maxBins = max(bins);
  
  float ypos1 = map(bin1,0,maxBins,160,10);
  float ypos2 = map(bin2,0,maxBins,160,10);
  float ypos3 = map(bin3,0,maxBins,160,10);
  float ypos4 = map(bin4,0,maxBins,160,10);
  float ypos5 = map(bin5,0,maxBins,160,10);
  
  fill(0,0,255);
  stroke(255);
  rect(900,ypos1,50,160-ypos1);
  rect(950,ypos2,50,160-ypos2);
  rect(1000,ypos3,50,160-ypos3);
  rect(1050,ypos4,50,160-ypos4);
  rect(1100,ypos5,50,160-ypos5);
  
  fill(0);
  text(bin1, 920, ypos1+10);
  text(bin2, 970, ypos2+10);
  text(bin3, 1020, ypos3+10);
  text(bin4, 1070, ypos4+10);
  text(bin5, 1120, ypos5+10);
  
  fill(0);
  text("ACT", 1020, 175);
  //calculating mean
  
  stroke(0);
  line(890,160,890,5);
  line(890,160,1160,160);
  
  
  float sum = 0;
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum += actData[i];
  meanAct = sum/myTable.getRowCount();
  
  //println(mean);
  
  //calculating standard deviation
  float stdTemp = 0;
  float[] std = new float[myTable.getRowCount()];
  for(int i = 0 ;i<myTable.getRowCount();i++)
  {
     stdTemp = actData[i] - meanAct;
     stdTemp *= stdTemp;
     std[i] = stdTemp;
  }
  
  float sum2=0;
  float mean2=0;
  
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum2+=std[i];
  mean2=sum2/myTable.getRowCount();
  
  stdAct = sqrt(mean2);
  //println(stdAct);
  
  fill(0);
  text("Mean = ", 890, 100);
  text(meanAct,930,100);
  text("Std = ", 890, 70);
  text(stdAct,930,70);
  
  
  
}

void drawHistogram4(){
  //For gpa
  int bin1=0 , bin2=0, bin3=0, bin4=0, bin5=0;

  for(int i = 0;i<myTable.getRowCount();i++)
  {
    if(myTable.getFloat(i,3) >= 1.704 && myTable.getFloat(i,3) < 2.1632)
            bin1++;
    if(myTable.getFloat(i,3) >= 2.1632 && myTable.getFloat(i,3) < 2.6224)
            bin2++;
    if(myTable.getFloat(i,3) >= 2.6224 && myTable.getFloat(i,3) < 3.0816)
            bin3++;
    if(myTable.getFloat(i,3) >= 3.0816 && myTable.getFloat(i,3) < 3.5408)
            bin4++;
    if(myTable.getFloat(i,3) >= 3.5408 && myTable.getFloat(i,3) <= 4)
            bin5++;
            
  }
  
  int[] bins = new int[5];
  bins[0] = bin1;
  bins[1]=bin2;
  bins[2]=bin3;
  bins[3] = bin4;
  bins[4] = bin5;
  
  //for(int i = 0;i<5;i++)
    //println(bins[i]);
    
  int maxBins = max(bins);
  
  float ypos1 = map(bin1,0,maxBins,160,10);
  float ypos2 = map(bin2,0,maxBins,160,10);
  float ypos3 = map(bin3,0,maxBins,160,10);
  float ypos4 = map(bin4,0,maxBins,160,10);
  float ypos5 = map(bin5,0,maxBins,160,10);
  
  fill(0);
  text("GPA", 720,175);
  fill(0,0,255);
  stroke(255);
  rect(600,ypos1,50,160-ypos1);
  rect(650,ypos2,50,160-ypos2);
  rect(700,ypos3,50,160-ypos3);
  rect(750,ypos4,50,160-ypos4);
  rect(800,ypos5,50,160-ypos5);
  
  fill(0);
  text(bin1, 620, ypos1+10);
  text(bin2, 670, ypos2+10);
  text(bin3, 720, ypos3+10);
  text(bin4, 770, ypos4+10);
  text(bin5, 820, ypos5+10);
  //calculating mean
    
  stroke(0);
  line(590,160,590,5);
  line(590,160,860,160);
  
  
  float sum = 0;
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum += gpaData[i];
  meanGpa = sum/myTable.getRowCount();
  
  float stdTemp = 0;
  float[] std = new float[myTable.getRowCount()];
  for(int i = 0 ;i<myTable.getRowCount();i++)
  {
     stdTemp = gpaData[i] - meanGpa;
     stdTemp *= stdTemp;
     std[i] = stdTemp;
  }
  
  float sum2=0;
  float mean2=0;
  
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum2+=std[i];
  mean2=sum2/myTable.getRowCount();
  
  stdGpa = sqrt(mean2);
  //println(stdGpa);
  
  
  //println(mean);
  
  fill(0);
  text("Mean = ", 590, 100);
  text(meanGpa,630,100);
  text("Std = ", 590, 70);
  text(stdGpa,630,70);
  
}

void drawLineChart(){
  
  
  //drawing linechart getting positions
  Ellipse[] elps2 = new Ellipse[myTable.getRowCount()];
  for(int i = 0; i<myTable.getRowCount();i++)
  {
      
      float xpos = map(satmData[i], minSatm, maxSatm, 810, 1190);
      float ypos = map(satvData[i], minSatv, maxSatv, 680, 360);
      stroke(255);
      fill(255,0,0);
      Ellipse el = new Ellipse(xpos, ypos, 5, 5);
      elps1[i] = el;
      elps2[i] = el;
      el.display();
      
      
      //highlighting data with respective positions
      float d = dist(mouseX, mouseY, elps1[i].xpos, elps1[i].ypos);
       if (d < 2.5) 
       {
         
               fill(0,125,0);
               //linechart
               ellipse(elps1[i].xpos, elps1[i].ypos , 10, 10);
               
               //parallel coordinate
               ellipse(positions1[i].x, positions1[i].y , 10, 10);
               ellipse(positions2[i].x, positions2[i].y , 10, 10);
               ellipse(positions3[i].x, positions3[i].y , 10, 10);
               ellipse(positions4[i].x, positions4[i].y , 10, 10);
               
               //scatterplot
               ellipse(elps[i].xpos, elps[i].ypos, 15,15);
               
               //barchart
               fill(255,0,0);
               //rect(barPositions[i].x, barPositions[i].y, 2, 350-barPositions[i].y);
               text("SATV:", width-80, height-65); 
               text(myTable.getInt(i,1), width-40, height-65);
               text("SATM:", width-80, height-55); 
               text(myTable.getInt(i,0), width-40, height-55);
               
       }
  }
  
  //sorting arrays to draw lines
  Arrays.sort(elps2);
  
  for(int i = 1; i<myTable.getRowCount();i++)
  {
    stroke(255);
    line(elps2[i].xpos, elps2[i].ypos, elps2[i-1].xpos, elps2[i-1].ypos);
  }
  
  
}

void drawScatterPlot(){
  
  //drawing the scatterplot, getting positions
  for(int i = 0; i<myTable.getRowCount();i++)
  {
      
      float xpos = map(satmData[i], minSatm, maxSatm, 20, 390);
      float ypos = map(satvData[i], minSatv, maxSatv, 660, 360);
      stroke(255);
      fill(255,0,0);
      Ellipse el = new Ellipse(xpos, ypos, 5, 5);
      elps[i] = el;
     
      el.display();
      
      //highlighting data
      float d = dist(mouseX, mouseY, elps[i].xpos, elps[i].ypos);
       if (d < 2.5) 
       {
         
               fill(0,125,0);
               ellipse(elps[i].xpos, elps[i].ypos, 10,10);
               
               ellipse(positions1[i].x, positions1[i].y , 10, 10);
               ellipse(positions2[i].x, positions2[i].y , 10, 10);
               ellipse(positions3[i].x, positions3[i].y , 10, 10);
               ellipse(positions4[i].x, positions4[i].y , 10, 10);
               
               ellipse(elps1[i].xpos, elps1[i].ypos, 10,10);
               
               fill(255,0,0);
               //rect(barPositions[i].x, barPositions[i].y, 2, 350-barPositions[i].y);
               text("SATV:", width-80, height-65); 
               text(myTable.getInt(i,1), width-40, height-65);
               text("SATM:", width-80, height-55); 
               text(myTable.getInt(i,0), width-40, height-55);
               
       }
  }
  
  
  
  
}

void drawScatterPlot1(){
  //scatter plots 1
  fill(204,229,229);
  rect(rectWidth*1+420,365,rectWidth,rectHeight);
  fill(0);
  text(satmSatvSp,rectWidth+450,400);

}
  

void drawScatterPlot2(){
  //scatter plot number 2
  
  fill(102,127,127);
  rect(rectWidth*2+420,rectHeight*3+365,rectWidth,rectHeight);
  fill(0);
  text(actGpaPcc,rectWidth*2+450,rectHeight*3+400);
  
}

void drawScatterPlot3(){
  //scatter plot number 3
  
  fill(255,204,204);
  rect(420,rectHeight*1+365,rectWidth,rectHeight);
  fill(0);
  text(satmSatvPcc,450,rectHeight+400);
  
}

void drawScatterPlot4(){
  //scatter plot 4
  
  fill(178,229,229);
  rect(rectWidth*3+420,rectHeight*2+365,rectWidth,rectHeight);
  fill(0);
  text(actGpaSp,rectWidth*3+450,rectHeight*2+400);
 
}

//scatter plots number 5
void drawScatterPlot5(){
  
  
  fill(255,153,153);
  rect(rectWidth*2+420,365,rectWidth,rectHeight);
  fill(0);
  text(satmActSp,rectWidth*2+450,400);
 
}
void drawScatterPlot6(){
 
  
  
  fill(255,102,102);
  rect(420,rectHeight*2+365,rectWidth,rectHeight);
  fill(0);
  text(satmActPcc,450,rectHeight*2+400);
  
}
//scatter plot 7
void drawScatterPlot7(){
  
  fill(255,51,51);
  rect(rectWidth*2+420,rectHeight*1+365,rectWidth,rectHeight);
  fill(0);
  text(satvActSp,rectWidth*2+450,rectHeight+400);
 
}
void drawScatterPlot8(){
  
  //scatter plot 8
  
  fill(255,0,0);
  rect(rectWidth*1+420,rectHeight*2+365,rectWidth,rectHeight);
  fill(0);
  text(satvActPcc,rectWidth+450,rectHeight*2+400);
  
}

//scatter plot 9
void drawScatterPlot9(){
  
  fill(0,102,102);
  rect(rectWidth*3+420,365,rectWidth,rectHeight);
  fill(255);
  text(satmGpaSp,rectWidth*3+450,400);
  
}
void drawScatterPlot10(){
 //scatter plot number 10
  
  fill(0,76,76);
  rect(420,rectHeight*3+365,rectWidth,rectHeight);
  fill(255);
  text(satmGpaPcc,450,rectHeight*3+400);
 
}
void drawScatterPlot11(){
  
  fill(76,127,127);
  rect(rectWidth*3+420,rectHeight*1+365,rectWidth,rectHeight);
  fill(0);
  text(satvGpaSp,rectWidth*3+450,rectHeight+400);
  
  
}
void drawScatterPlot12(){
 
  fill(0,153,153);
  rect(rectWidth*1+420,rectHeight*3+365,rectWidth,rectHeight);
  fill(0);
  text(satvGpaPcc,rectWidth+450,rectHeight*3+400);
 
}


void graphStructure(){
    
   //for loop to draw rectangle
  for(int i = 0; i<4;i++)
  {
    for(int j = 0; j<4;j++)
    {
      fill(255);
      stroke(0);
      rect((rectWidth*i)+420, (rectHeight*j)+365, rectWidth, rectHeight);
    }
    
  }
 
   
   
   //values shown in specific row/column
   fill(255,0,0);
   stroke(0);
   text("SATM", 450, 400);
   text("SATV", 540, 480);
   text("ACT", 635, 560);
   text("GPA", 720, 640);
   
   //calling functions to draw scatterplots
   drawScatterPlot1();
   drawScatterPlot2();
   drawScatterPlot3();
   drawScatterPlot4();
   drawScatterPlot5();
   drawScatterPlot6();
   drawScatterPlot7();
   drawScatterPlot8();
   drawScatterPlot9();
   drawScatterPlot10();
   drawScatterPlot11();
   drawScatterPlot12();
     
  }
  
  
void PearsonCoefficient(){

  float[] satmTemp = new float[myTable.getRowCount()];
  float[] satvTemp = new float[myTable.getRowCount()];
  float[] actTemp = new float[myTable.getRowCount()];
  float[] gpaTemp = new float[myTable.getRowCount()];
  
  float[] satmSatv = new float[myTable.getRowCount()];
  float[] satmAct = new float[myTable.getRowCount()];
  float[] satmGpa = new float[myTable.getRowCount()];
  float[] satvAct = new float[myTable.getRowCount()];
  float[] satvGpa = new float[myTable.getRowCount()];
  float[] actGpa = new float[myTable.getRowCount()];
  
  
  float satmSatvSum = 0;
  float satmActSum = 0;
  float satmGpaSum = 0;
  float satvActSum = 0;
  float satvGpaSum = 0;
  float actGpaSum = 0;
  
  float satmSatvCov;
  float satmActCov;
  float satmGpaCov;
  float satvActCov;
  float satvGpaCov;
  float actGpaCov;
  
  float satmSatvStd;
  float satmActStd;
  float satmGpaStd;
  float satvActStd;
  float satvGpaStd;
  float actGpaStd;
  
  
  
  for(int i =0; i<myTable.getRowCount();i++)
  {
     satmTemp[i] = satmData[i] - meanSatm;
     satvTemp[i] = satvData[i] - meanSatv;
     actTemp[i] = actData[i] - meanAct;
     gpaTemp[i] = gpaData[i] - meanGpa;
     
  }
  
  for(int i =0; i<myTable.getRowCount();i++)
  {
      
      satmSatv[i] = satmTemp[i] * satvTemp[i];
      satmAct[i] = satmTemp[i] * actTemp[i];
      satmGpa[i] = satmTemp[i] * gpaTemp[i];
      satvAct[i] = satvTemp[i] * actTemp[i];
      satvGpa[i] = satvTemp[i] * gpaTemp[i];
      actGpa[i] = actTemp[i] * gpaTemp[i];
    
  }
  
  for(int i=0;i<myTable.getRowCount();i++)
  {
     satmSatvSum += satmSatv[i];
     satmActSum += satmAct[i];
     satmGpaSum += satmGpa[i];
     satvActSum += satvAct[i];
     satvGpaSum += satvGpa[i];
     actGpaSum += actGpa[i];
     
  }
  

   satmSatvCov = satmSatvSum/myTable.getRowCount();
   //println(satmSatvCov);
   satmActCov = satmActSum/myTable.getRowCount();
   //println(satmActCov);
   satmGpaCov = satmGpaSum/myTable.getRowCount();
   //println(satmGpaCov);
   satvActCov = satvActSum/myTable.getRowCount();
   //println(satvActCov);
   satvGpaCov = satvGpaSum/myTable.getRowCount();
   //println(satvGpaCov);
   actGpaCov = actGpaSum/myTable.getRowCount();
   //println(actGpaCov);
   
    satmSatvStd = stdSatm * stdSatv;
    satmActStd = stdSatm * stdAct;
    satmGpaStd = stdSatm * stdGpa;
    satvActStd = stdSatv * stdAct;
    satvGpaStd = stdSatv * stdGpa;
    actGpaStd = stdAct*stdGpa;
    
    
    satmSatvPcc = satmSatvCov/satmSatvStd;
    //println(satmSatvPcc);
    satmActPcc = satmActCov / satmActStd;
    //println(satmActPcc);
    satmGpaPcc = satmGpaCov/satmGpaStd;
    //println(satmGpaPcc);
    satvActPcc = satvActCov/satvActStd;
    //println(satvActPcc);
    satvGpaPcc = satvGpaCov/satvGpaStd;
    //println(satvGpaPcc);
    actGpaPcc = actGpaCov/actGpaStd;
    //println(actGpaPcc);
    
    
  
}

float[] rank(float A[]) { 
  
    float[] ranks = new float[myTable.getRowCount()]; 
      
    for(int i = 0; i < myTable.getRowCount(); i++)  
    { 
        int rankNum = 1, equal = 1; 
           
        for(int j = 0; j < i; j++) { 
            if (A[j] < A[i] )
                  rankNum++; 
            if (A[j] == A[i] ) 
                equal++; 
        } 
      
       for (int j = i+1; j < myTable.getRowCount(); j++) { 
            if (A[j] < A[i] )
                rankNum++; 
            if (A[j] == A[i] ) 
                equal++; 
        } 
   
        ranks[i] = rankNum+(equal-1) * 0.5;         
    } 
       
    return ranks; 
} 


void satmRank(){
  
  //mean of satm rank
  float sum = 0;
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum += satmRank[i];
  satmRankMean = sum/myTable.getRowCount();
  
  
  //calculating standard deviation of satm rank
  float stdTemp = 0;
  float[] std = new float[myTable.getRowCount()];
  for(int i = 0 ;i<myTable.getRowCount();i++)
  {
     stdTemp = satmRank[i] - satmRankMean;
     stdTemp *= stdTemp;
     std[i] = stdTemp;
  }
  
  float sum2=0;
  float mean2=0;
  
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum2+=std[i];
  mean2=sum2/myTable.getRowCount();
  
  stdSatmRank = sqrt(mean2);
  //println(stdSatmRank);
  
  
  
}

void satvRank()
{
  //mean of satm rank
  float sum = 0;
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum += satvRank[i];
  satvRankMean = sum/myTable.getRowCount();
  
  
  //calculating standard deviation of satm rank
  float stdTemp = 0;
  float[] std = new float[myTable.getRowCount()];
  for(int i = 0 ;i<myTable.getRowCount();i++)
  {
     stdTemp = satvRank[i] - satvRankMean;
     stdTemp *= stdTemp;
     std[i] = stdTemp;
  }
  
  float sum2=0;
  float mean2=0;
  
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum2+=std[i];
  mean2=sum2/myTable.getRowCount();
  
  stdSatvRank = sqrt(mean2);
  //println(stdSatvRank);
  
  
  
}

void actRank()
{
  
  
  
  //mean of satm rank
  float sum = 0;
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum += actRank[i];
  actRankMean = sum/myTable.getRowCount();
  
  
  //calculating standard deviation of satm rank
  float stdTemp = 0;
  float[] std = new float[myTable.getRowCount()];
  for(int i = 0 ;i<myTable.getRowCount();i++)
  {
     stdTemp = actRank[i] - actRankMean;
     stdTemp *= stdTemp;
     std[i] = stdTemp;
  }
  
  float sum2=0;
  float mean2=0;
  
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum2+=std[i];
  mean2=sum2/myTable.getRowCount();
  
  stdActRank = sqrt(mean2);
  
  
  
  
}

void gpaRank()
{
  
 //mean of satm rank
  float sum = 0;
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum += gpaRank[i];
  gpaRankMean = sum/myTable.getRowCount();
  
  
  //calculating standard deviation of satm rank
  float stdTemp = 0;
  float[] std = new float[myTable.getRowCount()];
  for(int i = 0 ;i<myTable.getRowCount();i++)
  {
     stdTemp = gpaRank[i] - gpaRankMean;
     stdTemp *= stdTemp;
     std[i] = stdTemp;
  }
  
  float sum2=0;
  float mean2=0;
  
  for(int i = 0 ;i<myTable.getRowCount();i++)
      sum2+=std[i];
  mean2=sum2/myTable.getRowCount();
  
  stdGpaRank = sqrt(mean2); 
  
  
}

void spearmanCorrelation(){
  
  
  float[] satmTemp = new float[myTable.getRowCount()];
  float[] satvTemp = new float[myTable.getRowCount()];
  float[] actTemp = new float[myTable.getRowCount()];
  float[] gpaTemp = new float[myTable.getRowCount()];
  
  float[] satmSatv = new float[myTable.getRowCount()];
  float[] satmAct = new float[myTable.getRowCount()];
  float[] satmGpa = new float[myTable.getRowCount()];
  float[] satvAct = new float[myTable.getRowCount()];
  float[] satvGpa = new float[myTable.getRowCount()];
  float[] actGpa = new float[myTable.getRowCount()];
  
  
  float satmSatvSum = 0;
  float satmActSum = 0;
  float satmGpaSum = 0;
  float satvActSum = 0;
  float satvGpaSum = 0;
  float actGpaSum = 0;
  
  float satmSatvCov;
  float satmActCov;
  float satmGpaCov;
  float satvActCov;
  float satvGpaCov;
  float actGpaCov;
  
  float satmSatvStd;
  float satmActStd;
  float satmGpaStd;
  float satvActStd;
  float satvGpaStd;
  float actGpaStd;
  
  
  
  for(int i =0; i<myTable.getRowCount();i++)
  {
     satmTemp[i] = satmRank[i] - satmRankMean;
     satvTemp[i] = satvRank[i] - satvRankMean;
     actTemp[i] = actRank[i] - actRankMean;
     gpaTemp[i] = gpaRank[i] - gpaRankMean;
     
  }
  
  for(int i =0; i<myTable.getRowCount();i++)
  {
      
      satmSatv[i] = satmTemp[i] * satvTemp[i];
      satmAct[i] = satmTemp[i] * actTemp[i];
      satmGpa[i] = satmTemp[i] * gpaTemp[i];
      satvAct[i] = satvTemp[i] * actTemp[i];
      satvGpa[i] = satvTemp[i] * gpaTemp[i];
      actGpa[i] = actTemp[i] * gpaTemp[i];
    
  }
  
  for(int i=0;i<myTable.getRowCount();i++)
  {
     satmSatvSum += satmSatv[i];
     satmActSum += satmAct[i];
     satmGpaSum += satmGpa[i];
     satvActSum += satvAct[i];
     satvGpaSum += satvGpa[i];
     actGpaSum += actGpa[i];
     
  }
  

   satmSatvCov = satmSatvSum/myTable.getRowCount();
  // println(satmSatvCov);
   satmActCov = satmActSum/myTable.getRowCount();
  // println(satmActCov);
   satmGpaCov = satmGpaSum/myTable.getRowCount();
  // println(satmGpaCov);
   satvActCov = satvActSum/myTable.getRowCount();
  // println(satvActCov);
   satvGpaCov = satvGpaSum/myTable.getRowCount();
  // println(satvGpaCov);
   actGpaCov = actGpaSum/myTable.getRowCount();
  // println(actGpaCov);
   
    satmSatvStd = stdSatmRank * stdSatvRank;
    //println(satmSatvStd);
    satmActStd = stdSatmRank * stdActRank;
    //println(satmActStd);
    satmGpaStd = stdSatmRank * stdGpaRank;
    //println(satmGpaStd);
    satvActStd = stdSatvRank * stdActRank;
    //println(satvActStd);
    satvGpaStd = stdSatvRank * stdGpaRank;
    //println(satvGpaStd);
    actGpaStd = stdActRank*stdGpaRank;
    //println(actGpaStd);
    
    satmSatvSp = satmSatvCov/satmSatvStd;
    //println(satmSatvSp);
    satmActSp = satmActCov / satmActStd;
    //println(satmActSp);
    satmGpaSp = satmGpaCov/satmGpaStd;
    //println(satmGpaSp);
    satvActSp = satvActCov/satvActStd;
    //println(satvActSp);
    satvGpaSp = satvGpaCov/satvGpaStd;
    //println(satvGpaSp);
    actGpaSp = actGpaCov/actGpaStd;
    //println(actGpaSp);
     
  
  
  
}
  
}
