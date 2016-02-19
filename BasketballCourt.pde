public class BasketballCourt {
  
  private final static float nbaLength = 94;
  private final static float nbaWidth = 50;
  private final static float camHeight = 25.45932;
  private final static int numPartsCircle = 100;
  
  private int x;
  private int y;
  
  private float ratio;
  private float courtLength;
  private float courtWidth;
  private float centreCircleDiam;
  
  private float laneLength;
  private float laneInnerWidth;
  private float laneOutterWidth;
  
  private float threePtRectLength;
  private float threePtRectWidth;
  private float threePtArcWidth;
  
  private float basketDiam;
  private float basketArc;
  private float backboardWidth;
  private float backboardOffX;
  
  private float playerDiam;
  private float ballDiam;
  
  private PImage floorTexture;
  private PImage floorTexture2;
  private PImage floorTexture3;
  
  private PlayerPosition[] homeTeam;
  private PlayerPosition[] visitingTeam;
  
  BasketballCourt() {
    float ratio = 400 / nbaLength;
    init(ratio);
  }
  
  BasketballCourt(float ratio) {
    init(ratio);
  }
  
  BasketballCourt(float cLength, float cWidth) {
    init(min(cLength/nbaLength, cWidth/nbaWidth));
  }
  
  private void init(float ratio) {
    this.x = (int) modelX(0, 0, 0);
    this.y = (int) modelY(0, 0, 0);
    this.ratio = ratio;
    courtLength = nbaLength * ratio;
    courtWidth = nbaWidth * ratio;
    centreCircleDiam = 12 * ratio;
    
    laneLength = 19 * ratio;
    laneInnerWidth = 12 * ratio;
    laneOutterWidth = 16 * ratio;
    
    threePtRectLength = 14 * ratio;
    threePtRectWidth = 44 * ratio;
    threePtArcWidth = 23.75 * ratio;
    
    basketDiam = 1.5 * ratio;
    basketArc = 4 * ratio;
    backboardWidth = 6 * ratio;
    backboardOffX = 4 * ratio;
    
    playerDiam = 2.5*ratio;
    ballDiam = playerDiam*0.6;
  }
  
  public void setup() {
    this.floorTexture = loadImage("images/floor-texture.jpg");
    this.floorTexture2 = loadImage("images/floor-texture2.jpg");
    this.floorTexture3 = loadImage("images/floor-texture3.jpg");
  }
    
  public void draw() {
    this.x = (int) modelX(0, 0, 0);
    this.y = (int) modelY(0, 0, 0);
    stroke(255);
    strokeWeight(3);
    
    beginShape(); // Court
    texture(this.floorTexture);
    textureWrap(REPEAT);
    vertex(0, 0, 0, 0);
    vertex(courtLength, 0, courtLength, 0);
    vertex(courtLength, courtWidth, courtLength, courtWidth);
    vertex(0, courtWidth, 0, courtWidth);
    vertex(0, 0, 0, 0);
    endShape();
    
    line (courtLength/2, 0, courtLength/2, courtWidth); // Division line
    
    float theta = TWO_PI / numPartsCircle;
    
    beginShape(); // Centre outter circle
    texture(this.floorTexture2);
    textureWrap(REPEAT);
    for (int i=0; i<numPartsCircle; i++) {
      float angle = theta * i;
      float x = cos(angle);
      float y = sin(angle);
      vertex(courtLength/2 + x * centreCircleDiam/2,
      courtWidth/2 + y * centreCircleDiam/2, courtLength/2 + x * centreCircleDiam/2,
      courtWidth/2 + y * centreCircleDiam/2);
    }
    endShape();
    
    beginShape(); // Centre inner circle
    texture(this.floorTexture3);
    textureWrap(REPEAT);
    for (int i=0; i<numPartsCircle; i++) {
      float angle = theta * i;
      float x = cos(angle);
      float y = sin(angle);
      vertex(courtLength/2 + x * centreCircleDiam/6,
      courtWidth/2 + y * centreCircleDiam/6, courtLength/2 + x * centreCircleDiam/6,
      courtWidth/2 + y * centreCircleDiam/6);
    }
    endShape();
    
    // Left side
    noFill();
    line(0, courtWidth/2-threePtRectWidth/2,
          threePtRectLength, courtWidth/2-threePtRectWidth/2); // Three point line 1
    line(0, courtWidth/2-threePtRectWidth/2+threePtRectWidth,
          threePtRectLength, courtWidth/2-threePtRectWidth/2+threePtRectWidth); // Three point line 2
    arc(backboardOffX+basketDiam/2, courtWidth/2, // Three point arc
        threePtArcWidth*2, threePtRectWidth * 1.084, radians(-67), radians(67));
    
    ellipse(laneLength, courtWidth/2, laneInnerWidth, laneInnerWidth); // Free throw circle
    
    beginShape(); // Outter lane
    texture(this.floorTexture2);
    textureWrap(REPEAT);
    vertex(0, courtWidth/2-laneOutterWidth/2, 0, courtWidth/2-laneOutterWidth/2);
    vertex(laneLength, courtWidth/2-laneOutterWidth/2, laneLength, courtWidth/2-laneOutterWidth/2);
    vertex(laneLength, courtWidth/2+laneOutterWidth/2, laneLength, courtWidth/2+laneOutterWidth/2);
    vertex(0, courtWidth/2+laneOutterWidth/2, 0, courtWidth/2+laneOutterWidth/2);
    vertex(0, courtWidth/2-laneOutterWidth/2, 0, courtWidth/2-laneOutterWidth/2);
    endShape();
    
    beginShape(); // Inner lane
    texture(this.floorTexture3);
    textureWrap(REPEAT);
    vertex(0, courtWidth/2-laneInnerWidth/2, 0, courtWidth/2-laneInnerWidth/2);
    vertex(laneLength, courtWidth/2-laneInnerWidth/2, laneLength, courtWidth/2-laneInnerWidth/2);
    vertex(laneLength, courtWidth/2+laneInnerWidth/2, laneLength, courtWidth/2+laneInnerWidth/2);
    vertex(0, courtWidth/2+laneInnerWidth/2, 0, courtWidth/2+laneInnerWidth/2);
    vertex(0, courtWidth/2-laneInnerWidth/2, 0, courtWidth/2-laneInnerWidth/2);
    endShape();
        
    line(backboardOffX, courtWidth/2-backboardWidth/2,
          backboardOffX, courtWidth/2+backboardWidth/2); // Backboard
    arc(backboardOffX+basketDiam/2, courtWidth/2, // Basket arc
        basketArc*2, basketArc*2, radians(-90), radians(90));
    ellipse(backboardOffX+basketDiam/2, courtWidth/2, basketDiam, basketDiam); // Basket
    
    // Right side
    line(courtLength-threePtRectLength, courtWidth/2-threePtRectWidth/2,
          courtLength, courtWidth/2-threePtRectWidth/2); // Three point line 1
    line(courtLength-threePtRectLength, courtWidth/2+threePtRectWidth/2,
          courtLength, courtWidth/2+threePtRectWidth/2); // Three point line 2
    arc(courtLength-backboardOffX-basketDiam/2, courtWidth/2, // Three point arc
        threePtArcWidth*2, threePtRectWidth * 1.084, radians(113), radians(247));
        
    ellipse(courtLength-laneLength, courtWidth-courtWidth/2, 
            laneInnerWidth, laneInnerWidth); // Free throw circle
            
    beginShape(); // Outter lane
    texture(this.floorTexture2);
    textureWrap(REPEAT);
    vertex(courtLength-laneLength, courtWidth/2-laneOutterWidth/2,
            courtLength-laneLength, courtWidth/2-laneOutterWidth/2);
    vertex(courtLength, courtWidth/2-laneOutterWidth/2,
            courtLength, courtWidth/2-laneOutterWidth/2);
    vertex(courtLength, courtWidth/2+laneOutterWidth/2,
            courtLength, courtWidth/2+laneOutterWidth/2);
    vertex(courtLength-laneLength, courtWidth/2+laneOutterWidth/2,
            courtLength-laneLength, courtWidth/2+laneOutterWidth/2);
    vertex(courtLength-laneLength, courtWidth/2-laneOutterWidth/2,
            courtLength-laneLength, courtWidth/2-laneOutterWidth/2);
    endShape();
        
    beginShape(); // Inner lane
    texture(this.floorTexture3);
    textureWrap(REPEAT);
    vertex(courtLength-laneLength, courtWidth/2-laneInnerWidth/2,
            courtLength-laneLength, courtWidth/2-laneInnerWidth/2);
    vertex(courtLength, courtWidth/2-laneInnerWidth/2,
            courtLength, courtWidth/2-laneInnerWidth/2);
    vertex(courtLength, courtWidth/2+laneInnerWidth/2,
            courtLength, courtWidth/2+laneInnerWidth/2);
    vertex(courtLength-laneLength, courtWidth/2+laneInnerWidth/2,
            courtLength-laneLength, courtWidth/2+laneInnerWidth/2);
    vertex(courtLength-laneLength, courtWidth/2-laneInnerWidth/2,
            courtLength-laneLength, courtWidth/2-laneInnerWidth/2);
    endShape();
    
    line(courtLength-backboardOffX, courtWidth/2-backboardWidth/2,
          courtLength-backboardOffX, courtWidth/2+backboardWidth/2); // Backboard
    arc(courtLength-backboardOffX-basketDiam/2, courtWidth/2, // Basket arc
        basketArc*2, basketArc*2, radians(90), radians(270));
    ellipse(courtLength-backboardOffX-basketDiam/2, courtWidth/2, basketDiam, basketDiam); // Basket
  }
  
  public boolean mouseOver(PlayerPosition p) {
    if(dist(mouseX, mouseY, x+p.getX()*ratio, y+p.getY()*ratio) < playerDiam*0.5)
      return true;
    return false;
  }
  
  public void mouseEvent(int eventType) {
    if(eventType == MOUSE_CLICKED) {
      for(PlayerPosition p : homeTeam) {
        if(dist(mouseX, mouseY, x+p.getX()*ratio, y+p.getY()*ratio) < playerDiam*0.5)
          SWITCH_WINDOW(new PlayerWindow(CURRENT_WINDOW, p.getPlayer()));
      }
      
      for(PlayerPosition p : visitingTeam) {
        if(dist(mouseX, mouseY, x+p.getX()*ratio, y+p.getY()*ratio) < playerDiam*0.5)
          SWITCH_WINDOW(new PlayerWindow(CURRENT_WINDOW, p.getPlayer()));
      }
    }
  }
  
  private void drawPlayersAndBall(PlayerPosition[] homeTeam, PlayerPosition[] visitingTeam, float[] ball) {
    this.homeTeam = homeTeam;
    this.visitingTeam = visitingTeam;
    noStroke();
    
    float newBallDiam = camHeight/(camHeight-ball[2])*ballDiam;
    
    // Ball
    fill(212*ball[2]*0.6, 113*ball[2]*0.6, 15*ball[2]*0.6);
    ellipse(ball[0]*ratio, ball[1]*ratio, newBallDiam, newBallDiam);   
    
    // Home team
    for(PlayerPosition p : this.homeTeam) {
      if(!this.mouseOver(p))
        fill(255, 0, 0);
      else
        fill(0, 0, 0);
      ellipse(p.getX()*ratio, p.getY()*ratio, playerDiam, playerDiam);
      
      fill(255);
      textFont(FONT_12);
      textAlign(CENTER);
      text(p.getPlayer().getJerseyNumber(), p.getX()*ratio, (p.getY()+0.35)*ratio);
    }
    
    // Visiting teams
    for(PlayerPosition p : this.visitingTeam) {
      if(!this.mouseOver(p))
        fill(13, 128, 66);
      else
        fill(0, 0, 0);
      ellipse(p.getX()*ratio, p.getY()*ratio, playerDiam, playerDiam);
      
      fill(255);
      textFont(FONT_12);
      textAlign(CENTER);
      text(p.getPlayer().getJerseyNumber(), p.getX()*ratio, (p.getY()+0.35)*ratio);
    }
  }
  
}