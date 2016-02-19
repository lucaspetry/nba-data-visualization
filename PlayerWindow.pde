public class PlayerWindow implements Window {
  
  private WindowHeader header;
  private Player player;
  
  public PlayerWindow(Player player) {
    this.header = new WindowHeader("Player: " + player.getQuoteName() + " (" + player.getJerseyNumber() + ")");
    this.player = player;
  }
  
  public void setup() {
  }
  
  public void draw() {
    noStroke();
    header.draw();
    
    pushMatrix();
    translate(20, header.getHeight()+20);
    fill(255);
    rect(0, 0, 470, 197);
    
    fill(COLOR_BLUE4);
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
    fill(255);
    rect(0, 0, 470, 197);
    
    fill(COLOR_GRAY1);
    translate(20, 30);
    textAlign(LEFT);
    textFont(FONT_BOLD_19);
    text("Event Stats", 0, 0);
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