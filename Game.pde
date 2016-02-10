public class Game {

  private int id;
  private String date;
  private Team homeTeam;
  private Team visitorTeam;
  
  public Game(int id, String date, Team homeTeam, Team visitorTeam) {
    this.id = id;
    this.date = date;
    this.homeTeam = homeTeam;
    this.visitorTeam = visitorTeam;
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
  
}