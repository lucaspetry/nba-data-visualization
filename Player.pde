public class Player {
  
  private final static String playerPrefix = "images/players/";
  private final static String playerSufix = ".png";
  private int id;
  private String firstName;
  private String lastName;
  private int jerseyNumber;
  private String position;
  private PImage photo;
  
  public Player(int id, String firstName, String lastName,
                int jerseyNumber, String position) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.jerseyNumber = jerseyNumber;
    this.position = position;
    this.photo = loadImage(playerPrefix + this.id + playerSufix);
  }
  
  public int getId() {
    return this.id;
  }
  
  public String getFullName() {
    return this.firstName + " " + this.lastName;
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
  
}