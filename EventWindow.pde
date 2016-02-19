public class EventWindow implements Window {

  private ControlP5 control;
  private Button play;
  private Slider timeFrame;
  
  private GameEvent gameEvent;
  
  private BasketballCourt b;
  ArrayList<GameEventFrame> events;
  float currentEvent = 0;

  public EventWindow(GameEvent gameEvent) {
    this.gameEvent = gameEvent;
  }

  public void setup() {
    this.b = new BasketballCourt(700, 400);
    this.b.setup();
    events = this.gameEvent.getEventFrames();
    
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
    
    pushMatrix();
    translate(50, 150);
    b.draw();
    GameEventFrame ge = events.get((int)currentEvent);
    ArrayList<PlayerPosition[]> teams = ge.getTeams();
    b.drawPlayersAndBall(teams.get(0), teams.get(1), ge.getBall());
    popMatrix();
    
    // Draw players
    if(play.isOn()) {
      timeFrame.setValue((currentEvent+1)%events.size());
    }
  }
  
  public void mouseEvent(int eventType) {
    b.mouseEvent(eventType);
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