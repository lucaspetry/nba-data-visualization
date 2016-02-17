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
    scrollBar = new VScrollBar(30, 200, 300);
    
    // Load images
    img1 = loadImage("images/floor-texture.jpg");
  }
  
  public void draw() {
    background(255);
    
    // Get the position of the img1 scrollbar
    // and convert to a value to display the img1 image 
    float img1Pos = scrollBar.getPos(img1.height);
    fill(255);
    image(img1, 0, img1Pos);
       
    scrollBar.update();
    scrollBar.draw();
    
    stroke(0);
    line(0, height/2, width, height/2);
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