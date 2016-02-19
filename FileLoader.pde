public class FileLoader {
  
  private String playersFile;
  private String teamsFile;
  private String gamesFile;

  public FileLoader() {
    this.playersFile = "data/players.csv";
    this.teamsFile = "data/team.csv";
    this.gamesFile = "data2/games.csv";
  }
  
  public ArrayList<GameEvent> loadGameEvents(int gameId) {
    JSONObject json = loadJSONObject("data2/playbyplay/00" + gameId + ".json");
    JSONArray rowSet = json.getJSONArray("resultSets")
                          .getJSONObject(0).getJSONArray("rowSet");
                          
    ArrayList<GameEvent> events = new ArrayList<GameEvent>(rowSet.size());
    
    for(int i = 0; i < rowSet.size(); i++) {
      JSONArray r = rowSet.getJSONArray(i);
      
      String homeDescription = "";
      String neutralDescription = "";
      String visitorDescription = "";
      String score = "";
      
      if(!r.isNull(7))
        homeDescription = r.getString(7);
      if(!r.isNull(8))
        neutralDescription = r.getString(8);
      if(!r.isNull(9))
        visitorDescription = r.getString(9);
      if(!r.isNull(10))
        score = r.getString(10);
      
      events.add(new GameEvent(gameId, r.getInt(1), r.getInt(4), r.getString(6), score,
                    homeDescription, neutralDescription, visitorDescription));
    }
    
    return events;
  }
  
  public ArrayList<GameEventFrame> loadGameEventFrames(int gameId, int eventNumber) {
    Table tableFrames = loadTable("data/games/00" + gameId + "/" + eventNumber + ".csv");
    ArrayList<GameEventFrame> events = new ArrayList<GameEventFrame>(tableFrames.getRowCount()/10);
    
    float gameClock = -1;
    float shotClock = -1;
    int homeTeam = GAMES.get(gameId).getHomeTeam().getId();
    PlayerPosition[] homePlayers = new PlayerPosition[5];
    PlayerPosition[] visitorPlayers = new PlayerPosition[5];
        
    for(int i = 0; tableFrames.matchRow("^" + i + "$", 6) != null; i++) {
      TableRow firstRow = tableFrames.matchRow("^" + i + "$", 6);
      
      gameClock = firstRow.getFloat(7);
      shotClock = firstRow.getFloat(8);
      float[] ball = new float[]{0, 0, 0};
      int homeIdx = 0;
      int visitorIdx = 0;
          
      for(TableRow r : tableFrames.matchRows("^" + i + "$", 6)) {
        int typeRow = r.getInt(1);
        if(typeRow == -1) {
          ball[0] = r.getFloat(3);
          ball[1] = r.getFloat(4);
          ball[2] = r.getFloat(5);
        } else if(typeRow == homeTeam) {
          homePlayers[homeIdx++] = new PlayerPosition(PLAYERS.get(r.getInt(2)), r.getFloat(3), r.getFloat(4));
        } else {
          visitorPlayers[visitorIdx++] = new PlayerPosition(PLAYERS.get(r.getInt(2)), r.getFloat(3), r.getFloat(4));
        }
      }
      events.add(new GameEventFrame(i, gameClock, shotClock, ball, homePlayers, visitorPlayers));
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
      PLAYERS.put(id, new Player(id, r.getString("firstname"),
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