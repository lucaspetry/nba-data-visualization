/** Global objects **/
HashMap<Integer, Player> PLAYERS = new HashMap<Integer, Player>();
HashMap<Integer, Team> TEAMS = new HashMap<Integer, Team>();
HashMap<Integer, Game> GAMES = new HashMap<Integer, Game>();

/** Global images **/
PImage NBA_HEADER;
PImage NBA_MAIN;

/** Global colors **/
color COLOR_BLUE1 = color(233, 242, 249);
color COLOR_BLUE2 = color(210, 228, 242);
color COLOR_BLUE3 = color(156, 196, 228);
color COLOR_BLUE4 = color(27, 50, 95);

color COLOR_RED1 = color(204, 42, 65);
color COLOR_BACKGROUND = COLOR_BLUE3;//color(120, 49, 19);
color COLOR_ORANGE1 = color(242, 108, 79);

color COLOR_GRAY1 = color(81, 81, 81);

color COLOR_NBA_BLUE = color(0, 116, 191);
color COLOR_NBA_RED = color(239, 50, 78);
color COLOR_NBA_RED_HIGHLIGHT = color(213, 17, 47);
color COLOR_NBA_RED_OVER = color(146, 12, 32);

color COLOR_COURT_BLUE = color(63, 128, 182);

/** Fonts **/
PFont FONT_12;
PFont FONT_14;
PFont FONT_16;
PFont FONT_20;

PFont FONT_BOLD_12;
PFont FONT_BOLD_14;
PFont FONT_BOLD_16;
PFont FONT_BOLD_19;
PFont FONT_BOLD_24;
PFont FONT_BOLD_28;
PFont FONT_BOLD_36;

/** Window **/
final int WINDOW_WIDTH = 1100;
final int WINDOW_HEIGHT = 700;
final PApplet WINDOW_APPLET = this;

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

Window HOME_WINDOW = new MainWindow();
Window CURRENT_WINDOW = HOME_WINDOW;
ArrayList<Window> PREVIOUS_WINDOW = new ArrayList<Window>(5);

void SWITCH_WINDOW(Window window) {
  Window newWindow = window;
  if(window != null)
    PREVIOUS_WINDOW.add(CURRENT_WINDOW);
  else
    newWindow = PREVIOUS_WINDOW.remove(PREVIOUS_WINDOW.size()-1);
    
  CURRENT_WINDOW.clearControls();
  CURRENT_WINDOW = newWindow;
  CURRENT_WINDOW.setup();
}

void HOME_WINDOW() {
  PREVIOUS_WINDOW.clear();
  PREVIOUS_WINDOW.add(null);
  SWITCH_WINDOW(HOME_WINDOW);
}

/** Setup and Draw Functions **/
void setup() {
  PREVIOUS_WINDOW.add(null);
  // Basic conf
  surface.setTitle("2014-15 NBA Season Data Visualization");
  frameRate(30);
  size(1100, 700, P2D);
  
  this.loadGlobals();
  
  // Setup current window
  CURRENT_WINDOW.setup();
}

void draw() {
  fill(COLOR_BACKGROUND);
  rect(0, 0, WINDOW_WIDTH, WINDOW_HEIGHT);
  CURRENT_WINDOW.draw();
}

//import java.io.File;
//void test() {
//  FileLoader l = new FileLoader();
//  int gameId = 41400216;
//  File f = new File(sketchPath("data\\games\\00" + gameId));
//  for(String e : f.list()) {
//    println("Game: " + gameId + " Event: " + e);
//    l.loadGameEventFrames(gameId, Integer.parseInt(e.substring(0, e.length()-4)));
//  } 
//}

void loadGlobals() {
  // Load images
  NBA_HEADER = loadImage("images/nba_header.jpg");
  NBA_HEADER.resize(155, 50);
  NBA_MAIN = loadImage("images/nba_main.jpg");
  
  // Load fonts
  FONT_12 = createFont("Arial", 12, true);
  FONT_14 = createFont("Arial", 14, true);
  FONT_16 = createFont("Arial", 16, true);
  FONT_20 = createFont("Arial", 20, true);
  FONT_BOLD_12 = createFont("Arial Bold", 12, true);
  FONT_BOLD_14 = createFont("Arial Bold", 14, true);
  FONT_BOLD_16 = createFont("Arial Bold", 16, true);
  FONT_BOLD_19 = createFont("Arial Bold", 19, true);
  FONT_BOLD_24 = createFont("Arial Bold", 24, true);
  FONT_BOLD_28 = createFont("Arial Bold", 28, true);
  FONT_BOLD_36 = createFont("Arial Bold", 36, true);

  // Load games, teams and players
  FileLoader f = new FileLoader();
  f.loadObjects();
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