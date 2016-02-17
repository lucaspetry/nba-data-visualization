/** Mouse Events **/
final int MOUSE_PRESSED = 0;
final int MOUSE_RELEASED = 1;
final int MOUSE_CLICKED = 2;
final int MOUSE_MOVED = 3;
final int MOUSE_DRAGGED = 4;
final int MOUSE_WHEEL_UP = 5;
final int MOUSE_WHEEL_DOWN = 6;

/** Windows Control **/
final int MAIN_WINDOW = 0;
final int GAME_WINDOW = 1;

Window[] WINDOWS = new Window[]{new MainWindow(this),
                                new GameWindow(this)};
Window CURRENT_WINDOW = WINDOWS[MAIN_WINDOW];

void SWITCH_WINDOW(int window) {
  CURRENT_WINDOW.clearControls();
  CURRENT_WINDOW = WINDOWS[window];
  CURRENT_WINDOW.setup();
}

/** Setup and Draw Functions **/
void setup() {
  frameRate(30);
  size(1000, 600, P2D);
  CURRENT_WINDOW.setup();
}

void draw() {
  CURRENT_WINDOW.draw();
}

/** Control Events Handling **/
void controlEvent(ControlEvent event) {  
  CURRENT_WINDOW.event(event);
}

/** Mouse Events Handling **/
void mousePressed() {
  CURRENT_WINDOW.mouseEvent(MOUSE_PRESSED);
}

void mouseReleased() {
  CURRENT_WINDOW.mouseEvent(MOUSE_RELEASED);
}

void mouseClicked() {
  CURRENT_WINDOW.mouseEvent(MOUSE_CLICKED);
}

void mouseMoved() {
  CURRENT_WINDOW.mouseEvent(MOUSE_MOVED);
}

void mouseDragged() {
  CURRENT_WINDOW.mouseEvent(MOUSE_DRAGGED);
}

void mouseWheel(MouseEvent event) { // Not working properly
  float e = event.getCount();
  
  if(e > 0)
    CURRENT_WINDOW.mouseEvent(MOUSE_WHEEL_DOWN);
  else
    CURRENT_WINDOW.mouseEvent(MOUSE_WHEEL_UP);
}