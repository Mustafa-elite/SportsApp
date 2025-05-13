//
//  TeamDetailsPresenter.swift
//  SportsProject
//
//  Created by JETS Mobile Lab on 13/05/2025.
//
//
//  TeamDetailsPresenterImpl.swift
//  SportsProject
//
//  Created by Mustafa on 13/05/2025.
//

import Foundation

class TeamDetailsPresenterImpl: TeamDetailsPresenter {

    weak var view: TeamDetailsView?
    private let repo: Repository
    private let sport: Sports
    private let teamId: Int
    
    private let leagueId: Int

    init(view: TeamDetailsView, repo: Repository, sport: Sports, teamId: Int,leagueId:Int) {
        self.view = view
        self.repo = repo
        self.sport = sport
        self.teamId = teamId
        self.leagueId = leagueId
    }

    func viewDidLoad() {
        repo.getTeamById(sport: sport, leagueId: leagueId, teamId: teamId, onSuccess: { [weak self] teams in
            guard let team = teams.first else {
                print("No team found with ID \(self?.teamId ?? -1)")
                return
            }

            
            DispatchQueue.main.async {
                self?.view?.displayTeamDetails(team)
            }

        }, onFailure: { error in
            print("Failed to fetch team by ID: \(error)")
        })
    }
}
