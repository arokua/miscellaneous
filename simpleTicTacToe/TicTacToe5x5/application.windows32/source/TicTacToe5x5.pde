class Button {
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w;    // width of button
  float h;    // height of button
  color c;    //color of the button
  color cs;   //color of the stroke for the button
  color t; // color of the text
  float sWeight; //stroke weight for the rect of the button
  float tSize; //text size
  
  // THe parameter of the button
  Button(String label2, float xpos, float ypos, float widthB, float heightB, color bC, color cS, color tC, float sW, float TS) {
    label = label2;
    x = xpos;
    y = ypos;
    w = widthB;
    h = heightB;
    c = bC;
    cs = cS;
    t = tC;
    sWeight = sW;
    tSize = TS;
  }
  
  void Draw() {
    fill(c);
    stroke(cs);
    strokeWeight(sWeight);
    rect(x, y, w, h, 10);
    textAlign(CENTER, CENTER);
    textSize(tSize);
    fill(t);
    text(label, x + (w / 2), y + (h / 2));
  }
  
  boolean MouseIsOver() {
    if (mouseX >= x && mouseX <= (x + w) && mouseY >= y && mouseY <= (y + h)) {
      return true;
    }
    return false;
  }
}

//Global variables and lists
IntList chosen;
float gridSide = 0 ;
int check = 0; //Turn checking

IntList Xchosen = new IntList();
IntList Ochosen = new IntList();
color CurrentScreenColor = 0;
color CurrentXColor = color(255, 0, 0);
color CurrentOColor = color(0, 0, 255);
boolean pvc = true;
int XWins = 0;
int OWins = 0;
float a1 = 0;
float b1 = 0;
int XgettoWin = 0;// how many X are next to each other horizontally or vertically

String gameState; // Let the program know if the game is running or at the start screen or the result screen
float seconds = 0; // Show the time in seconds
int minutes; //Show the time in minutes
int backgroundChoice = 0;
int a;
int b;
int c;
int d;
//Intitalize the buttons in the functions that use them
Button restart;
Button start;
Button back;
Button back2;
Button back3;
Button Home1;
Button Home2;
Button countinue;
Button player;
Button Computer;
Button pause;
Button replay2;
Button Setting2;
Button howToPlay;
Button Setting;
Button exit;
Button exit2;


Button ScreenColor1_1;
Button ScreenColor2_1;
Button ScreenColor3_1;

Button XColor1_1;
Button XColor2_1;
Button XColor3_1;

Button OColor1_1;
Button OColor2_1;
Button OColor3_1;

Button ScreenColor1_2;
Button ScreenColor2_2;
Button ScreenColor3_2;

Button XColor1_2;
Button XColor2_2;
Button XColor3_2;

Button OColor1_2;
Button OColor2_2;
Button OColor3_2;


void setup() {
  size(750, 750);
  chosen = new IntList();
  gridSide = width/5;
  frameRate(10);
  gameState = "START";
  
}

void startScreen() {
  // The start game screen
  background(CurrentScreenColor);
  fill(255, 0, 255);
  textSize(40);
  text("Tic Tac Toe 5  x 5", width / 3 + 10, 50);
  
  start = new Button("START", width / 2 - 30, height / 2, 70, 30, CurrentScreenColor, 255, color(0, 255, 0), 4, 20);
  start.Draw();
  
  howToPlay = new Button("How to play", width / 2 - 60, height / 2 + 40, 150, 30, CurrentScreenColor, 255, color(0, 255, 0), 4, 20);
  howToPlay.Draw();
  
  Setting = new Button("Setting", width / 2 - 35, height / 2 + 80, 90, 30, CurrentScreenColor, 255, color(0, 255, 0), 4, 20);
  Setting.Draw();
  
  exit = new Button("Exit", width - 65, height - 40, 60, 30, CurrentScreenColor, 255, color(0, 255, 0), 4, 20);
  exit.Draw();
}

