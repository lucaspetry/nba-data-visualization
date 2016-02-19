public class WindowHeader extends Component {
  
  private int headerWidth;
  private int headerHeight;
  
  public WindowHeader() {
    this.headerWidth = WINDOW_WIDTH;
    this.headerHeight = 50;
  }
  
  public void setup() {
  }
  
  public void draw() {
    fill(COLOR_NBA_RED);
    rect(0, 0, WINDOW_WIDTH, headerHeight);
    
    fill(COLOR_NBA_BLUE);
    rect(0, 0, 75, headerHeight);
    
    image(NBA_HEADER_50, 30, 0);
  }
  
  public int getHeight() {
    return this.headerHeight;
  }
  
  public int getWidth() {
    return this.headerWidth;
  }
  
  public void mouseEvent(int eventType) {
    if(eventType == MOUSE_WHEEL_UP)
      SWITCH_WINDOW(PREVIOUS_WINDOW.get(PREVIOUS_WINDOW.size()-1));
  }
  
}