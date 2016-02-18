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
    return null;
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