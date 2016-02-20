public class EventWindow implements Window {

  private ControlP5 control;
  private Button playPause;
  private Button stop;
  private Slider timeFrame;
  private WindowHeader header;
  
  private GameEvent gameEvent;
  
  private BasketballCourt b;
  private ArrayList<GameEventFrame> events;
  private float currentEvent = 0;
  private boolean playing;

  public EventWindow(GameEvent gameEvent) {
    this.header = new WindowHeader("Event: " + gameEvent.getHomeDescription() + gameEvent.getVisitorDescription());
    this.gameEvent = gameEvent;
    this.playing = false;
  }

  public void setup() {
    this.b = new BasketballCourt(700, 400);
    this.b.setup();
    events = this.gameEvent.getEventFrames();
    
    control = new ControlP5(WINDOW_APPLET);
    timeFrame = control.addSlider("events", "", "")
          .setPosition(120, 70)
          .setSize(350,25)
          .setValue(0)
          .setRange(0, events.size() - 1);
    playPause = control.addButton("playback", "", "play")
       .setValue(0)
       .setPosition(20, 70)
       .setSize(40, 25);
    stop = control.addButton("stop", "", "stop")
       .setValue(0)
       .setPosition(70, 70)
       .setSize(40, 25);
  }
  
  public void draw() {
    background(COLOR_BACKGROUND);
    GameEventFrame ge = events.get((int)currentEvent);
    
    control.draw();
    
    fill(COLOR_GRAY1);
    textAlign(LEFT);
    textFont(FONT_BOLD_14);
    text("Game Clock: " + ge.getGameClock(), 485, 87);
    text("Shot Clock: " + ge.getShotClock(), 635, 87);
    
    pushMatrix();
    translate(20, 105);
    fill(120);
    rect(0, 0, b.getWidth() + 60, b.getHeight() + 60);
    translate(30, 30);
    b.draw();
    
    b.drawPlayersAndBall(ge.getHomeTeam(), ge.getVisitorTeam(), ge.getBall());
    
    
    popMatrix();
    
    // If play is on, move to next frame
    if(playing) {
      timeFrame.setValue((currentEvent+1)%events.size());
    }
    
    header.draw();
  }
  
  public void mouseEvent(int eventType) {
    b.mouseEvent(eventType);
    header.mouseEvent(eventType);
  }
  
  public void event(ControlEvent event) {  
    if(event.isFrom(timeFrame)) {
      currentEvent = timeFrame.getValue();
    } else if(event.isFrom(playPause)) {
      playing = !playing;
      if(playing)
        playPause.setLabel("pause");
      else
        playPause.setLabel("play");
    } else if(event.isFrom(stop)) {
      playing = false;
      timeFrame.setValue(0);
    }
  }
  
  public void clearControls() {
    control.dispose();
  }

}