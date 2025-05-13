import Foundation

class FavoritePresenter {
    
    private var repo: Repository!
    private var view: LeaguesView!
    
    init(repo: Repository!, view: LeaguesView!) {
        self.repo = repo
        self.view = view
    }
    
    func loadFavoriteLeagues() {
        print("favorite presenter started getting data")
        let leagues = repo.getFavoriteLeagues().map { $0.toView() }
        print("presenter got \(leagues.count) leagues from favorite")
        view.setLeagues(leagues: leagues)
    }
    
    func deleteLeague(league: LeagueView) {
        repo.deleteLeaugeFromFavorite(league: league)
    }
    
    
}
