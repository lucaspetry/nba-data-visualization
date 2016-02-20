import org.gicentre.utils.stat.*;

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
  
  String[] labelsDistHome;
  float[] valuesDistHome;
  String[] labelsDistVisitor;
  float[] valuesDistVisitor;
  BarChart chartDistancesHome;
  BarChart chartDistancesVisitor;

  public EventWindow(GameEvent gameEvent) {
    this.header = new WindowHeader("Event: " + gameEvent.getHomeDescription() + gameEvent.getVisitorDescription());
    this.gameEvent = gameEvent;
    this.playing = false;
  }

  public void setup() {
    this.b = new BasketballCourt(650, 400, this.gameEvent);
    this.b.setup();
    events = this.gameEvent.getEventFrames();
    
    control = new ControlP5(WINDOW_APPLET);
    timeFrame = control.addSlider("events", "", "")
          .setPosition(120, 70)
          .setSize(450,25)
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

    HashMap<String, Float> distancesHome = gameEvent.getDistanceTraveledHomeTeam();
    labelsDistHome = new String[distancesHome.size()];
    valuesDistHome = new float[distancesHome.size()];
    int pIdx = 0;
    
    for(String player : distancesHome.keySet()) {
      labelsDistHome[pIdx] = player;
      valuesDistHome[pIdx] = distancesHome.get(player);
      pIdx++;
    }
    
    HashMap<String, Float> distancesVisitor = gameEvent.getDistanceTraveledVisitorTeam();
    labelsDistVisitor = new String[distancesVisitor.size()];
    valuesDistVisitor = new float[distancesVisitor.size()];
    pIdx = 0;
    
    for(String player : distancesVisitor.keySet()) {
      labelsDistVisitor[pIdx] = player;
      valuesDistVisitor[pIdx] = distancesVisitor.get(player);
      pIdx++;
    }
    
    this.setupDistanceGraphs();
  }
  
  public void draw() {
    background(COLOR_BACKGROUND);
    GameEventFrame ge = events.get((int)currentEvent);
    
    control.draw();
    
    fill(COLOR_GRAY1);
    textAlign(LEFT);
    textFont(FONT_BOLD_14);
    text(gameEvent.getGame().getHomeTeam().getAbbreviation(), 610, 87);
    text(gameEvent.getGame().getVisitorTeam().getAbbreviation(), 675, 87);
    fill(COLOR_HOME_TEAM);
    ellipse(595, 82, 20, 20);
    fill(COLOR_VISITOR_TEAM);
    ellipse(660, 82, 20, 20);
    
    pushMatrix();
    translate(20, 105);
    fill(COLOR_BEIGE2);
    rect(0, 0, b.getWidth() + 40, b.getHeight() + 40);
    translate(20, 20);
    b.draw();
    b.drawPlayersAndBall(ge.getHomeTeam(), ge.getVisitorTeam(), ge.getBall());
    
    translate(-20, b.getHeight() + 35);
    fill(COLOR_BEIGE2);
    rect(0, 0, b.getWidth() + 40, 170);
    translate(20, 20);
    fill(COLOR_GRAY1);
    textAlign(LEFT);
    textFont(FONT_BOLD_14);
    text("Game Clock: " + ge.getGameClock() + " sec", 0, 10);
    text("Shot Clock: " + ge.getShotClock() + " sec", 0, 35);
    text("Ball Height: " + ge.getBall()[2] + " ft", 0, 60);
    popMatrix();
    
    textAlign(CENTER);
    
    pushMatrix();    
    translate(730, 70);
    fill(COLOR_BEIGE2);
    rect(0, 0, 355, 295);
    textFont(FONT_12);
    chartDistancesHome.draw(17, 50, 320, 235);
    textFont(FONT_BOLD_16);
    fill(COLOR_GRAY1);
    text("Distance Traveled (" + gameEvent.getGame().getHomeTeam().getAbbreviation() + ")", 355/2, 30);
    
    translate(0, 310);
    fill(COLOR_BEIGE2);
    rect(0, 0, 355, 295);
    textFont(FONT_12);
    chartDistancesVisitor.draw(17, 50, 320, 235);
    textFont(FONT_BOLD_16);
    fill(COLOR_GRAY1);
    text("Distance Traveled (" + gameEvent.getGame().getVisitorTeam().getAbbreviation() + ")", 355/2, 30);
    popMatrix();
    
    // If play is on, move to next frame
    if(playing) {
      timeFrame.setValue((currentEvent+1)%events.size());
    }
    
    header.draw();
  }
  
  private void setupDistanceGraphs() {
    // Distances Home Team
    chartDistancesHome = new BarChart(WINDOW_APPLET);
    chartDistancesHome.setData(valuesDistHome);
    chartDistancesHome.setMinValue(0);
    chartDistancesHome.setMaxValue(max(valuesDistHome));
     
    // Appearance
    fill(255);
    textFont(FONT_12);
    chartDistancesHome.setBarColour(COLOR_HOME_TEAM);
    chartDistancesHome.setBarGap(10);
     
    chartDistancesHome.showValueAxis(true);
    chartDistancesHome.setValueFormat("# ft");
    chartDistancesHome.setBarLabels(labelsDistHome);
    chartDistancesHome.showCategoryAxis(true);
    chartDistancesHome.transposeAxes(true);
    
    // Distances Visitor Team
    chartDistancesVisitor = new BarChart(WINDOW_APPLET);
    chartDistancesVisitor.setData(valuesDistVisitor);
    chartDistancesVisitor.setMinValue(0);
    chartDistancesVisitor.setMaxValue(max(valuesDistVisitor));
     
    // Appearance
    fill(255);
    textFont(FONT_12);
    chartDistancesVisitor.setBarColour(COLOR_VISITOR_TEAM);
    chartDistancesVisitor.setBarGap(10);
     
    chartDistancesVisitor.showValueAxis(true);
    chartDistancesVisitor.setValueFormat("# ft");
    chartDistancesVisitor.setBarLabels(labelsDistVisitor);
    chartDistancesVisitor.showCategoryAxis(true);
    chartDistancesVisitor.transposeAxes(true);
    
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