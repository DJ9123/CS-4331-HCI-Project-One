
// private final int WIDTH = 500;
// private final int HEIGHT = 1000;
Button[] buttons;
int[] range = {0, 1, 2, 5, 15, 30};
float timerAngle = 0;
boolean timerOn = false;
boolean timerPaused = false;
float endTime = 0;
String lastPressed = "";
float displayTime = 0;
int powerLevel = 3;

public void setup() {
  size(500, 1000);
  textAlign(CENTER, CENTER);
  textSize(48);
  // get curent time
  // draw buttons
  buttons = new Button[5];
  buttons[0] = new Button(75, 800, 350, 125, 244, 67, 54, "Stop/Clear", buttons);
  buttons[1] = new Button(75, 665, 350, 125, 63, 81, 181, "Open Door", buttons);
  buttons[2] = new Button(75, 555, 170, 100, 63, 81, 181, "Power", buttons);
  buttons[3] = new Button(255, 555, 170, 100, 63, 81, 181, "Timer", buttons);
  buttons[4] = new Button(200, 175, 100, 50, 244, 67, 54, "Resume", buttons);
}

public void draw() {
  clear();
  background(250, 250, 250);
  update();
  textSize(48);

  /// redraw circle
  fill(255);
  stroke(244, 67, 54);
  circle(250, 250, 475);

  /// redraw slider
  fill(244, 67, 54);
  float arcStart = PI + HALF_PI;
  arc(250, 250, 450, 450, arcStart, arcStart + timerAngle, PIE);
  fill(255);
  stroke(255);
  circle(250, 250, 250);
  stroke(244, 67, 54);
  circle(250, 250, 225);

  /// redraw timer
  fill(0);
  if (timerOn) {
    if (timerPaused) {
      endTime = millis() + (displayTime * 1000);
      buttons[4].show();
    }
    displayTime = (endTime - millis()) / 1000;
    // displaySeconds
    int m = (int)(displayTime / 60); 
    int s = (int)(displayTime % 60); 
    
    if (m != 0 || s != 0) {
      text(String.format("%02d:%02d", m, s), 250, 250);
    } else {
      text("Ding!", 250, 250);
    }

    if (displayTime <= 0) {
      timerOn = false;
      timerPaused = false;
      buttons[4].hide();
    }

    updateTimerAngle(displayTime);
  } else {
    // get current time if not running
    int h = hour();
    int m = minute();
    String[] ampm = {"AM", "PM"};

    text(String.format("%02d:%02d %s", h % 12, m, ampm[h / 12]), 250, 250);
  }

  /// redraw power level
  fill(244, 67, 54);
  stroke(244, 67, 54);
  int powerX = 200;
  int powerY = 285;
  int powerW = 30;
  int powerH = 15;
  if (powerLevel >= 1) {
    rect(powerX, powerY, powerW, powerH, 10);
  }
  if (powerLevel >= 2) {
    rect(powerX + powerW + 5, powerY, powerW, powerH, 10);
  }
  if (powerLevel >= 3) {
    rect(powerX + (powerW * 2) + 10, powerY, powerW, powerH, 10);
  }
  
  /// redraw buttons
  for (int i = 0; i < buttons.length; i++) {
    buttons[i].update();
    buttons[i].display();
  }
  
}

public void update() {
  if (mousePressed) {
    // check if over circle
    if (overCircle(250, 250, 475) && !overCircle(250, 250, 200)) {
      timerAngle = getTimerAngle();
      timerOn = true;
      timerPaused = false;
      buttons[4].hide();
      float timePercentage = timerAngle / TWO_PI * 100;
      float timerSeconds = 0;

      if (timePercentage > 0 && timePercentage < 25) {
        timerSeconds = (timePercentage/25) * 60;
      } else if (timePercentage >= 25 && timePercentage < 37.5) {
        timerSeconds = (((timePercentage-25)/12.5) * 60) + 60;
      } else if (timePercentage >= 37.5 && timePercentage < 50) {
        timerSeconds = (((timePercentage-37.5)/12.5 * 3) * 60) + 120;
      } else if (timePercentage >= 50 && timePercentage < 75) {
        timerSeconds = (((timePercentage-50)/25 * 10) * 60) + 300;
      } else if (timePercentage >= 75 && timePercentage < 100) {
        timerSeconds = (((timePercentage-75)/25 * 15) * 60) + 900;
      }

      endTime = millis() + (timerSeconds * 1000);
    }

    if (overCircle(250, 250, 200)) {
      timerPaused = false;
      buttons[4].hide();
    }
  }

  switch (lastPressed) {
    case "Stop/Clear":
      if (timerPaused) {
        timerPaused = false;
        endTime = millis();
      } else {
        timerPaused = true;
      }
      lastPressed = "";
      break;
    case "Open Door":
      timerPaused = true;
      lastPressed = "";
      break;
    case "Power":
      powerLevel = (powerLevel + 1) % 4;
      if (powerLevel == 0) {
        powerLevel = 1;
      }
      lastPressed = "";
      break;
    case "Timer":
      timerOn = true;
      timerPaused = true;
      endTime = millis() + 1000 * 300;
      displayTime = 300;
      lastPressed = "";
      break;
    case "Resume":
      timerPaused = false;
      buttons[4].hide();
    default:
      
  }

}

