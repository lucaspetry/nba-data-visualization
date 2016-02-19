public class GameWindow implements Window {
  
  private VScrollBar scrollBar;
  private Component playByPlayBox;
  private Game game;
  private WindowHeader header;
  
  public GameWindow(Game game) {
    this.game = game;
    this.header = new WindowHeader();
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
    
    fill(COLOR_RED1);
    rect(WINDOW_WIDTH-playByPlayBox.getWidth()-scrollBar.getWidth(), header.getHeight(), playByPlayBox.getWidth()+scrollBar.getWidth(), 100);
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