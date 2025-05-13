import Foundation

protocol Repository {
    
    func getLeaguesBySport(
        sport: Sports,
        onSuccess: @escaping ([LeagueDTO]) -> Void,
        onFailure: @escaping (String) -> Void
    )
    
    func getLeagueEvents(
        sport: Sports,
        leagueId: Int,
        from: Date,
        to: Date,
        onSuccess: @escaping ([EventDTO]) -> Void,
        onFailure: @escaping (String) -> Void
    )
    
    func getTeamsByLeagueId(
        sport: Sports,
        leagueId: Int,
        onSuccess: @escaping ([TeamDTO]) -> Void,
        onFailure: @escaping (String) -> Void
    )
    
    func getTeamById(
        sport: Sports ,
        leagueId:Int,
        teamId: Int,
        onSuccess: @escaping ([TeamDTO]) -> Void,
        onFailure: @escaping (String) -> Void
    )
    
    // local data source related functions
//    func getFavoriteLeagues() -> [LeagueEntity]
//    func addLeagueToFavorite(league: LeagueEntity)
//    func deleteLeaugeFromFavorite(league: LeagueEntity)
    
}
