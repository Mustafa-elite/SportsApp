//
//  LeagueDetailsPresenterImpl.swift
//  SportsProject
//
//  Created by JETS Mobile Lab on 11/05/2025.
//

import Foundation

class LeagueDetailsPresenterImpl: LeagueDetailsPresenter {

    weak var view: LeagueDetailsView?
    let repo: Repository
    let sport: Sports
    let leagueId: Int

    init(view: LeagueDetailsView, repo: Repository, sport: Sports, leagueId: Int) {
        self.view = view
        self.repo = repo
        self.sport = sport
        self.leagueId = leagueId
    }

    func viewDidLoad() {
        let now = Date()
        let calendar = Calendar.current

        let fourteenDaysAgo = calendar.date(byAdding: .day, value: -14, to: now) ?? now
        
        repo.getLeagueEvents(sport: sport, leagueId: leagueId, from: fourteenDaysAgo, to: now, onSuccess: { [weak self] events in
            DispatchQueue.main.async {
                self?.view?.displayLatestEvents(events)
            }
        }, onFailure: { error in
            print("Failed to fetch latest events: \(error)")
        })

        let fourteenDaysLater = calendar.date(byAdding: .day, value: 14, to: now) ?? now
        repo.getLeagueEvents(sport: sport, leagueId: leagueId, from: now, to: fourteenDaysLater, onSuccess: { [weak self] events in
            DispatchQueue.main.async {
                self?.view?.displayUpcomingEvents(events)
            }
        }, onFailure: { error in
            print("Failed to fetch upcoming events: \(error)")
        })

        repo.getTeamsByLeagueId(sport: sport, leagueId: leagueId, onSuccess: { [weak self] teams in
            DispatchQueue.main.async {
                self?.view?.displayTeams(teams)
            }
        }, onFailure: { error in
            print("Failed to fetch teams: \(error)")
        })
    }

}

