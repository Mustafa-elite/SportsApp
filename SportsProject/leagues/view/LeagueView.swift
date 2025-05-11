import Foundation

struct LeagueView {
    let id: Int
    let name: String
    let logoUrl: String
}


extension LeagueDTO {
    func toView() -> LeagueView {
        return LeagueView(id: self.leagueKey, name: self.leagueName, logoUrl: self.leagueLogo ?? "NONE")
    }
}
