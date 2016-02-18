/** Global objects **/
HashMap<Integer, Player> PLAYERS = new HashMap<Integer, Player>();
HashMap<Integer, Team> TEAMS = new HashMap<Integer, Team>();
HashMap<Integer, Game> GAMES = new HashMap<Integer, Game>();

/** Global images **/
PImage NBA_LOGO;

/** Global colors **/
color COLOR_BLUE1 = color(233, 242, 249);
color COLOR_BLUE2 = color(210, 228, 242);
color COLOR_BLUE3 = color(156, 196, 228);
color COLOR_BLUE4 = color(27, 50, 95);

color COLOR_RED1 = color(204, 42, 65);
color COLOR_BACKGROUND = color(232, 202, 164);
color COLOR_ORANGE1 = color(242, 108, 79);

color COLOR_GRAY1 = color(81, 81, 81);

/** Fonts **/
PFont FONT_12;
PFont FONT_14;
PFont FONT_16;
PFont FONT_20;

PFont FONT_BOLD_14;
PFont FONT_BOLD_24;
PFont FONT_BOLD_28;

/** Window **/
final int WINDOW_WIDTH = 900;
final int WINDOW_HEIGHT = 600;
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

Window CURRENT_WINDOW = new MainWindow();

void SWITCH_WINDOW(Window window) {
  CURRENT_WINDOW.clearControls();
  CURRENT_WINDOW = window;
  CURRENT_WINDOW.setup();
}

/** Setup and Draw Functions **/
void setup() {
  // Basic conf
  frameRate(60);
  size(900, 600, P2D);
  
  this.loadGlobals();
  
  // Setup current window
  CURRENT_WINDOW.setup();
}

void loadGlobals() {
  // Load images
  NBA_LOGO = loadImage("images/NBA.png");
  NBA_LOGO.resize(34, 78);
  
  // Load fonts
  FONT_12 = createFont("Arial", 12, true);
  FONT_14 = createFont("Arial", 14, true);
  FONT_16 = createFont("Arial", 16, true);
  FONT_20 = createFont("Arial", 20, true);
  FONT_BOLD_14 = createFont("Arial Bold", 14, true);
  FONT_BOLD_24 = createFont("Arial Bold", 24, true);
  FONT_BOLD_28 = createFont("Arial Bold", 28, true);

  // Load games, teams and players
  FileLoader f = new FileLoader();
  f.loadObjects();
}

// REMOVE THIS!!!
void test() {
  Table tableGames = loadTable("data/games.csv", "header");
  tableGames.addColumn("homescore");
  tableGames.addColumn("visitorscore");
            
  for(TableRow r : tableGames.rows()) {
    JSONObject json = loadJSONObject("data2/playbyplay/00" + r.getInt("gameid") + ".json");
    JSONArray results = json.getJSONArray("resultSets");
    JSONArray rowSet = results.getJSONObject(0).getJSONArray("rowSet");
    JSONArray lastRow = rowSet.getJSONArray(rowSet.size()-1);
    
    r.setInt("homescore", Integer.parseInt(lastRow.getString(lastRow.size()-2).split(" - ")[1]));
    r.setInt("visitorscore", Integer.parseInt(lastRow.getString(lastRow.size()-2).split(" - ")[0]));
  }
  saveTable(tableGames, "data/games2.csv");
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