//
//  LeagueDetailsView.swift
//  SportsProject
//
//  Created by JETS Mobile Lab on 11/05/2025.
//

protocol LeagueDetailsView: AnyObject {
    func showLoading()
    func hideLoading()
    func showError(_ message: String)
    func displayUpcomingEvents(_ events: [EventDTO])
    func displayLatestEvents(_ events: [EventDTO])
    func displayTeams(_ teams: [TeamDTO])
}
