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