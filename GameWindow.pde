public class GameWindow implements Window {

  ControlP5 control;
  Button play;
  Slider timeFrame;
  
  BasketballCourt b;
  ArrayList<GameEvent> events;
  float currentEvent = 0;

  public GameWindow(Game game) {
  }
  
  public void setup() {
    b = new BasketballCourt(700, 400);
    b.setup();
    loadEvents("data/games/0041400101/16.csv");
    
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
    
    GameEvent ge = events.get((int)currentEvent);
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
        println("pressed");
        break;
      case MOUSE_RELEASED:
        println("released");
        break;
      case MOUSE_CLICKED:
        println("clicked");
        break;
      case MOUSE_MOVED:
        println("moved");
        break;
      case MOUSE_DRAGGED:
        println("dragged");
        break;
      case MOUSE_WHEEL_UP:
        println("wheel up");
        break;
      case MOUSE_WHEEL_DOWN:
        println("wheel down");
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
  
  private void loadEvents(String fileName) {
    String lines[] = WINDOW_APPLET.loadStrings(fileName);
    events = new ArrayList<GameEvent>(lines.length/10);
    PlayerPosition[] players = new PlayerPosition[10];
    int p = 0;
      
    int moment = -1;
    float gameClock = -1;
    float shotClock = -1;
    int period = -1;
    float[] ball = new float[]{0, 0, 0};
    
    for(int i = 0; i < lines.length; i++) {
      String[] fields = lines[i].split(",");
      int curMom = Integer.parseInt(fields[6]);
      
      if(curMom != moment) { // New event
        if(moment != -1)
          events.add(new GameEvent(moment, gameClock, shotClock,
                      period, ball, new PlayerPosition[]{players[0], players[1], players[2], players[3], players[4]},
                    new PlayerPosition[]{players[5], players[6], players[7], players[8], players[9]}));
        moment = curMom;
        p = 0;
        gameClock = Float.parseFloat(fields[7]);
        shotClock = Float.parseFloat(fields[8]);
        period = Integer.parseInt(fields[9]);
        ball[0] = Float.parseFloat(fields[3]);
        ball[1] = Float.parseFloat(fields[4]);
        ball[2] = Float.parseFloat(fields[5]);
        
      } else { // Same event
        int pId = Integer.parseInt(fields[2]);
        players[p] = new PlayerPosition(new Player(pId, "", "", 0, ""),
              Float.parseFloat(fields[3]), Float.parseFloat(fields[4]));
        p++;
      }
    }
  }

}