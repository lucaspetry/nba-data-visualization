public class GameWindow implements Window {
  
  PApplet main;
  
  public GameWindow(PApplet main) {
    this.main = main;
  }
  
  public void setup() {
    fill(200);
    rect(0,0,800, 600);
  }
  
  public void draw() {
  }

  public void event(ControlEvent event) {
  }
  
  public void clearControls() {
  }

}