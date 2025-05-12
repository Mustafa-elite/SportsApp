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
//            let viewLeagues = leagues.filter { league in
//                league.leagueLogo != nil || league.leagueLogo?.count ?? 0 > 0
//            }.map { league in
//                return league.toView()
//            }
            let viewLeagues = leagues.map { $0.toView() }
            self.view.setLeagues(leagues: viewLeagues)
            
        } onFailure: { errorMsg in
            self.view.setError(errorMsg: errorMsg)
        }

        
    }
    
    
    
}
