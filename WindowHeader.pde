public class WindowHeader extends Component {
  
  private int headerWidth;
  private int headerHeight;
  
  private int buttonsY;
  private int buttonsWidth;
  private int buttonsHeight;
  private int homeBtnX;
  private int backBtnX;
  private boolean overHomeBtn;
  private boolean overBackBtn;
  
  public WindowHeader() {
    this.headerWidth = WINDOW_WIDTH;
    this.headerHeight = 50;
    this.buttonsWidth = 75;
    this.buttonsHeight = 40;
    this.homeBtnX = 185;
    this.backBtnX = homeBtnX + buttonsWidth + 10;
    this.buttonsY = 5;
    this.overHomeBtn = false;
    this.overBackBtn = false;
  }
  
  public void setup() {
  }
  
  public void draw() {
    this.mouseOverButtons();    
    fill(COLOR_NBA_RED);
    rect(0, 0, WINDOW_WIDTH, headerHeight);
    
    fill(COLOR_NBA_BLUE);
    rect(0, 0, 75, headerHeight);
    
    image(NBA_HEADER_50, 30, 0);
    
    pushMatrix();
    this.drawButtons();
    popMatrix();
  }
  
  public int getHeight() {
    return this.headerHeight;
  }
  
  public int getWidth() {
    return this.headerWidth;
  }
  
  public void mouseEvent(int eventType) {
    if(eventType == MOUSE_CLICKED) {
      if(overHomeBtn)
        HOME_WINDOW();
      else if(overBackBtn)
        SWITCH_WINDOW(PREVIOUS_WINDOW.get(PREVIOUS_WINDOW.size()-1));
    }
  }
  
  private void mouseOverButtons() {
    if (mouseX > homeBtnX && mouseX < homeBtnX+buttonsWidth &&
        mouseY > buttonsY && mouseY < buttonsY+buttonsHeight)
      overHomeBtn = true;
    else
      overHomeBtn = false;
      
    if (mouseX > backBtnX && mouseX < backBtnX+buttonsWidth &&
        mouseY > buttonsY && mouseY < buttonsY+buttonsHeight)
      overBackBtn = true;
    else
      overBackBtn = false;
  }
  
  private void drawButtons() {
    // Home button
    if(!overHomeBtn)
      fill(COLOR_NBA_RED_HIGHLIGHT);
    else
      fill(COLOR_NBA_RED_OVER);
      
    rect(homeBtnX, buttonsY, buttonsWidth, buttonsHeight);
    
    fill(255);
    textFont(FONT_BOLD_14);
    textAlign(CENTER);
    text("Home", homeBtnX+buttonsWidth/2, buttonsY+5+buttonsHeight/2);
    
    // Back button
    if(!overBackBtn)
      fill(COLOR_NBA_RED_HIGHLIGHT);
    else
      fill(COLOR_NBA_RED_OVER);
      
    rect(backBtnX, buttonsY, buttonsWidth, buttonsHeight);
    
    fill(255);
    textFont(FONT_BOLD_14);
    textAlign(CENTER);
    text("Go Back", backBtnX+buttonsWidth/2, buttonsY+5+buttonsHeight/2);
  }
  
}