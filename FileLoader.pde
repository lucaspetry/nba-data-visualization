import java.io.File;

public class FileLoader {
  
  private String playersFile;
  private String teamsFile;
  private String gamesFile;

  public FileLoader() {
    this.playersFile = "data/players.csv";
    this.teamsFile = "data/team.csv";
    this.gamesFile = "data2/games.csv";
  }
  
  public boolean isPlayerInEvent(int gameId, int eventNumber, int playerId) {
    Table tableFrames = loadTable("data/games/00" + gameId + "/" + eventNumber + ".csv");
    return tableFrames.matchRow("^" + playerId + "$", 2) != null;
  }
  
  public float getDistanceTraveled(int gameId, int eventNumber, int playerId) {
    Table tableFrames = loadTable("data/games/00" + gameId + "/" + eventNumber + ".csv");
    
    float distance = 0;
    int moment = -1;
    float x = tableFrames.matchRow("^" + playerId + "$", 2).getFloat(3);
    float y = tableFrames.matchRow("^" + playerId + "$", 2).getFloat(4);
    
    for(TableRow r : tableFrames.matchRows("^" + playerId + "$", 2)) {
      if(r.getInt(6) == moment+1) {
        distance += dist(x, y, r.getFloat(3), r.getFloat(4));
      }
        
      moment = r.getInt(6);
      x = r.getFloat(3);
      y = r.getFloat(4);
    }
    
    return distance;
  }
  
  public float[][] getAverageSpeed(int gameId, int playerId) {
    File file = new File(sketchPath("data" + File.separator + "games" + File.separator + "00" + gameId));
    String[] files = file.list();
    int[] events = new int[files.length];
    int q = 0;
    for(String f : files)
      events[q++] = Integer.parseInt(f.substring(0, f.length()-4));
      
    events = sort(events);
    float[][] speed = new float[2][files.length/9+1];
    int idx = 0;
    int i = 0;
    
    for(int event : events) {
      if(i % 9 == 0) {
        Table tableFrames = loadTable("data/games/00" + gameId + "/" + event + ".csv");
        if(tableFrames.matchRow("^" + playerId + "$", 2) != null) {
          float initClock = tableFrames.getRow(0).getFloat(7);
          float finalClock = tableFrames.getRow(tableFrames.getRowCount()-1).getFloat(7);
          float distance = this.getDistanceTraveled(gameId, event, playerId);
          speed[0][idx] = 720 - tableFrames.getRow(0).getFloat(7) + (tableFrames.getRow(0).getInt(9)-1)*720;
          speed[1][idx] = distance/(initClock-finalClock);
        } else {
          speed[0][idx] = 720 - tableFrames.getRow(0).getFloat(7) + (tableFrames.getRow(0).getInt(9)-1)*720;
          speed[1][idx] = 0;
        }
        idx++;
      }
      i++;
    }
    return speed;
  }
  
  public float getAverageSpeed(int gameId, int eventNumber, int playerId) {
    Table tableFrames = loadTable("data/games/00" + gameId + "/" + eventNumber + ".csv");
    float initClock = tableFrames.getRow(0).getFloat(7);
    float finalClock = tableFrames.getRow(tableFrames.getRowCount()-1).getFloat(7);
    float distance = this.getDistanceTraveled(gameId, eventNumber, playerId);
    
    return distance/(initClock-finalClock);
  }
  
  public int[] getGamesWinsLosses(int teamId) {
    int[] gwl = new int[] {0, 0, 0};
    for(int gameId : GAMES.keySet()) {
      Game g = GAMES.get(gameId);
      if(g.getHomeTeam().getId() == teamId ||
          g.getVisitorTeam().getId() == teamId) {
        gwl[0]++;
        
        if(g.getWinner().getId() == teamId)
          gwl[1]++;
        else if(g.getWinner() != null)
          gwl[2]++;
      }
    }
    return gwl;
  }
  
  public boolean gameEventExists(int gameId, int eventNumber) {
    File file = new File(sketchPath("data" + File.separator + "games" + File.separator + "00" + gameId + File.separator + eventNumber + ".csv"));
    return file.exists();
  }
  
