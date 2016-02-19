public class GameWindow implements Window {

  ControlP5 control;
  Button play;
  Slider timeFrame;
  
  BasketballCourt b;
  ArrayList<GameEventFrame> events;
  float currentEvent = 0;

  public GameWindow(Game game) {
  }

  public void setup() {
    b = new BasketballCourt(700, 400);
    b.setup();
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
    background(100);
    control.draw();
    b.draw();
    
    GameEventFrame ge = events.get((int)currentEvent);
    ArrayList<PlayerPosition[]> teams = ge.getTeams();
    b.drawPlayersAndBall(teams.get(0), teams.get(1), ge.getBall());
    
    // Draw players
    if(play.isOn()) {
      timeFrame.setValue((currentEvent+1)%events.size());
    }
  }
  
  public void mouseEvent(int eventType) {
    switch(eventType) {
      case MOUSE_PRESSED:
        break;
      case MOUSE_RELEASED:
        break;
      case MOUSE_CLICKED:
        break;
      case MOUSE_MOVED:
        break;
      case MOUSE_DRAGGED:
        break;
      case MOUSE_WHEEL_UP:
        break;
      case MOUSE_WHEEL_DOWN:
        break;
    }
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