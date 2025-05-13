import Foundation

struct LeagueView {
    let id: Int
    let name: String
    let logoUrl: String
    let sportId: String
}


extension LeagueDTO {
    func toView() -> LeagueView {
        return LeagueView(id: self.leagueKey, name: self.leagueName, logoUrl: self.leagueLogo ?? "NONE", sportId: "football")
    }
    
    func toView(sportId: String) -> LeagueView {
        return LeagueView(id: self.leagueKey, name: self.leagueName, logoUrl: self.leagueLogo ?? "NONE", sportId: sportId)
    }
}
