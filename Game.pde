public class Game {

  private int id;
  private String date;
  private Team homeTeam;
  private Team visitorTeam;
  private int homeScore;
  private int visitorScore;
  
  public Game(int id, String date, Team homeTeam, Team visitorTeam, int homeScore, int visitorScore) {
    this.id = id;
    this.date = date;
    this.homeTeam = homeTeam;
    this.visitorTeam = visitorTeam;
    this.homeScore = homeScore;
    this.visitorScore = visitorScore;
  }
  
  public int getId() {
    return this.id;
  }
  
  public String getDate() {
    return this.date;
  }
  
  public Team getHomeTeam() {
    return this.homeTeam;
  }
  
  public Team getVisitorTeam() {
    return this.visitorTeam;
  }
  
  public Team getWinner() {
    if(this.homeScore > this.visitorScore)
      return this.homeTeam;
    else if(this.homeScore < this.visitorScore)
      return this.visitorTeam;
    return null;
  }
  
  public int getHomeScore() {
    return this.homeScore;
  }
  
  public int getVisitorScore() {
    return this.visitorScore;
  }
  
  public ArrayList<GameEvent> getEvents() {
    return new FileLoader().loadGameEvents(this.id);
  }
  
  public float[][] getAverageSpeed(Player player) {
    return new FileLoader().getAverageSpeed(this.id, player.getId());
  }
  
}