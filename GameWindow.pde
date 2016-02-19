public class GameWindow implements Window {
  
  private VScrollBar scrollBar;
  private Component playByPlayBox;
  private Game game;
  private WindowHeader header;
  
  public GameWindow(Game game) {
    this.game = game;
    this.header = new WindowHeader("Game: " + game.getDate() + " - " + game.getVisitorTeam().getAbbreviation()
                                  + " " + game.getVisitorScore() + " x " + game.getHomeScore() + game.getHomeTeam().getAbbreviation());
  }

  public void setup() {
    this.playByPlayBox = new PlayByPlayBox(800, 0, this.game);
    this.playByPlayBox.setup();
    this.scrollBar = new VScrollBar(20, WINDOW_HEIGHT-150, this.playByPlayBox.getHeight());
  }
  
  public void draw() {
    background(COLOR_BACKGROUND);
    
    pushMatrix();
    translate(WINDOW_WIDTH - scrollBar.getWidth(), 150);
    scrollBar.update();
    scrollBar.draw();
    translate(-playByPlayBox.getWidth(), scrollBar.getPos());
    playByPlayBox.draw();
    popMatrix();
    
    int scoreCenter = playByPlayBox.getWidth()/2;
      
      
    pushMatrix();
    translate(WINDOW_WIDTH-playByPlayBox.getWidth()-scrollBar.getWidth(), header.getHeight());
    fill(COLOR_BLUE2);
    rect(0, 0, playByPlayBox.getWidth()+scrollBar.getWidth(), 100);
    
    fill(COLOR_GRAY1);
    textAlign(CENTER);
    textFont(FONT_BOLD_28);
    text("X", scoreCenter, 60);
    textFont(FONT_16);
    text(game.getDate(), scoreCenter, 90);
    textFont(FONT_BOLD_36);
    textAlign(RIGHT);
    text(game.getVisitorScore(), scoreCenter - 20, 62);
    textAlign(LEFT);
    text(game.getHomeScore(), scoreCenter + 20, 62);
    
    image(game.getVisitorTeam().getLogo(), scoreCenter - 385, 15, 80, 64);
    image(game.getHomeTeam().getLogo(), scoreCenter + 385 - 80, 15, 80, 64);
    
    textFont(FONT_BOLD_19);
    textAlign(RIGHT);
    text(game.getVisitorTeam().getName(), scoreCenter - 90, 56);
    textAlign(LEFT);
    text(game.getHomeTeam().getName(), scoreCenter + 90, 56);
    popMatrix();
    
    header.draw();
  }
  
  public void mouseEvent(int eventType) {
    scrollBar.mouseEvent(eventType);
    playByPlayBox.mouseEvent(eventType);
    header.mouseEvent(eventType);
  }
  
  public void event(ControlEvent event) {
  }
  
  public void clearControls() {
  }

}