public class PlayerPosition {
  
  private Player player;
  private float x;
  private float y;
  
  public PlayerPosition(Player player, float x, float y) {
    this.player = player;
    this.x = x;
    this.y = y;
  }
  
  public Player getPlayer() {
    return this.player;
  }
  
  public float getX() {
    return this.x;
  }
  
  public float getY() {
    return this.y;
  }
  
}