public class MainWindow implements Window {
  
  private final static String playerImgUrl = "http://stats.nba.com/media/players/132x132/PLAYER_ID.png";
  private final static String teamImgUrl = "http://stats.nba.com/media/img/teams/logos/ABBREVIATION_logo.svg";
  
  PApplet main;
  VScrollBar scrollBar;
  PImage img1;  // Two images to load
  
  public MainWindow(PApplet main) {
    this.main = main;
  }

  public void setup() {
    noStroke();
    img1 = loadImage("images/NBA_logo.jpg");
    scrollBar = new VScrollBar(30, 400);
  }
  
  public void draw() {
    background(255);
    float img1Pos = scrollBar.getPos(600);
    fill(100);
    rect(100, img1Pos, 100, 600);
    scrollBar.update();
    scrollBar.draw();
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