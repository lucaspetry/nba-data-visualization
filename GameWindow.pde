public class GameWindow implements Window {

  private ControlP5 control;
  private Button play;
  private Slider timeFrame;
  
  private VScrollBar scrollBar;
  private Component playByPlayBox;
  private Game game;
  
  private BasketballCourt b;
  ArrayList<GameEventFrame> events;
  float currentEvent = 0;

  public GameWindow(Game game) {
    this.game = game;
  }

  public void setup() {
    this.playByPlayBox = new PlayByPlayBox(this.game);
    this.playByPlayBox.setup();
    this.scrollBar = new VScrollBar(20, WINDOW_HEIGHT, this.playByPlayBox.getHeight());
    this.b = new BasketballCourt(500, 400);
    this.b.setup();
    events = new FileLoader().loadGameEventFrames(41400101, 2);
    
    control = new ControlP5(WINDOW_APPLET);
    timeFrame = control.addSlider("events")
          .setPosition(100, 20)
          .setSize(200,25)
          .setValue(0)
          .setRange(0, events.size() - 1);
    play = control.addButton("Play/Pause", "", "playback")
       .setValue(0)
       .setPosition(20, 20)
       .setSize(70, 25);
  }
  
  public void draw() {
    background(COLOR_BACKGROUND);
    control.draw();
    b.draw();
    
    pushMatrix();
    translate(WINDOW_WIDTH - scrollBar.getWidth(), 0);
    scrollBar.update();
    scrollBar.draw();
    translate(-playByPlayBox.getWidth(), scrollBar.getPos());
    playByPlayBox.draw();
    popMatrix();
    
    GameEventFrame ge = events.get((int)currentEvent);
    ArrayList<PlayerPosition[]> teams = ge.getTeams();
    b.drawPlayersAndBall(teams.get(0), teams.get(1), ge.getBall());
    
    // Draw players
    if(play.isOn()) {
      timeFrame.setValue((currentEvent+1)%events.size());
    }
  }
  
  public void mouseEvent(int eventType) {
    scrollBar.mouseEvent(eventType);
    playByPlayBox.mouseEvent(eventType);
  }
  
  public void event(ControlEvent event) {  
    if(event.isFrom(control.getController("events"))) {
      currentEvent = control.getController("events").getValue();
    }
  }
  
  public void clearControls() {
    control.dispose();
  }

}