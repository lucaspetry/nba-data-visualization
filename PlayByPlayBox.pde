public class PlayByPlayBox extends Component {
    
  public class PBPRow extends Component {
    
    private int x;
    private int y;
    private int rowHeight;
    private int rowWidth;
    private boolean mouseOver;
    private GameEvent gameEvent;
    private color background;
    
    public PBPRow(int rowWidth, int rowHeight, GameEvent gameEvent) {
      this.rowWidth = rowWidth;
      this.rowHeight = rowHeight;
      this.mouseOver = false;
      this.gameEvent = gameEvent;
      
      if(!gameEvent.getScore().equals(""))
        this.rowHeight *= 1.5;
      
      if(currentColor)
        this.background = COLOR_BLUE1;
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
      
      fill(COLOR_GRAY1);
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
      
      //int scoreCenter = 240;
      
      //image(game.getHomeTeam().getLogo(), scoreCenter - 135, 2, 68, 55);
      //image(game.getVisitorTeam().getLogo(), scoreCenter + 135 - 68, 2, 68, 55);
      
      //textFont(FONT_BOLD_24);
      //text("X", scoreCenter, this.rowHeight/2+6);
      //textFont(FONT_20);
      //text(game.getHomeScore(), scoreCenter - 35, this.rowHeight/2+5);
      //text(game.getVisitorScore(), scoreCenter + 35, this.rowHeight/2+5);
    }
    
    public int getHeight() {
      return this.rowHeight;
    }
    
    public int getWidth() {
      return this.rowWidth;
    }
    
    public void mouseEvent(int eventType) {
      if(eventType == MOUSE_CLICKED && mouseOver) {
        // Open event
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
  
  public PlayByPlayBox(Game game) {
    this.currentColor = false;
    this.pbpRowHeight = 25;
    this.boxHeight = 0;
    this.boxWidth = 800;
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