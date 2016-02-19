public class GameEventFrame {
  
  private int moment;
  private float gameClock;
  private float shotClock;
  private float[] ball; // x, y, height
  private PlayerPosition[] homePlayers;
  private PlayerPosition[] visitorPlayers;
  
  public GameEventFrame(int moment, float gameClock, float shotClock,
                    float[] ball, PlayerPosition[] homePlayers, PlayerPosition[] visitorPlayers) {
    this.moment = moment;
    this.gameClock = gameClock;
    this.shotClock = shotClock;
    this.ball = new float[] {ball[0], ball[1], ball[2]};
    this.homePlayers = new PlayerPosition[]{homePlayers[0], homePlayers[1], homePlayers[2], homePlayers[3], homePlayers[4]};
    this.visitorPlayers = new PlayerPosition[]{visitorPlayers[0], visitorPlayers[1], visitorPlayers[2], visitorPlayers[3], visitorPlayers[4]};
  }
  
  public ArrayList<PlayerPosition[]> getTeams() {
    ArrayList<PlayerPosition[]> teams = new ArrayList<PlayerPosition[]>(2);
    teams.add(homePlayers);
    teams.add(visitorPlayers);
    return teams;
  }
  
  public float[] getBall() {
    return this.ball;
  }
  
}