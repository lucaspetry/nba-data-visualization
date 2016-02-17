public class GamesBox extends Component {
  
  private int boxHeight;
  private int boxWidth;
  
  public GamesBox() {
    this.boxHeight = 1000;
    this.boxWidth = 500;
  }
  
  public void setup() {
  }
  
  public void draw() {
    fill(100, 0, 0);
    rect(0, 0, this.boxWidth, this.boxHeight*0.5);
  }
  
  public int getHeight() {
    return this.boxHeight;
  }
  
  public int getWidth() {
    return this.boxWidth;
  }
  
  public void mouseEvent(int eventType) {
  }
  
}