public class FileLoader {
  
  private final static String gamesFile = "data/games.csv";
  private final static String playersFile = "data/players.csv";
  private final static String teamsFile = "data/team.csv";

  public FileLoader() {
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
      
      GAMES.put(id, new Game(id, date,
                TEAMS.get(homeTeam), TEAMS.get(visitorTeam)));
    }
  }
    
}