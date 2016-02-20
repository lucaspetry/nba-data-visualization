public class GameEvent {
  
  private int gameId;
  private int eventNumber;
  private int period;
  private String periodClock;
  private String score;
  private String homeDescription;
  private String visitorDescription;
  
  public GameEvent(int gameId, int eventNumber, int period, String periodClock, String score,
                    String homeDescription, String visitorDescription) {
    this.gameId = gameId;
    this.eventNumber = eventNumber;
    this.period = period;
    this.periodClock = periodClock;
    this.score = score;
    this.homeDescription = homeDescription;
    this.visitorDescription = visitorDescription;
  }
  
  public int getPeriod() {
    return this.period;
  }
  
  public String getClock() {
    return this.periodClock;
  }
  
  public String getScore() {
    return this.score;
  }
  
  public String getHomeDescription() {
    return this.homeDescription;
  }
  
  public String getVisitorDescription() {
    return this.visitorDescription;
  }
  
  public HashMap<String, Float> getDistanceTraveledHomeTeam() {
    HashMap<String, Float> distances = new HashMap<String, Float>(5);
    FileLoader f = new FileLoader();
    
    for(Player p : GAMES.get(this.gameId).getHomeTeam().getPlayers()) {
      if(f.isPlayerInEvent(this.gameId, this.eventNumber, p.getId()))
        distances.put(p.getLastName() + " (" + p.getJerseyNumber() + ")",
                    f.getDistanceTraveled(this.gameId, this.eventNumber, p.getId()));
    }
    
    return distances;
  }
  
  public HashMap<String, Float> getDistanceTraveledVisitorTeam() {
    HashMap<String, Float> distances = new HashMap<String, Float>(5);
    FileLoader f = new FileLoader();
    
    for(Player p : GAMES.get(this.gameId).getVisitorTeam().getPlayers()) {
      if(f.isPlayerInEvent(this.gameId, this.eventNumber, p.getId()))
        distances.put(p.getLastName() + " (" + p.getJerseyNumber() + ")",
                    f.getDistanceTraveled(this.gameId, this.eventNumber, p.getId()));
    }
    
    return distances;
  }
  
  public float getDistanceTraveled(Player player) {
    return new FileLoader().getDistanceTraveled(this.gameId, this.eventNumber, player.getId());
  }
  
  public float getAverageSpeed(Player player) {
    return new FileLoader().getAverageSpeed(this.gameId, this.eventNumber, player.getId());
  }
  
  public boolean areFramesAvailable() {
    return new FileLoader().gameEventExists(this.gameId, this.eventNumber);
  }
  
  public ArrayList<GameEventFrame> getEventFrames() {
    return new FileLoader().loadGameEventFrames(this.gameId, this.eventNumber);
  }
  
  public Game getGame() {
    return GAMES.get(this.gameId);
  }
  
}