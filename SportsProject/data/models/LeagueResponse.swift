//
//  LeagueResponse.swift
//  SportsProject
//
//  Created by Mustafa on 09/05/2025.
//

import Foundation

// MARK: - LeagueResponse
struct LeagueResponse: Codable {
    let success: Int
    let result: [LeagueDTO]
}

// MARK: - LeagueResult
struct LeagueDTO: Codable {
    let leagueKey: Int
    let leagueName: String
    let countryKey: Int
    let countryName: String
    let leagueLogo, countryLogo: String

    enum CodingKeys: String, CodingKey {
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
    }
}
