import Foundation

class RepositoryImpl: Repository {
    
    private var remoteDataSource: RemoteDataSource!
    init(remoteDataSource: RemoteDataSource!) {
        self.remoteDataSource = remoteDataSource
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
    
    
}
