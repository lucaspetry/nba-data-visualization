import controlP5.*;

BasketballCourt b;
ArrayList<GameEvent> events;
float currentEvent = 0;

ControlP5 control;
Button play;
Slider timeFrame;

void setup() {
  frameRate(40);
  size(800, 600, P2D);
  b = new BasketballCourt(700, 400);
  b.setup();
  loadEvents("data/games/0041400101/16.csv");
  
  control = new ControlP5(this);
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

void controlEvent(ControlEvent theEvent) {  
  if(theEvent.isFrom(control.getController("events"))) {
    currentEvent = control.getController("events").getValue();
  }
}

void draw() {
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
  
void loadEvents(String fileName) {
  String lines[] = loadStrings(fileName);
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