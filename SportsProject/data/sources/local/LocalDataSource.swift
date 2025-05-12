//
//  LocalDataSource.swift
//  SportsProject
//
//  Created by Macos on 09/05/2025.
//

import Foundation

protocol LocalDataSource {

    func getAllLeagues() -> [LeagueEntity]
    func insertLeague(league: LeagueView)
    func deleteLeauge(league: LeagueView)
    
}

extension LeagueEntity {
    func toView() -> LeagueView {
        let id = Int(self.leaugeId ?? "0") ?? 0
        let name = self.leagueName ?? "NONE"
        let url = self.leagueImageUrl ?? "NONE"
        let sportsId = self.sportId ?? "NONE"
        
        return LeagueView(id: id, name: name, logoUrl: url, sportId: sportsId)
    }
}
