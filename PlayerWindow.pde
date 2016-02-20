import org.gicentre.utils.stat.*;

public class PlayerWindow implements Window {
  
  private WindowHeader header;
  private Player player;
  private GameEvent gameEvent;
  private float[][] averageSpeed;
  private XYChart speedChart;
  private boolean speedChartAvailable;
  
  public PlayerWindow(Player player, GameEvent gameEvent) {
    this.header = new WindowHeader("Player: " + player.getQuoteName() + " (" + player.getJerseyNumber() + ")");
    this.gameEvent = gameEvent;
    this.player = player;
    speedChartAvailable = true;
  }
  
  public void setup() {
    this.averageSpeed = gameEvent.getGame().getAverageSpeed(player);
    textFont(FONT_12);
    // Both x and y data set here.  
    speedChart = new XYChart(WINDOW_APPLET);
    speedChart.setData(this.averageSpeed[0], this.averageSpeed[1]);
     
    // Axis formatting and labels.
    speedChart.showXAxis(true); 
    speedChart.showYAxis(true); 
    speedChart.setMinY(0);
       
    speedChart.setYFormat("# ft/s  ");
    speedChart.setXFormat("# s");
     
    // Symbol colours
    speedChart.setPointColour(color(180,50,50,100));
    speedChart.setPointSize(5);
    speedChart.setLineWidth(2);
  }
  
  public void draw() {
    noStroke();
    header.draw();
    
    pushMatrix();
    translate(20, header.getHeight()+20);
    fill(COLOR_BEIGE2);
    rect(0, 0, 470, 197);
    
    fill(COLOR_BACKGROUND);
    rect(20, 20, 200, 157);
    image(player.getPhoto(), 27, 27);
    
    fill(COLOR_GRAY1);
    translate(240, 20);
    textAlign(LEFT);
    textFont(FONT_BOLD_16);
    text("Name:", 0, 20);
    text("Jersey Number:", 0, 45);
    text("Team:", 0, 70);
    text("Team Games Played:", 0, 95);
    text("Team Wins:", 0, 120);
    text("Team Losses:", 0, 145);
    textFont(FONT_16);
    text(player.getQuoteName(), 55, 20);
    text(player.getJerseyNumber(), 130, 45);
    text(player.getTeam().getName(), 55, 70);
    int[] gwl = player.getTeam().getGamesWinsLosses();
    text(gwl[0], 165, 95);
    text(gwl[1], 95, 120);
    text(gwl[2], 115, 145);
    popMatrix();
    
    pushMatrix();
    translate(510, header.getHeight()+20);
    fill(COLOR_BEIGE2);
    rect(0, 0, 470, 197);
    
    fill(COLOR_GRAY1);
    textAlign(CENTER);
    textFont(FONT_BOLD_19);
    text("Event Stats", 470/2, 30);
    
    translate(20, 30);
    textAlign(LEFT);
    textFont(FONT_BOLD_16);
    text("Distance Traveled:", 0, 30);
    text("Average Speed:", 0, 55);
    textFont(FONT_16);
    text(gameEvent.getDistanceTraveled(player) + " ft", 150, 30);
    text(gameEvent.getAverageSpeed(player) + " ft/s", 125, 55);
    popMatrix();
    
    pushMatrix();
    translate(20, header.getHeight()+35+197);
    fill(COLOR_BEIGE2);
    rect(0, 0, 960, 350);
    
    fill(COLOR_GRAY1);
    textAlign(CENTER);
    textFont(FONT_BOLD_19);
    text("Average Speed in the Whole Game", 475, 30);
    
    textFont(FONT_12);
    if(speedChartAvailable) {
      try {
        speedChart.draw(30, 70, 900, 250);
      } catch(Exception e) {
        speedChartAvailable = false;
      }
    } else {
      fill(COLOR_GRAY1);
      textAlign(CENTER);
      textFont(FONT_BOLD_24);
      text("Looks like there's a flaw :(", 480, 200);
    }
    popMatrix();
  }
  
  public void mouseEvent(int eventType) {
    header.mouseEvent(eventType);
  }
  
  public void event(ControlEvent event) {
  }
  
  public void clearControls() {
  }
  
}