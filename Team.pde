public class Team {
  
  private int id;
  private String name;
  private String abbreviation;
  private HashMap<Integer, Player> players;
  
  public Team(int id, String name, String abbreviation, Player[] players) {
    this.id = id;
    this.name = name;
    this.abbreviation = abbreviation;
    this.players = new HashMap<Integer, Player>(10);
    
    for(Player p : players)
      this.players.put(p.getId(), p);
  }
  
  public int getId() {
    return this.id;
  }
  
  public String getName() {
    return this.name;
  }
  
  public String getAbbreviation() {
    return this.abbreviation;
  }
  
}