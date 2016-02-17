public class VScrollBar {

  private int x;
  private int y;
  private int barWidth; // Bar width
  private int barHeight; // Bar height
  private int sliderPos; // Vertical position of the slider
  private int sliderHeight; // Slider height
  private int scrollRange; // Vertical scrolling range
  private boolean mouseOverBar;
  private boolean mouseOverSlider;
  private boolean mousePress;

  public VScrollBar(int barWidth, int barHeight, int scrollRange) {
    this.barWidth = barWidth;
    this.barHeight = barHeight;
    this.scrollRange = scrollRange;
    this.sliderPos = 0;
    this.mouseOverBar = false;
    this.mouseOverSlider = false;
    this.mousePress = false;
    
    if(scrollRange <= barHeight)
      this.sliderHeight = barHeight;
    else
      this.sliderHeight = (barHeight*barHeight)/scrollRange;
  }

  public void update() {
    this.x = (int) modelX(0, 0, 0);
    this.y = (int) modelY(0, 0, 0);
    if (mouseX > x && mouseX < x+barWidth &&
      mouseY > y+sliderPos && mouseY < y+sliderPos+sliderHeight) {
      mouseOverSlider = true;
      mouseOverBar = true;
    } else if (mouseX > x && mouseX < x+barWidth &&
      mouseY > y && mouseY < y+barHeight) {
      mouseOverSlider = false;
      mouseOverBar = true;
    } else {
      mouseOverSlider = false;
      mouseOverBar = false;
    }
  }

  public void mouseEvent(int eventType) {
    switch(eventType) {
      case MOUSE_PRESSED:
        if(mouseOverSlider)
          mousePress = true;
        else if(mouseOverBar) {
          mousePress = true;
          sliderPos = mouseY - y - sliderHeight/2;
        }
        break;
      case MOUSE_RELEASED:
        mousePress = false;
        break;
      case MOUSE_DRAGGED:
        if(mousePress) {
          if(mouseY > y && mouseY < y+barHeight)
            sliderPos += mouseY - pmouseY;
        }
        break;
      default:
        break;
    }
    
    if(sliderPos < 0)
      sliderPos = 0;
    else if(sliderPos+sliderHeight > barHeight)
      sliderPos = barHeight-sliderHeight;
  }

  public void draw() {
    noStroke();

    // Draw bar
    fill(204);
    rect(0, 0, barWidth, barHeight);

    // Draw slider
    if (mouseOverSlider) {
      fill(0, 0, 0);
    } else {
      fill(102, 102, 102);
    }
    rect(0, sliderPos, barWidth, sliderHeight);
  }
  
  public float getPos() {
    float pct = sliderPos/(float) (barHeight - sliderHeight);
    
    if(barHeight >= scrollRange)
      return 0;
    else
      return (barHeight-scrollRange)*pct;
  }
}