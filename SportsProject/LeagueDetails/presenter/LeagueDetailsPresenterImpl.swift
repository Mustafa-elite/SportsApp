//
//  LeagueDetailsPresenterImpl.swift
//  SportsProject
//
//  Created by JETS Mobile Lab on 11/05/2025.
//

import Foundation

class LeagueDetailsPresenterImpl: LeagueDetailsPresenter {
    
    func addToFavorite() {
        self.repo.addLeagueToFavorite(league: self.leagueView)
    }

    weak var view: LeagueDetailsView?
    let repo: Repository
    let leagueView: LeagueView

    init(view: LeagueDetailsView, repo: Repository, leagueView: LeagueView) {
        self.view = view
        self.repo = repo
        self.leagueView = leagueView
    }

    func viewDidLoad() {
        let now = Date()
        let calendar = Calendar.current

        let fourteenDaysAgo = calendar.date(byAdding: .day, value: -14, to: now) ?? now
        
        let selectedSport = Sports(rawValue: leagueView.sportId) ?? Sports.FOOTBALL
        repo.getLeagueEvents(sport: selectedSport, leagueId: leagueView.id, from: fourteenDaysAgo, to: now, onSuccess: { [weak self] events in
            DispatchQueue.main.async {
                self?.view?.displayLatestEvents(events)
            }
        }, onFailure: { error in
            print("Failed to fetch latest events: \(error)")
        })

        let fourteenDaysLater = calendar.date(byAdding: .day, value: 14, to: now) ?? now
        repo.getLeagueEvents(sport: selectedSport, leagueId: leagueView.id, from: now, to: fourteenDaysLater, onSuccess: { [weak self] events in
            DispatchQueue.main.async {
                self?.view?.displayUpcomingEvents(events)
            }
        }, onFailure: { error in
            print("Failed to fetch upcoming events: \(error)")
        })

        repo.getTeamsByLeagueId(sport: selectedSport, leagueId: leagueView.id, onSuccess: { [weak self] teams in
            DispatchQueue.main.async {
                self?.view?.displayTeams(teams)
            }
        }, onFailure: { error in
            print("Failed to fetch teams: \(error)")
        })
    }
    
    func getLeagueView() -> LeagueView {
        return self.leagueView
    }
}