void HowToPlayScreen() {
  // The instruction screen
  background(CurrentScreenColor);
  fill(255, 0, 255);
  textSize(40);
  text("Tic Tac Toe 5  x 5", width / 3 + 10, 50);
  
  textSize(20);
  text("As same way as other Tic Tac Toe \n Player wins if X is on 5 blocks \n in a line.", width / 2 - 30, height /2);
  //go back -
  back = new Button("Back", width / 2 - 30, height - 30, 70, 30, CurrentScreenColor, 255, color(0, 255, 0), 4, 20);
  back.Draw();
  
}

void Setting() {
  // Let the player change the color 
  background(CurrentScreenColor);
  fill(255, 0, 255);
  textSize(40);
  text("Tic Tac Toe 5  x 5", width / 3 + 10, 50);
  
  fill(#3B9515);
  textSize(20);
  text("Choose the color for the screen", width / 2 - 30, height / 4);
  text("Choose the color for the X", width / 2 - 55, height / 4 + 60);
  text("Choose the color for the O", width / 2 - 55, height / 4 + 120);
  text("Choose play mode, computer or again player", width / 2 - 30, height / 4 + 200);
  
  //xpos-ypos-width-height-buttoncolor-strokecolor-textcolor-strokeweight-textsize (Button parameter)
  color constrast = color(255 - red(CurrentScreenColor), 255 - green(CurrentScreenColor), 255 - blue(CurrentScreenColor));
  ScreenColor1_1 = new Button("DEFAULT(Black)", width /5, height / 4 + 15, 130, 30, CurrentScreenColor, 125, constrast, 4, 15);
  ScreenColor2_1 = new Button("Pink", width /5 + 145, height / 4 + 15, 60, 30, CurrentScreenColor, 125, constrast, 4, 15);
  ScreenColor3_1 = new Button("Sky Blue", width / 5 + 220, height / 4 + 15, 130, 30, CurrentScreenColor, 125, constrast, 4, 15);
  
  XColor1_1 = new Button("DEFAULT(Red)", width /5, height / 4 + 75, 130, 30, CurrentScreenColor, 125, color(255, 0, 0), 4, 15);
  XColor2_1 = new Button("Orange", width /5 + 145, height / 4 + 75, 60, 30, CurrentScreenColor, 125, color(255, 128, 0), 4, 15);
  XColor3_1 = new Button("Blood red", width / 5 + 220, height / 4 + 75, 130, 30, CurrentScreenColor, 125, color(131, 3, 3), 4, 15);
  
  OColor1_1 = new Button("DEFAULT(Blue)", width /5, height / 4 + 135, 130, 30, CurrentScreenColor, 125, color(0, 0, 255), 4, 15);
  OColor2_1 = new Button("Violet", width /5 + 145, height / 4 + 135, 60, 30, CurrentScreenColor, 125, color(102, 0, 204), 4, 15);
  OColor3_1 = new Button("Purple", width / 5 + 220, height / 4 + 135, 95, 30, CurrentScreenColor, 125, color(204, 0, 204), 4, 15);
  
  
  Computer = new Button("Computer", width /5, height / 4 + 250, 130, 30, CurrentScreenColor, 125, color(255, 0, 0), 4, 15);
  player = new Button("PvP", 3 * width /5 , height / 4 + 250, 40, 30, CurrentScreenColor, 125, color(255, 0, 0), 4, 15);
  back2 = new Button("Back", width / 2 - 30, height - 30, 70, 30, CurrentScreenColor, 255, color(0, 255, 0), 4, 20);
  
  ScreenColor1_1.Draw();
  ScreenColor2_1.Draw();
  ScreenColor3_1.Draw();
  
  XColor1_1.Draw();
  XColor2_1.Draw();
  XColor3_1.Draw();
  
  OColor1_1.Draw();
  OColor2_1.Draw();
  OColor3_1.Draw();
  Computer.Draw();
  player.Draw();
  back2.Draw();
}

void Setting2() {
  //Setting screen when player pause the game
  // Let the player change the color 
  background(CurrentScreenColor);
  fill(255, 0, 255);
  textSize(40);
  text("Tic Tac Toe 5  x 5", width / 3 + 10, 50);
  
  fill(#3B9515);
  textSize(20);
  text("Choose the color for the screen", width / 2 - 30, height / 4);
  text("Choose the color for the X", width / 2 - 55, height / 4 + 60);
  text("Choose the color for the O", width / 2 - 55, height / 4 + 120);
  
  //xpos-ypos-width-height-buttoncolor-strokecolor-textcolor-strokeweight-textsize (Button parameter)
  color constrast = color(255 - red(CurrentScreenColor), 255 - green(CurrentScreenColor), 255 - blue(CurrentScreenColor));
  ScreenColor1_2 = new Button("Black", width /5, height / 4 + 15, 130, 30, CurrentScreenColor, 125, constrast, 4, 15);
  ScreenColor2_2 = new Button("Pink", width /5 + 145, height / 4 + 15, 60, 30, CurrentScreenColor, 125, constrast, 4, 15);
  ScreenColor3_2 = new Button("Sky Blue", width / 5 + 220, height / 4 + 15, 130, 30, CurrentScreenColor, 125, constrast, 4, 15);
  
  XColor1_2 = new Button("Red", width /5, height / 4 + 75, 130, 30, CurrentScreenColor, 125, color(255, 0, 0), 4, 15);
  XColor2_2 = new Button("Orange", width /5 + 145, height / 4 + 75, 60, 30, CurrentScreenColor, 125, color(255, 128, 0), 4, 15);
  XColor3_2 = new Button("Blood red", width / 5 + 220, height / 4 + 75, 130, 30, CurrentScreenColor, 125, color(131, 3, 3), 4, 15);
  
  OColor1_2 = new Button("DEFAULT(Blue)", width /5, height / 4 + 135, 130, 30, CurrentScreenColor, 125, color(0, 0, 255), 4, 15);
  OColor2_2 = new Button("Violet", width /5 + 145, height / 4 + 135, 60, 30, CurrentScreenColor, 125, color(102, 0, 204), 4, 15);
  OColor3_2 = new Button("Purple", width / 5 + 220, height / 4 + 135, 95, 30, CurrentScreenColor, 125, color(204, 0, 204), 4, 15);
  
  

  back3 = new Button("Back", width / 2 - 30, height - 30, 70, 30, CurrentScreenColor, 255, color(0, 255, 0), 4, 20);
  
  ScreenColor1_2.Draw();
  ScreenColor2_2.Draw();
  ScreenColor3_2.Draw();
  
  XColor1_2.Draw();
  XColor2_2.Draw();
  XColor3_2.Draw();
  
  OColor1_2.Draw();
  OColor2_2.Draw();
  OColor3_2.Draw();
  back3.Draw();
}

void pause() {
  background(CurrentScreenColor, 00);
  countinue = new Button("Countinue playing", width / 4, height / 2 + 30, 150, 30, CurrentScreenColor, 125, 125, 4, 15);
  Home2 = new Button("Back to start screen", width / 4, height / 2 + 65, 170, 30, CurrentScreenColor, 125, 125, 4, 15);
  Setting2 = new Button("Setting", width / 4, height / 2 + 100, 90, 35, CurrentScreenColor, 125, 125, 4, 15);
  replay2 = new Button("Replay", width / 4, height / 2 + 140, 80, 35, CurrentScreenColor, 125, 125, 4, 15);
  
  countinue.Draw();
  Home2.Draw();
  Setting2.Draw();
  replay2.Draw();
  
}
  
  
void draw() {
  if (gameState == "START") {
    startScreen();
  }
  else if (gameState == "RUN") {
    fill(CurrentScreenColor);
    noStroke();
    rect(0, 0, width, 30);
    
    if (backgroundChoice == 0) {
      MovingBuilding();
    }
     
    color contrast = color(255 - red(CurrentScreenColor), 255 - green(CurrentScreenColor), 255 - blue(CurrentScreenColor));
    
    pause = new Button("Pause", width - 40, 5, 40, 15, color(CurrentScreenColor,0), color(CurrentScreenColor, 0), contrast, 4, 10);
    pause.Draw();
    fill(contrast);
    text("X: " + XWins + " win(s)   O:" + OWins + " win(s)" , 60 , 15);
    
    
    textSize(15);
    
    seconds += 1 / ( frameRate);
    
    
    if ( seconds > 60 ) {
      seconds = 0;
      minutes += 1;
      
    }
    
    textAlign(LEFT);
    text("Time: " + minutes + " minutes " + String.format("%.2f", seconds) + " seconds",width / 2 - 50, 15);
    if (checkWin(Ochosen)) {
        winScreen("O");
        gameState = "RESULT";
        
      }else if (checkWin(Xchosen)) {
        winScreen("X");
        gameState = "RESULT";
      }else if (chosen.size() == 25) {
        winScreen("");
        gameState = "RESULT";
      }else if (pvc == true){
        computerMove();
        
      }
    drawStar(random(mouseX - 5, mouseX + 5), random(mouseY -5, mouseY + 5), int(random(10, 25)), random(0, 255));
    squareHighlight();    
  }
}

void mouseClicked() {  
  // Mouse interactions controls
  if (gameState == "START") {
    if (start.MouseIsOver()) {
      loop();
      background(255,12);
      reset();
      gameState = "RUN";
    }else if (howToPlay.MouseIsOver()) {
      
      HowToPlayScreen();
    
      gameState = "STARTh";
      
    }else if (Setting.MouseIsOver()) {
      
      Setting();
    
      gameState = "Choose color";
      
    }else if (exit.MouseIsOver()) {
      exit();
    }
  }else if (gameState == "STARTh"){
    if (back.MouseIsOver() == true) {        
        gameState = "START";
        startScreen();
        
    }
    }
    else if (gameState == "Choose color"){
      if (back2.MouseIsOver() ) {        
          gameState = "START";
          startScreen();
      }else if (ScreenColor2_1.MouseIsOver()){
        CurrentScreenColor = color(255, 182, 193);
      }else if (ScreenColor1_1.MouseIsOver()){
        CurrentScreenColor = 0;
      }else if (ScreenColor3_1.MouseIsOver()){
        CurrentScreenColor = color(0, 191, 255);
      }
      
      else if (XColor1_1.MouseIsOver()){
        CurrentXColor = color(255, 0, 0);
      }else if (XColor2_1.MouseIsOver()){
        CurrentXColor = color(255, 128, 0);
      }else if (XColor3_1.MouseIsOver()){
        CurrentXColor = color(131, 3, 3);
      }
      
      else if (OColor1_1.MouseIsOver()){
        CurrentOColor = color(0, 0, 255);
      }else if (OColor2_1.MouseIsOver()){
        CurrentOColor = color(102, 0, 204);
      }else if (OColor3_1.MouseIsOver()){
        CurrentOColor = color(204, 0, 204);
      }
      else if (Computer.MouseIsOver()){
        pvc = true;
      }else if (player.MouseIsOver()){
        pvc = false;
      }
      Setting();
  }else if ( gameState  == "Choose colorP") {
      if (back3.MouseIsOver() ) {        
          gameState = "RUN";

      }else if (ScreenColor2_2.MouseIsOver()){
        CurrentScreenColor = color(255, 182, 193);
      }else if (ScreenColor1_2.MouseIsOver()){
        CurrentScreenColor = 0;
      }else if (ScreenColor3_2.MouseIsOver()){
        CurrentScreenColor = color(0, 191, 255);
      }
      
      else if (XColor1_2.MouseIsOver()){
        CurrentXColor = color(255, 0, 0);
      }else if (XColor2_2.MouseIsOver()){
        CurrentXColor = color(255, 128, 0);
      }else if (XColor3_2.MouseIsOver()){
        CurrentXColor = color(131, 3, 3);
      }
      
      else if (OColor1_2.MouseIsOver()){
        CurrentOColor = color(0, 0, 255);
      }else if (OColor2_2.MouseIsOver()){
        CurrentOColor = color(102, 0, 204);
      }else if (OColor3_2.MouseIsOver()){
        CurrentOColor = color(204, 0, 204);
      }
      Setting2();
  }
  
  
  else if (gameState == "RUN") {    
    if(pause.MouseIsOver()) {
        seconds += 0;
        gameState = "PAUSE";
        pause();
     }
    else if (chosen.size() < 25 && (checkWin(Xchosen) == false || checkWin(Ochosen) == false)){
      for (int i = 0; i < 5; i++) {
        
        for (int j = 0; j < 5; j++) {
          if ( gridSide * i < mouseX && gridSide * (i+1) > mouseX &&
               gridSide * j + 30 < mouseY && gridSide * (j+1) > mouseY && 
               (chosen.hasValue(int(str(i)+str(j))) == false)) {
                 
             if (check == 0){
               chosen.append(int(str(i)+str(j)));
               drawX(i * gridSide, j * gridSide + 30, CurrentXColor);
               check += 1;
               Xchosen.append(int(str(i)+str(j)));
               
             }else if (check == 1 && pvc == false){
               chosen.append(int(str(i)+str(j)));
               drawO(i * gridSide, j * gridSide + 30);
               check -= 1;
               Ochosen.append(int(str(i)+str(j)));
               
             }
           }
         }
         
       }
     }
  
  }
  else if (gameState == "PAUSE") {
    seconds += 0;
    if(countinue.MouseIsOver()) {
        gameState = "RUN";
     }else if(Home2.MouseIsOver()) {
        gameState = "START";
        seconds = 0;
     }else if(Setting2.MouseIsOver()) {
        gameState = "Choose colorP";
        Setting2();
     }else if (replay2.MouseIsOver()) {
       reset();
       gameState = "RUN";
       seconds =0;
     }
  }
  
  else if(gameState == "RESULT") {
    seconds = 0;
    if (restart.MouseIsOver()) {
      
      reset();
      gameState = "RUN";
    }else if(Home1.MouseIsOver()) {
      gameState = "START";
      startScreen();
    }else if(exit2.MouseIsOver()) {
      exit();
    }
  }
  strokeWeight(1);
  stroke(0);
}

void squareHighlight() {
  //Whenever a mouse is over an unchosen square, that square would be filled
  strokeWeight(1);
  if (gameState == "RUN") {
    
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
       stroke(color(255 - red(CurrentScreenColor)), 255 - green(CurrentScreenColor), 255 - blue(CurrentScreenColor));
       if ( gridSide * i < mouseX && gridSide*(i+1) > mouseX && 
            gridSide * j < mouseY && gridSide * (j+1) > mouseY && 
          (chosen.hasValue(int(str(i)+str(j))) == false)) {
            if (check == 0){
              fill(CurrentXColor, 50);
            }else if( pvc == false & check ==1){
              fill(CurrentOColor, 50);
            }
            rect(i * gridSide, j * gridSide + 30, gridSide, gridSide);
        }else if (chosen.hasValue(int(str(i)+str(j))) == false) {
          noFill();
          rect(i * gridSide, j * gridSide + 30, gridSide, gridSide);  
        }else if (Xchosen.hasValue(int(str(i)+str(j))) == true ) {
           drawX(i * gridSide, j * gridSide + 30, CurrentXColor);
        }else if (Ochosen.hasValue(int(str(i)+str(j))) == true) {
          drawO(i * gridSide, j * gridSide + 30);
        }
      }
    }
  }
  
}

