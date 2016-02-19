public class Team {
  
  private final static String teamPrefix = "images/teams/";
  private final static String teamSufix = ".gif";
  private int id;
  private String name;
  private String abbreviation;
  private HashMap<Integer, Player> players;
  private PImage logo;
  
  public Team(int id, String name, String abbreviation, Player[] players) {
    this.id = id;
    this.name = name;
    this.abbreviation = abbreviation;
    this.logo = loadImage(teamPrefix + this.id + teamSufix);
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
  
  public PImage getLogo() {
    return this.logo;
  }
  
  public int[] getGamesWinsLosses() {
    return new FileLoader().getGamesWinsLosses(this.id);
  }
  
}