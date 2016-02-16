import controlP5.*;

public interface Window {
  public void setup();
  public void draw();
  public void mouseEvent(int eventType, int x, int y);
  public void event(ControlEvent event);
  public void clearControls();
}