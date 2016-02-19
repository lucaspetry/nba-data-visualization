/** Global objects **/
HashMap<Integer, Player> PLAYERS = new HashMap<Integer, Player>();
HashMap<Integer, Team> TEAMS = new HashMap<Integer, Team>();
HashMap<Integer, Game> GAMES = new HashMap<Integer, Game>();

/** Global images **/
PImage NBA_HEADER_50;
PImage NBA_HEADER_100;

/** Global colors **/
color COLOR_BLUE1 = color(233, 242, 249);
color COLOR_BLUE2 = color(210, 228, 242);
color COLOR_BLUE3 = color(156, 196, 228);
color COLOR_BLUE4 = color(27, 50, 95);

color COLOR_RED1 = color(204, 42, 65);
color COLOR_BACKGROUND = COLOR_BLUE3;//color(232, 202, 164);
color COLOR_ORANGE1 = color(242, 108, 79);

color COLOR_GRAY1 = color(81, 81, 81);

color COLOR_NBA_BLUE = color(0, 116, 191);
color COLOR_NBA_RED = color(239, 50, 78);
color COLOR_NBA_RED_HIGHLIGHT = color(213, 17, 47);
color COLOR_NBA_RED_OVER = color(146, 12, 32);

/** Fonts **/
PFont FONT_12;
PFont FONT_14;
PFont FONT_16;
PFont FONT_20;

PFont FONT_BOLD_12;
PFont FONT_BOLD_14;
PFont FONT_BOLD_24;
PFont FONT_BOLD_28;

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
  if(window != PREVIOUS_WINDOW.get(PREVIOUS_WINDOW.size()-1))
    PREVIOUS_WINDOW.add(CURRENT_WINDOW);
  else
    PREVIOUS_WINDOW.remove(PREVIOUS_WINDOW.size()-1);
    
  CURRENT_WINDOW.clearControls();
  CURRENT_WINDOW = window;
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
  surface.setResizable(false);
  frameRate(60);
  size(1100, 700, P2D);
  
  this.loadGlobals();
  
  // Setup current window
  CURRENT_WINDOW.setup();
}

//import java.io.File;
//import java.io.FileOutputStream;
//import java.io.FilenameFilter;
//import java.io.IOException;
//import java.net.MalformedURLException;
//import java.net.URL;
//import java.nio.channels.Channels;
//import java.nio.channels.ReadableByteChannel;

//void test() {

//  for(int t : PLAYERS.keySet()) {
//    try {
//      URL website = new URL("http://stats.nba.com/media/players/230x185/" + t + ".png");
//      ReadableByteChannel rbc = Channels.newChannel(website.openStream());
//      FileOutputStream fos = new FileOutputStream("C:\\Processing-301\\workspace\\main\\images\\players\\" + t + ".png");
//      fos.getChannel().transferFrom(rbc, 0, Long.MAX_VALUE);
//    } catch(Exception e) {
//      println(e);
//    }
//  }
//  println("done");
//}

void loadGlobals() {
  // Load images
  NBA_HEADER_50 = loadImage("images/nba_header.jpg");
  NBA_HEADER_50.resize(155, 50);
  NBA_HEADER_100 = loadImage("images/nba_header.jpg");
  NBA_HEADER_100.resize(309, 100);
  
  // Load fonts
  FONT_12 = createFont("Arial", 12, true);
  FONT_14 = createFont("Arial", 14, true);
  FONT_16 = createFont("Arial", 16, true);
  FONT_20 = createFont("Arial", 20, true);
  FONT_BOLD_12 = createFont("Arial Bold", 12, true);
  FONT_BOLD_14 = createFont("Arial Bold", 14, true);
  FONT_BOLD_24 = createFont("Arial Bold", 24, true);
  FONT_BOLD_28 = createFont("Arial Bold", 28, true);

  // Load games, teams and players
  FileLoader f = new FileLoader();
  f.loadObjects();
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