void mouseReleased()  {
  for (int i = 0; i < buttons.length; i++) {
    buttons[i].releaseEvent();
  }
}

public float getTimerAngle() {
  int centerX = 250;
  int centerY = 250;

  float atanRes = (float)Math.atan2(mouseX - centerX, mouseY - centerY);
  float positiveRes = atanRes + PI % TWO_PI;
  
  return TWO_PI - positiveRes;
}

public void updateTimerAngle(float remainingTime) {
  float timePercentage = 0;
  
  if (remainingTime > 0 && remainingTime < 60) {
    timePercentage = (remainingTime / 60) * 25;
  } else if (remainingTime >= 60 && remainingTime < 120) {
    timePercentage = ((remainingTime - 60) / 60 * 12.5) + 25; 
  } else if (remainingTime >= 120 && remainingTime < 300) {
    timePercentage = 5 * (remainingTime + 420) / 72;
  } else if (remainingTime >= 300 && remainingTime < 900) {
    timePercentage = (remainingTime + 900) / 24;
  } else if (remainingTime >= 900 && remainingTime < 1800) {
    timePercentage = remainingTime / 36 + 50;
  }

  timerAngle = timePercentage / 100 * TWO_PI;

}

boolean overCircle(int x, int y, int diameter) {
  float disX = x - mouseX;
  float disY = y - mouseY;
  if (sqrt(sq(disX) + sq(disY)) < diameter/2 ) {
    return true;
  } else {
    return false;
  }
}

class Button {
  int x, y;
  int width, height;
  color bg;
  String text;
  Button[] others;

  // inside function only
  boolean hidden = false;
  color bgHover;
  color bgPressed;
  boolean hover;
  boolean press;
  boolean locked = false;
  boolean otherslocked = false;

  Button(int x, int y, int width, int height, int r, int g, int b, String text, Button[] others) {
    this.x = x;
    this.y = y;
    this.width = width;
    this.height = height;
    this.bg = color(r, g, b);
    bgHover = color(r - 20, g - 20, b - 20);
    bgPressed = color(r - 40, g - 40, b - 40);
    this.text = text;
    this.others = others;

    if (text.equals("Resume")) {
      hidden = true;
    }
  }

  void update() {    
    for (int i=0; i<others.length; i++) {
      if (others[i].locked == true) {
        otherslocked = true;
        break;
      } else {
        otherslocked = false;
      }  
    }
    
    if (otherslocked == false) {
      hoverEvent();
      pressEvent();
    }
  }

  void display() {
    fill(bg);
    stroke(bg);

    // darken button on hover
    if (hover) {
      fill(bgHover);
      stroke(bgHover);
    }

    // darken even more on press
    if (press) {
      fill(bgPressed);
      stroke(bgPressed);
    }

    if (text.equals("Resume")) {
      textSize(20);
    } else {
      textSize(48);
    }

    if (!hidden) {
      rect(x, y, width, height, 20);
      // Draw text
      fill(255);
      text(text, x + (width/2), y + (height/2) + 2);
    }
    
  }

  void pressEvent() {
    if (hover && mousePressed || locked) {
      press = true;
      locked = true;
      lastPressed = text;
    } else {
      press = false;
    }

  }
  
  void releaseEvent() {
    locked = false;
  }

  void hoverEvent() {
    hover = mouseX >= x && mouseX <= x+width && 
           mouseY >= y && mouseY <= y+height;
  }

  void show() {
    hidden = false;
  }

  void hide() {
    hidden = true;
  }
}
