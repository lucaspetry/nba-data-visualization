public class GameEventFrame {
  
  private int moment;
  private float gameClock;
  private float shotClock;
  private int period;
  private float[] ball; // x, y, height
  private PlayerPosition[] playersA;
  private PlayerPosition[] playersB;
  
  public GameEventFrame(int moment, float gameClock, float shotClock, int period,
                    float[] ball, PlayerPosition[] playersA, PlayerPosition[] playersB) {
    this.moment = moment;
    this.gameClock = gameClock;
    this.shotClock = shotClock;
    this.period = period;
    this.ball = new float[] {ball[0], ball[1], ball[2]};
    this.playersA = new PlayerPosition[]{playersA[0], playersA[1], playersA[2], playersA[3], playersA[4]};
    this.playersB = new PlayerPosition[]{playersB[0], playersB[1], playersB[2], playersB[3], playersB[4]};
  }
  
  public ArrayList<PlayerPosition[]> getTeams() {
    ArrayList<PlayerPosition[]> teams = new ArrayList<PlayerPosition[]>(2);
    teams.add(playersA);
    teams.add(playersB);
    return teams;
  }
  
  public float[] getBall() {
    return this.ball;
  }
  
}