void drawStar(float x, float y, int s, float o) {
  //Create a small star-like explosion
  float s2= s/2;
  float s3= s2/2;
  stroke(255, 255, 0, o);
  line(x - s2, y, x + s2, y);
  line(x, y - s2, x, y + s2);
  line(x - s3, y - s3, x + s3, y + s3);
  line(x + s3, y - s3, x - s3, y + s3);
  stroke(0);
  
}

void winScreen(String winner){  
  textSize(30);
  textAlign(CENTER, CENTER);
  fill(255);
  background(CurrentScreenColor);
  
 if (winner == "X") {
   text("X Win!!", 250,400);
   XWins += 1 ;
 }else if (winner == "O") {
   text("O Win!!", 250,400);
   OWins += 1 ;
 }else {
   text("It is a draw !!!", 250,400);
 }
 textSize(30);
 text("X: " + XWins + " win(s)", 0.2 * width, 0.2 *height);
 text("O: " + OWins + " win(s)", 0.8 * width, 0.2 *height);
 
 restart = new Button("Replay", 0.5 * width -30, 200, 80, 30, CurrentScreenColor, color(#1C459B), 255 , 3, 20);
 restart.Draw();
 Home1 = new Button("Home", width / 2 - 30, height - 30, 70, 30, CurrentScreenColor, 255, color(0, 255, 0), 4, 20);
 Home1.Draw();
 
 exit2 = new Button("Exit", width - 65, height - 40, 60, 30, CurrentScreenColor, 255, color(0, 255, 0), 4, 20);
 exit2.Draw();
}

boolean checkWin(IntList moveList){
  // As the name suggest, this function check if a 'player' has won
  if ( (moveList.hasValue(0) && moveList.hasValue(1) && moveList.hasValue(2) && moveList.hasValue(3) && moveList.hasValue(4)) || //first column
       (moveList.hasValue(0) && moveList.hasValue(10) && moveList.hasValue(20) && moveList.hasValue(30) && moveList.hasValue(40)) || // first row
       (moveList.hasValue(0) && moveList.hasValue(11) && moveList.hasValue(22) && moveList.hasValue(33) && moveList.hasValue(44)) || // left to right diagonal
       
       (moveList.hasValue(1) && moveList.hasValue(11) && moveList.hasValue(21) && moveList.hasValue(31) && moveList.hasValue(41)) || //second row
       (moveList.hasValue(2) && moveList.hasValue(12) && moveList.hasValue(22) && moveList.hasValue(32) && moveList.hasValue(42)) || //third row
       (moveList.hasValue(3) && moveList.hasValue(13) && moveList.hasValue(23) && moveList.hasValue(33) && moveList.hasValue(43)) || // fourth row
       (moveList.hasValue(4) && moveList.hasValue(14) && moveList.hasValue(24) && moveList.hasValue(34) && moveList.hasValue(44)) || // fifth row
       
       (moveList.hasValue(10) && moveList.hasValue(11) && moveList.hasValue(12) && moveList.hasValue(13) && moveList.hasValue(14)) || //second collumn
       (moveList.hasValue(20) && moveList.hasValue(21) && moveList.hasValue(22) && moveList.hasValue(23) && moveList.hasValue(24)) || // third collumn
       (moveList.hasValue(30) && moveList.hasValue(31) && moveList.hasValue(32) && moveList.hasValue(33) && moveList.hasValue(34)) || // fourth collumn
       (moveList.hasValue(41) && moveList.hasValue(41) && moveList.hasValue(42) && moveList.hasValue(43) && moveList.hasValue(44)) || // fifth collumn
       (moveList.hasValue(40) && moveList.hasValue(31) && moveList.hasValue(22) && moveList.hasValue(13) && moveList.hasValue(4))  ) { // right to left diagonal
    return true;
  }
  else{
    return false;
  }
}

void reset() {
  drawBlankBoard(5, 5);
  
  check = 0;
  frameCount = 0;
  chosen.clear();
  Xchosen.clear();
  Ochosen.clear();
}

void drawBlankBoard(int r, int c) {
  
  for (int i = 0; i < r; i++) {
    for (int j = 0; j < c; j++) {
      noFill();
      rect(i * gridSide, j * gridSide + 30 , gridSide, gridSide);
    }
  }  
}

void drawX( float x, float y, color X_Color){
  noFill();
  rect(x, y, gridSide, gridSide);
  strokeWeight(3);
  stroke(X_Color);

  line(x + 1, y + 1, x + gridSide, y + gridSide);
  line(x, y + gridSide , x + gridSide - 1, y);
  strokeWeight(1);
}

void drawO( float x, float y){
  float balancer = width / 100; // to scale the circle cleary
  noFill();
  rect(x, y, gridSide, gridSide);
  strokeWeight(3);
  stroke(CurrentOColor);
  ellipseMode(CORNER);
  ellipse(x + balancer, y + balancer, -2 * balancer + gridSide , -2 * balancer  + gridSide);
  strokeWeight(1);
}

void computerMove() {
  //For the computer to move, this is just moving randomly, * NEED to be improve
  float a = random(0, width); //the x and y coordinates for the computer target
  float b = random(0 , height);
  if (check == 1 && second() % 1.5 == 0) {
    for (int i = 0; i < 5; i++) {
        for (int j = 0; j < 5; j++) {
          if ( gridSide * i < a && gridSide * (i+1) > a &&
               gridSide * j < b && gridSide * (j+1) > b && 
               (chosen.hasValue(int(str(i)+str(j))) == false)) {
                 chosen.append(int(str(i)+str(j)));
                 drawO(i * gridSide, j * gridSide + 30);
                 check -= 1;              
                 Ochosen.append(int(str(i)+str(j)));
               }
        }
    }
  }
}

void MovingBuilding() {
  
  int squareNoH= 20;
  int squareNoV= 20;
  int divider = 2*height/squareNoV; //divide the color value by this
  float redValue = 0;
  float greenValue = 0;
  float blueValue = 0;
  
  noStroke();
  for (int i = 0; i < width +1; i += width / squareNoH){  
    for(int j = 0; j < height + 1; j+=height / squareNoV){
      fill(redValue, greenValue, blueValue);
    
      rect(i, j, width / squareNoH, height / squareNoV);
      redValue += red(CurrentScreenColor) / divider;
      greenValue += green(CurrentScreenColor) / divider;
      blueValue += blue(CurrentScreenColor) / divider;
    }
    redValue = 0;
    greenValue = 0;
    blueValue = 0;
  }
  
  //Draw the moon or the sun
  if (CurrentScreenColor == 0) {
    fill(255, 255, 0, 100);
    ellipse(450, 60, 40, 40);
  }else  {
    fill(255, 255, 0);
    ellipse(50, 60, 40, 40);
  }
  //Drawing the buildings
  for (int h =0; h <10; h++){
    int floor=int(random(4, 20));
    fill(random(0, red(CurrentXColor)), 0, 0, random(0, 255)) ;
    rect(50 * h, height - 20 * floor, 50, 20 * floor);
    
    fill(CurrentXColor, 100);
    rect(20 + 50 * h, height - 10, 10, 10);
    fill(0, 0, random(0, blue(CurrentOColor)), random(0, 255));
    for (int j = 0; j < floor - 1; j++){
      rect(10 + 50 * h, height - (20 * j) - 35, 10, 15);
      rect(30 + 50 * h, height - (20 * j) - 35, 10, 15);
    }
  }
}
