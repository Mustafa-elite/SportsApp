import Foundation

class RepositoryImpl: Repository {

    
    private let remote: RemoteDataSource
       
    init(remote: RemoteDataSource) {
       self.remote = remote
    }
   
    func getLeaguesBySport(sport: Sports, onSuccess: @escaping ([LeagueDTO]) -> Void, onFailure: @escaping (String) -> Void) {
    }
   
    func getLeagueEvents(sport: Sports, leagueId: Int, from: Date, to: Date, onSuccess: @escaping ([EventDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        remote.getLeagueEvents(sport: sport, leagueId: leagueId, from: from, to: to, onSuccess: onSuccess, onFailure: onFailure)
    }

    func getTeamsByLeagueId(sport: Sports, leagueId: Int, onSuccess: @escaping ([TeamDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        
        
        remote.getTeamsByLeagueId(sport: sport, leagueId: leagueId, onSuccess: onSuccess, onFailure: onFailure)
    }
    
    func getTeamById(sport: Sports,leagueId:Int, teamId: Int, onSuccess: @escaping ([TeamDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        
        
        remote.getTeamById(sport: sport ,leagueId: leagueId, teamId: teamId, onSuccess: onSuccess, onFailure:onFailure)
    }
    
    
}
