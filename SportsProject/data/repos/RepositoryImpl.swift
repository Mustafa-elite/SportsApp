import Foundation

class RepositoryImpl: Repository {


    private var remoteDataSource: RemoteDataSource!
    private var localDataSource: LocalDataSource!
    
    init(remoteDataSource: RemoteDataSource!, localDataSource: LocalDataSource!) {
        self.remoteDataSource = remoteDataSource
        self.localDataSource = localDataSource
    }
    
    func getLeaguesBySport(sport: Sports, onSuccess: @escaping ([LeagueDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        
        remoteDataSource.getLeaguesBySport(sport: sport, onSuccess: onSuccess, onFailure: onFailure)

    }
   
    func getLeagueEvents(sport: Sports, leagueId: Int, from: Date, to: Date, onSuccess: @escaping ([EventDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        remoteDataSource.getLeagueEvents(sport: sport, leagueId: leagueId, from: from, to: to, onSuccess: onSuccess, onFailure: onFailure)
    }

    func getTeamsByLeagueId(sport: Sports, leagueId: Int, onSuccess: @escaping ([TeamDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        
        
        remoteDataSource.getTeamsByLeagueId(sport: sport, leagueId: leagueId, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getTeamById(sport: Sports,leagueId:Int, teamId: Int, onSuccess: @escaping ([TeamDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        
        
        remoteDataSource.getTeamById(sport: sport ,leagueId: leagueId, teamId: teamId, onSuccess: onSuccess, onFailure:onFailure)
    }
    
    
    
    func getFavoriteLeagues() -> [LeagueEntity] {
        return localDataSource.getAllLeagues()
    }
    
    func addLeagueToFavorite(league: LeagueView) {
        localDataSource.insertLeague(league: league)
    }
    
    func deleteLeaugeFromFavorite(league: LeagueView) {
        localDataSource.deleteLeauge(league: league)
    }
    
    
    
    
}
