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
        
        
    }
    
    func getTeamsByLeagueId(sport: Sports, leagueId: Int, onSuccess: @escaping ([TeamDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        
        
    }
    
    func getTeamById(sport: Sports, teamId: Int, onSuccess: @escaping ([TeamDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        
        
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
