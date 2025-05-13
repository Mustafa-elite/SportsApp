import Foundation

class LeaguesPresetner {
    private var view: LeaguesView!
    private var repo: Repository!
    
    init(view: LeaguesView!, repo: Repository!) {
        self.view = view
        self.repo = repo
    }
    
    
    func loadLeaguesBySport(sport: Sports) {
        print("presenter has started loading")
        repo.getLeaguesBySport(sport: sport) { leagues in
            let viewLeagues = leagues.map { $0.toView(sportId: sport.rawValue) }
            self.view.setLeagues(leagues: viewLeagues)
            
        } onFailure: { errorMsg in
            self.view.setError(errorMsg: errorMsg)
        }

        
    }
    
//    func addToFavorite(league: LeagueView) {
//        print("adding \(league.name) to favorite")
//        self.repo.addLeagueToFavorite(league: league)
//        print("added \(league.name)to favorite")
//    }
    
    
    
}
