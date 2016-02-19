public class MainWindow implements Window {
  
  private final static String playerImgUrl = "http://stats.nba.com/media/players/132x132/PLAYER_ID.png";
  
  private VScrollBar scrollBar;
  private Component gamesBox;
  
  public MainWindow() {
  }

  public void setup() {
    noStroke();
    this.gamesBox = new GamesBox();
    this.gamesBox.setup();
    this.scrollBar = new VScrollBar(20, WINDOW_HEIGHT, this.gamesBox.getHeight());
  }
  
  public void draw() {
    background(COLOR_BACKGROUND);

    fill(COLOR_RED1);
    rect(0, 0, WINDOW_WIDTH, 100);
    
    image(NBA_LOGO, 10, 10);
    
    fill(255);
    textFont(FONT_BOLD_28);
    textAlign(LEFT);
    text("2014-15 NBA Season", 65, 60);
    
    pushMatrix();
    translate(WINDOW_WIDTH - scrollBar.getWidth() - 50, 0);
    scrollBar.update();
    scrollBar.draw();
    translate(-gamesBox.getWidth(), scrollBar.getPos());
    gamesBox.draw();
    popMatrix();
  }
    
  public void mouseEvent(int eventType) {
    scrollBar.mouseEvent(eventType);
    gamesBox.mouseEvent(eventType);
  }
  
  public void event(ControlEvent event) {
  }
  
  public void clearControls() {
  }
  
  private void loadGames() {
    
  }

}