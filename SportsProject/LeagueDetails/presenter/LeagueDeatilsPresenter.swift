//
//  LeagueDeatilsPresenter.swift
//  SportsProject
//
//  Created by JETS Mobile Lab on 11/05/2025.
//


protocol LeagueDetailsPresenter {
    func viewDidLoad()
    func getLeagueView() -> LeagueView
    func addToFavorite()
}
