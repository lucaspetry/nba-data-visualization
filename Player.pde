public class Player {
  
  private int id;
  private String firstName;
  private String lastName;
  private int jerseyNumber;
  private String position;
  
  public Player(int id, String firstName, String lastName,
                int jerseyNumber, String position) {
    this.id = id;
    this.firstName = firstName;
    this.lastName = lastName;
    this.jerseyNumber = jerseyNumber;
    this.position = position;
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
  
}