  public ArrayList<GameEvent> loadGameEvents(int gameId) {
    JSONObject json = loadJSONObject("data2/playbyplay/00" + gameId + ".json");
    JSONArray rowSet = json.getJSONArray("resultSets")
                          .getJSONObject(0).getJSONArray("rowSet");
                          
    ArrayList<GameEvent> events = new ArrayList<GameEvent>(rowSet.size());
    
    for(int i = 0; i < rowSet.size(); i++) {
      JSONArray r = rowSet.getJSONArray(i);
      
      String homeDescription = "";
      String visitorDescription = "";
      String score = "";
      
      if(!r.isNull(7))
        homeDescription = r.getString(7);
      if(!r.isNull(9))
        visitorDescription = r.getString(9);
      if(!r.isNull(10))
        score = r.getString(10);
      
      events.add(new GameEvent(gameId, r.getInt(1), r.getInt(4), r.getString(6), score,
                    homeDescription, visitorDescription));
    }
    
    return events;
  }
  
  public ArrayList<GameEventFrame> loadGameEventFrames(int gameId, int eventNumber) {
    Table tableFrames = loadTable("data/games/00" + gameId + "/" + eventNumber + ".csv");
    int tableSize = tableFrames.getRowCount();
    ArrayList<GameEventFrame> events = new ArrayList<GameEventFrame>(tableSize/10);
    
    float gameClock = -1;
    float shotClock = -1;
    int homeTeam = GAMES.get(gameId).getHomeTeam().getId();
    int visitorTeam = GAMES.get(gameId).getVisitorTeam().getId();
    PlayerPosition[] homePlayers = new PlayerPosition[5];
    PlayerPosition[] visitorPlayers = new PlayerPosition[5];
        
    for(int i = 0; i < tableSize; i++) {
      TableRow firstRow = tableFrames.getRow(i);
      
      int moment = firstRow.getInt(6);
      gameClock = firstRow.getFloat(7);
      shotClock = firstRow.getFloat(8);
      float[] ball = new float[]{0, 0, 0};
      int homeIdx = 0;
      int visitorIdx = 0;
          
      for(; i < tableSize && tableFrames.getRow(i).getInt(6) == moment; i++) {
        TableRow r = tableFrames.getRow(i);
        int typeRow = r.getInt(1);
        if(typeRow == -1) {
          ball[0] = r.getFloat(3);
          ball[1] = r.getFloat(4);
          ball[2] = r.getFloat(5);
        } else if(typeRow == homeTeam) {
          homePlayers[homeIdx++] = new PlayerPosition(PLAYERS.get(r.getInt(2)), r.getFloat(3), r.getFloat(4));
        } else if(typeRow == visitorTeam) {
          visitorPlayers[visitorIdx++] = new PlayerPosition(PLAYERS.get(r.getInt(2)), r.getFloat(3), r.getFloat(4));
        }
      }
      i--;
      if(homeIdx > 0 && visitorIdx > 0) // Files aren't consistent!
        events.add(new GameEventFrame(moment, gameClock, shotClock, ball, homePlayers, visitorPlayers));
    }
    
    return events;
  }
  
  public void loadObjects() {
    this.loadPlayers();
    this.loadTeams();
    this.loadGames();
  }
  
  private void loadPlayers() {
    PLAYERS.clear();
    Table table = loadTable(playersFile, "header");
    
    for(TableRow r : table.rows()) {
      int id = r.getInt("playerid");
      PLAYERS.put(id, new Player(id, r.getInt("teamid"), r.getString("firstname"),
                  r.getString("lastname"), r.getInt("jerseynumber"),
                  r.getString("position")));
    }
  }
  
  private void loadTeams() {
    TEAMS.clear();
    Table tablePlayers = loadTable(playersFile, "header");
    Table tableTeams = loadTable(teamsFile, "header");
            
    for(TableRow r : tableTeams.rows()) {
      int id = r.getInt("teamid");
      ArrayList<Player> teamPlayers = new ArrayList<Player>();
      
      for (TableRow rPlayer : tablePlayers.matchRows(id + "", "teamid")) {
        teamPlayers.add(PLAYERS.get(rPlayer.getInt("playerid")));
      }
      
      Player[] playersArray = new Player[teamPlayers.size()];
      teamPlayers.toArray(playersArray);
      
      TEAMS.put(id, new Team(id, r.getString("name"),
                r.getString("abbreviation"), playersArray));
    }
  }
  
  private void loadGames() {
    GAMES.clear();
    Table tableGames = loadTable(gamesFile, "header");
            
    for(TableRow r : tableGames.rows()) {
      int id = r.getInt("gameid");
      String date = r.getString("gamedate");
      int homeTeam = r.getInt("hometeamid");
      int visitorTeam = r.getInt("visitorteamid");
      int homeScore = r.getInt("homescore");
      int visitorScore = r.getInt("visitorscore");
      
      GAMES.put(id, new Game(id, date,
                TEAMS.get(homeTeam), TEAMS.get(visitorTeam), homeScore, visitorScore));
    }
  }
    
}