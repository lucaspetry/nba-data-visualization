public class VScrollBar {

  private float x;
  private float y;
  private int barWidth; // Bar width
  private int barHeight; // Bar height
  private int sliderPos; // Vertical position of the slider
  private int sliderHeight; // Slider height
  private int scrollRange; // Vertical scrolling range
  private boolean mouseOverBar;
  private boolean mouseOverSlider;
  private boolean mousePress;

  //int swidth, sheight;    // width and height of bar
  //float xpos, ypos;       // x and y position of bar
  //float spos, newspos;    // x position of slider
  //float sposMin, sposMax; // max and min values of slider
  //int loose;              // how loose/heavy
  //boolean over;           // is the mouse over the slider?
  //boolean locked;
  //float ratio;

  public VScrollBar(int barWidth, int barHeight, int scrollRange) {
    this.x = modelX(0, 0, 0);
    this.y = modelY(0, 0, 0);
    this.barWidth = barWidth;
    this.barHeight = barHeight;
    this.scrollRange = scrollRange;
    this.sliderHeight = (int) (barWidth*0.8);
    this.sliderPos = 0;
    this.mouseOverBar = false;
    this.mouseOverSlider = false;
    this.mousePress = false;
  }

  public void update() {
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

  private float constrain(float val, float minv, float maxv) {
    return min(max(val, minv), maxv);
  }

  public void mouseEvent(int eventType) {
    switch(eventType) {
      case MOUSE_PRESSED:
        if(mouseOverSlider)
          mousePress = true;
        else if(mouseOverBar) {
          mousePress = true;
          sliderPos = mouseY - sliderHeight/2;
        }
        break;
      case MOUSE_RELEASED:
        mousePress = false;
        break;
      case MOUSE_DRAGGED:
        if(mousePress) {
          sliderPos = mouseY - sliderHeight/2;
        }
        break;
      default:
        break;
    }
    
    if(y+sliderPos < y)
      sliderPos = 0;
    else if(y+sliderPos+sliderHeight > y+barHeight)
      sliderPos = (int) y+barHeight-sliderHeight;
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
    return scrollRange*(1-pct);
  }
  
  public float getPos(float objHeight) {
    float pct = sliderPos/(float) (barHeight - sliderHeight);
    return (scrollRange-objHeight)*(1-pct);
  }
}