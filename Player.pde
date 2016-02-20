public class Player {
  
  private final static String playerPrefix = "images/players/";
  private final static String playerSufix = ".png";
  private int id;
  private int teamId;
  private String firstName;
  private String lastName;
  private int jerseyNumber;
  private String position;
  private PImage photo;
  
  public Player(int id, int teamId, String firstName, String lastName,
                int jerseyNumber, String position) {
    this.id = id;
    this.teamId = teamId;
    this.firstName = firstName;
    this.lastName = lastName;
    this.jerseyNumber = jerseyNumber;
    this.position = position;
    this.photo = loadImage(playerPrefix + this.id + playerSufix);
    this.photo.resize(186, 150);
  }
  
  public int getId() {
    return this.id;
  }
  
  public String getFullName() {
    return this.firstName + " " + this.lastName;
  }
  
  public String getQuoteName() {
    return this.lastName + ", " + this.firstName;
  }
  
  public String getLastName() {
    return this.lastName;
  }
  
  public int getJerseyNumber() {
    return this.jerseyNumber;
  }
  
  public String getPosition() {
    return this.position;
  }
  
  public PImage getPhoto() {
    return this.photo;
  }
  
  public Team getTeam() {
    return TEAMS.get(this.teamId);
  }
  
}