class Button {
  String label;
  float x;    // top left corner x position
  float y;    // top left corner y position
  float w;    // width of button
  float h;    // height of button
  color c;    //color of the button
  color cs;   //color of the stroke for the button
  color t;    // color of the text
  float sWeight; //stroke weight for the rect of the button
  float tSize; //text size
  
  boolean clicked = false; // Track if the button is clicked
  int clickTime = 0;       // To track the time when button is clicked
  int flashInterval = 500; // Flash interval in milliseconds (0.5 seconds)
  
  // Constructor of the Button
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
    // If clicked, change the button color and text style for 2 seconds
    if (clicked) {
      fill(color(255,125,125));
    } else {
      fill(c); // Default button color
    }

    // Draw the button
    stroke(cs);
    strokeWeight(sWeight);
    rect(x, y, w, h, 10);
    
    // Draw the label
    textAlign(CENTER, CENTER);
    textSize(tSize);
    fill(t);
    text(label, x + (w / 2), y + (h / 2));
  }
  
  // Detect if the mouse is over the button
  boolean MouseIsOver() {
    if (mouseX >= x && mouseX <= (x + w) && mouseY >= y && mouseY <= (y + h)) {
      return true;
    }
    return false;
  }

  // Call this when the button is clicked
  void onClick() {
    clicked = true;
    clickTime = millis(); // Record the time of click
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
//Intitalize the buttons  for  the functions that use them
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
Button[] screenColorButtons;
color[] screenColors = {color(0), color(255, 182, 193), color(0, 191, 255)};

Button[] xColorButtons;
color[] xColors = {color(255, 0, 0), color(255, 128, 0), color(131, 3, 3)};

Button[] oColorButtons;
color[] oColors = {color(0, 0, 255), color(102, 0, 204), color(204, 0, 204)};

void handleButtonClick(Button[] buttons, color[] colors, String type) {
  for (int i = 0; i < buttons.length; i++) {
    if (buttons[i].MouseIsOver()) {
      // Unclick all buttons in the group before selecting the clicked button
      for (int j = 0; j < buttons.length; j++) {
        buttons[j].clicked = false;  // Reset all buttons' clicked state
      }
      
      // Mark the clicked button as active
      buttons[i].onClick();
      
      // Set the corresponding color based on button group, this only for color configs
      // Ignore for other button groups
      if (type.equals("ScreenColor")) {
        CurrentScreenColor = colors[i];
      } else if (type.equals("XColor")) {
        CurrentXColor = colors[i];
      } else if (type.equals("OColor")) {
        CurrentOColor = colors[i];
      }
    }
  }
}


void setup() {
  color contrast = color(255 - red(CurrentScreenColor), 255 - green(CurrentScreenColor), 255 - blue(CurrentScreenColor));
  // Screen color buttons with dynamic contrast
  screenColorButtons = new Button[] {
    new Button("DEFAULT(Black)", width /5, height / 4 + 15, 130, 30, CurrentScreenColor, 125, contrast, 4, 15),
    new Button("Pink", width /5 + 145, height / 4 + 15, 60, 30, CurrentScreenColor, 125, contrast, 4, 15),
    new Button("Sky Blue", width / 5 + 220, height / 4 + 15, 130, 30, CurrentScreenColor, 125, contrast, 4, 15)
  };
  
  // X color buttons
  color contrastX = color(255 - red(CurrentXColor), 255 - green(CurrentXColor), 255 - blue(CurrentXColor));

  // X Color Buttons
  xColorButtons = new Button[] {
    new Button("DEFAULT(Red)", width / 5, height / 4 + 75, 130, 30, CurrentScreenColor, 125,CurrentXColor, 4, 15),  // Text color is Red
    new Button("Orange", width / 5 + 145, height / 4 + 75, 60, 30, CurrentScreenColor, 125, contrastX, 4, 15),  // Text color is Orange
    new Button("Blood red", width / 5 + 220, height / 4 + 75, 130, 30, CurrentScreenColor, 125, contrastX, 4, 15)  // Text color is Dark Red
  };
  
  // O color buttons
  color contrastO = color(255 - red(CurrentOColor), 255 - green(CurrentOColor), 255 - blue(CurrentOColor));

  oColorButtons = new Button[] {
    new Button("DEFAULT(Blue)", width /5, height / 4 + 135, 130, 30, CurrentScreenColor, 125, CurrentOColor, 4, 15),
    new Button("Violet", width /5 + 145, height / 4 + 135, 60, 30, CurrentScreenColor, 125, contrastO, 4, 15),
    new Button("Purple", width / 5 + 220, height / 4 + 135, 95, 30, CurrentScreenColor, 125, contrastO, 4, 15)
  };
  screenColorButtons[0].clicked=true;// Default black screen color
  xColorButtons[0].clicked = true;  // Red is the default selected for X color
  oColorButtons[0].clicked = true;  // Blue is the default selected for O color
  Computer = new Button("Computer", width /5, height / 4 + 250, 130, 30, CurrentScreenColor, 125, color(255, 0, 0), 4, 15);
  player = new Button("PvP", 3 * width /5 , height / 4 + 250, 40, 30, CurrentScreenColor, 125, color(255, 0, 0), 4, 15);
  Computer.clicked=true;
  // Screen color buttons
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
  
  
  
  back2 = new Button("Back", width / 2 - 30, height - 30, 70, 30, CurrentScreenColor, 255, color(0, 255, 0), 4, 20);
  
  // Draw screen color buttons
  for (Button btn : screenColorButtons) {
    btn.Draw();
  }
  
  // Draw X color buttons
  for (Button btn : xColorButtons) {
    btn.Draw();
  }
  
  // Draw O color buttons
  for (Button btn : oColorButtons) {
    btn.Draw();
  }
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
  
  // Draw screen color buttons
  for (Button btn : screenColorButtons) {
    btn.Draw();
  }
  
  // Draw X color buttons
  for (Button btn : xColorButtons) {
    btn.Draw();
  }
  
  // Draw O color buttons
  for (Button btn : oColorButtons) {
    btn.Draw();
  }

  back3 = new Button("Back", width / 2 - 30, height - 30, 70, 30, CurrentScreenColor, 255, color(0, 255, 0), 4, 20);
  
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
    if (chosen.size() == 25) {
      println(checkWin(Ochosen), checkWin(Xchosen));
      winScreen("");
      gameState = "RESULT";
    }else if (checkWin(Ochosen)) {
      winScreen("O");
      gameState = "RESULT";
      
    }else if (checkWin(Xchosen)) {
      winScreen("X");
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
      start.clicked = true;
      redraw();
      loop();
      background(255,12);
      reset();
      gameState = "RUN";
    } else if (howToPlay.MouseIsOver()) {
      howToPlay.clicked = true;
      redraw();
      HowToPlayScreen();
      gameState = "STARTh";
    } else if (Setting.MouseIsOver()) {
      Setting.clicked = true;
      Setting();
      gameState = "Choose color";
    } else if (exit.MouseIsOver()) {
      exit.clicked = true;
      exit();
    }
  } else if (gameState == "STARTh") {
    if (back.MouseIsOver()) {
      back.clicked = true;
      gameState = "START";
      HowToPlayScreen();
      startScreen();
      back.clicked=false;
    }
  } else if (gameState == "Choose color") {
    // Start game setting mode
    if (back2.MouseIsOver()) {
      back2.clicked = true;
      gameState = "START";
      startScreen();
    }

    color[] screenColors = { color(0), color(255, 182, 193), color(0, 191, 255) };
    color[] xColors = { color(255, 0, 0), color(255, 128, 0), color(131, 3, 3) };
    color[] oColors = { color(0, 0, 255), color(102, 0, 204), color(204, 0, 204) };
    Button[] pvpButtons = { Computer, player };
    color[] pvpConfigColor={color(0),color(0.5)};
    // Handle screen color buttons
    handleButtonClick(screenColorButtons, screenColors, "ScreenColor");
    
    // Handle X color buttons
    handleButtonClick(xColorButtons, xColors, "XColor");
    
    // Handle O color buttons
    handleButtonClick(oColorButtons, oColors, "OColor");
    handleButtonClick(pvpButtons, pvpConfigColor, "PvP");
    
    Setting();
  } else if (gameState == "Choose colorP") {
    // Pause game setting mode
    if (back3.MouseIsOver()) {
      back3.clicked = true;
      gameState = "RUN";
    }

    color[] screenColors = { color(0), color(255, 182, 193), color(0, 191, 255) };
    color[] xColors = { color(255, 0, 0), color(255, 128, 0), color(131, 3, 3) };
    color[] oColors = { color(0, 0, 255), color(102, 0, 204), color(204, 0, 204) };

    // Handle screen color buttons
    handleButtonClick(screenColorButtons, screenColors, "ScreenColor");
    
    // Handle X color buttons
    handleButtonClick(xColorButtons, xColors, "XColor");
    
    // Handle O color buttons
    handleButtonClick(oColorButtons, oColors, "OColor");
    
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

boolean checkWin(IntList moveList) {
  //Check if the player (playerA) wins
  int gridSize = 5;  // Current grid size (5x5)
  int winLength = 5; // How many in a row needed to win (5 for this game)

  // Check rows and columns
  for (int i = 0; i < gridSize; i++) {
    if (checkLine(moveList, i, 0, 0, 1, winLength) ||  // Check row
        checkLine(moveList, 0, i, 1, 0, winLength)) {  // Check column
      return true;
    }
  }

  // Check diagonals
  if (checkLine(moveList, 0, 0, 1, 1, winLength) ||  // Top-left to bottom-right diagonal
      checkLine(moveList, 0, gridSize - 1, 1, -1, winLength)) {  // Top-right to bottom-left diagonal
    return true;
  }

  return false;
}

boolean checkLine(IntList moveList, int startX, int startY, int dx, int dy, int winLength) {
  // Helper function to check a line (row, column, or diagonal) for a win
  for (int i = 0; i < winLength; i++) {
    int move = startX + i * dx + (startY + i * dy) * 10;  // Generate move as row-column pair
    if (!moveList.hasValue(move)) {
      return false;  // If any position in the line is not occupied, return false
    }
  }
  return true;  // All positions in the line are occupied, return true (win)
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
  // If it's the computer's turn (check == 1) and at the right moment
  if (check == 1) {
    // Step 1: Check if the computer can win
    int winMove = findWinningMove(Ochosen);
    if (winMove != -1) {
      // Play the winning move
      makeMove(winMove, 'O');
      return;
    }

    // Step 2: Check if the player is about to win and block them
    int blockMove = findWinningMove(Xchosen);
    if (blockMove != -1) {
      // Block the player's winning move
      makeMove(blockMove, 'O');
      return;
    }

    // Step 3: If no win or block, choose the best available move
    int strategicMove = findBestMove();
    if (strategicMove != -1) {
      makeMove(strategicMove, 'O');
      return;
    }
  }
}

// Function to make a move (add to the chosen list and draw O/X on the board)
void makeMove(int move, char player) {
  int i = move / 10;  // Row index
  int j = move % 10;  // Column index

  chosen.append(move); // Mark this position as chosen

  if (player == 'O') {
    drawO(i * gridSide, j * gridSide + 30); // Draw O
    Ochosen.append(move);  // Add to O's moves
    check = 0;  // End computer's turn
  } else if (player == 'X') {
    drawX(i * gridSide, j * gridSide + 30, CurrentXColor);  // Draw X (for blocking simulation)
    Xchosen.append(move);  // Add to X's moves (for blocking simulation)
  }
}

// Find a winning move for the given player (X or O)
int findWinningMove(IntList playerMoves) {
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      int currentMove = int(str(i) + str(j));
      // If the space is empty and this move would cause a win
      if (!chosen.hasValue(currentMove) && wouldWin(playerMoves, currentMove)) {
        return currentMove;  // Return the winning move
      }
    }
  }
  return -1;  // No winning move found
}

// Check if adding a move to the player's moves would cause a win
boolean wouldWin(IntList playerMoves, int newMove) {
  IntList testMoves = playerMoves.copy();  // Copy the player's current moves
  testMoves.append(newMove);  // Add the new move to simulate the result
  return checkWin(testMoves);  // Check if this would result in a win
}

// Function to find the best available move (e.g., prioritize center or corners)
int findBestMove() {
  // Prioritize center and corners for better strategy
  int[] preferredMoves = {
    int(str(2) + str(2)),  // Center
    int(str(0) + str(0)),  // Top-left corner
    int(str(0) + str(4)),  // Top-right corner
    int(str(4) + str(0)),  // Bottom-left corner
    int(str(4) + str(4))   // Bottom-right corner
  };

  // Try to make a move in the preferred locations if available
  for (int move : preferredMoves) {
    if (!chosen.hasValue(move)) {
      return move;
    }
  }

  // If no preferred moves are available, choose any random empty space
  for (int i = 0; i < 5; i++) {
    for (int j = 0; j < 5; j++) {
      int move = int(str(i) + str(j));
      if (!chosen.hasValue(move)) {
        return move;
      }
    }
  }

  return -1;  // No available moves
}

void MovingBuilding() {
  //Moving building background
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
