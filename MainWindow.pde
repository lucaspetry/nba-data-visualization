public class MainWindow implements Window {
  
  private final static String playerImgUrl = "http://stats.nba.com/media/players/132x132/PLAYER_ID.png";
  private final static String teamImgUrl = "http://stats.nba.com/media/img/teams/logos/ABBREVIATION_logo.svg";
  
  private VScrollBar scrollBar;
  private Component gamesBox;
  
  public MainWindow() {
  }

  public void setup() {
    noStroke();
    this.gamesBox = new GamesBox();
    this.scrollBar = new VScrollBar(20, WINDOW_HEIGHT, this.gamesBox.getHeight());
  }
  
  public void draw() {
    background(255);
    translate((WINDOW_WIDTH + gamesBox.getWidth() - scrollBar.getWidth())/2, 0);
    scrollBar.update();
    scrollBar.draw();
    
    translate(-gamesBox.getWidth(), scrollBar.getPos());
    gamesBox.draw();
  }
    
  public void mouseEvent(int eventType) {
    scrollBar.mouseEvent(eventType);
  }
  
  public void event(ControlEvent event) {
  }
  
  public void clearControls() {
  }
  
  private void loadGames() {
    
  }

}