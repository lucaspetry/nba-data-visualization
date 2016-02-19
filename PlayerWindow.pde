public class PlayerWindow implements Window {
  
  private WindowHeader header;
  private Player player;
  
  public PlayerWindow(Player player) {
    this.header = new WindowHeader();
    this.player = player;
  }
  
  public void setup() {
  }
  
  public void draw() {
    header.draw();
  }
  
  public void mouseEvent(int eventType) {
    header.mouseEvent(eventType);
  }
  
  public void event(ControlEvent event) {
  }
  
  public void clearControls() {
  }
  
}