public class GameWindow implements Window {
  
  private Window previousWindow;
  private VScrollBar scrollBar;
  private Component playByPlayBox;
  private Game game;
  
  public GameWindow(Window previousWindow, Game game) {
    this.previousWindow = previousWindow;
    this.game = game;
  }

  public void setup() {
    this.playByPlayBox = new PlayByPlayBox(this.game);
    this.playByPlayBox.setup();
    this.scrollBar = new VScrollBar(20, WINDOW_HEIGHT, this.playByPlayBox.getHeight());
  }
  
  public void draw() {
    background(COLOR_BACKGROUND);
    
    pushMatrix();
    translate(WINDOW_WIDTH - scrollBar.getWidth(), 0);
    scrollBar.update();
    scrollBar.draw();
    translate(-playByPlayBox.getWidth(), scrollBar.getPos());
    playByPlayBox.draw();
    popMatrix();
  }
  
  public void mouseEvent(int eventType) {
    scrollBar.mouseEvent(eventType);
    playByPlayBox.mouseEvent(eventType);
  }
  
  public void event(ControlEvent event) {
  }
  
  public void clearControls() {
  }

}