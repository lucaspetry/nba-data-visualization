public class PlayByPlayBox extends Component {
    
  public class PBPRow extends Component {
    
    private int x;
    private int y;
    private int rowHeight;
    private int rowWidth;
    private boolean mouseOver;
    private GameEvent gameEvent;
    private color background;
    private boolean framesAvailable;
    
    public PBPRow(int rowWidth, int rowHeight, GameEvent gameEvent) {
      this.rowWidth = rowWidth;
      this.rowHeight = rowHeight;
      this.mouseOver = false;
      this.gameEvent = gameEvent;
      this.framesAvailable = gameEvent.areFramesAvailable();
      
      if(!gameEvent.getScore().equals(""))
        this.rowHeight *= 1.5;
      
      if(currentColor)
        this.background = COLOR_BEIGE1;
      else
        this.background = color(255);
        
      currentColor = !currentColor;
    }
    
    public void setup() {
    }
    
    public void draw() {
      this.mouseOver();
      
      if(mouseOver) {
          fill(COLOR_BLUE3);    
      } else {
        fill(this.background);
      }
      rect(0, 0, this.rowWidth, this.rowHeight);
      
      if(framesAvailable)
        fill(COLOR_GRAY1);
      else
        fill(COLOR_RED1);
        
      textFont(FONT_12);
      textAlign(CENTER);
      text("Q" + gameEvent.getPeriod(), 15, this.rowHeight*1.25/2);
      
      int clockCenter = this.rowWidth/2;
      
      if(gameEvent.getScore().equals("")) {
        text(gameEvent.getClock(), clockCenter, this.rowHeight*1.25/2);
        textFont(FONT_12);
      } else {
        text(gameEvent.getClock(), clockCenter, this.rowHeight*0.80/2);
        textFont(FONT_BOLD_12);
        text(gameEvent.getScore(), clockCenter, this.rowHeight*1.70/2);
      }
      
      textAlign(LEFT);
      text(gameEvent.getHomeDescription(), clockCenter + 35, this.rowHeight*1.25/2);
      textAlign(RIGHT);
      text(gameEvent.getVisitorDescription(), clockCenter - 35, this.rowHeight*1.25/2);
    }
    
    public int getHeight() {
      return this.rowHeight;
    }
    
    public int getWidth() {
      return this.rowWidth;
    }
    
    public void mouseEvent(int eventType) {
      if(eventType == MOUSE_CLICKED && mouseOver) {
        if(this.framesAvailable) {
          SWITCH_WINDOW(new EventWindow(this.gameEvent));
        }
      }
    }
    
    public void mouseOver() {
      this.x = (int) modelX(0, 0, 0);
      this.y = (int) modelY(0, 0, 0);
      
      if (mouseX > x && mouseX < x+rowWidth &&
        mouseY > y && mouseY < y+rowHeight) {
        mouseOver = true;
      } else {
        mouseOver = false;
      }
    }
    
  }
  
  private int boxWidth;
  private int boxHeight;
  private int pbpRowHeight;
  private ArrayList<PBPRow> rows;
  private boolean currentColor;
  private Game game;
  
  public PlayByPlayBox(int boxWidth, int boxHeight, Game game) {
    this.currentColor = false;
    this.pbpRowHeight = 25;
    this.boxHeight = boxHeight;
    this.boxWidth = boxWidth;
    this.game = game;
  }
  
  public void setup() {
    ArrayList<GameEvent> events = new FileLoader().loadGameEvents(this.game.getId());
    
    this.rows = new ArrayList<PBPRow>(events.size());
    
    for(GameEvent event : events) {
      PBPRow newRow = new PBPRow(this.boxWidth, this.pbpRowHeight, event);
      newRow.setup();
      rows.add(newRow);
      this.boxHeight += newRow.getHeight();
    }
  }
  
  public void draw() {
    pushMatrix();
    for(PBPRow r : rows) {
      r.draw();
      translate(0, r.getHeight());
    }
    popMatrix();
  }
  
  public int getHeight() {
    return this.boxHeight;
  }
  
  public int getWidth() {
    return this.boxWidth;
  }
  
  public void mouseEvent(int eventType) {    
    for(PBPRow r : rows)
      r.mouseEvent(eventType);
  }
  
}