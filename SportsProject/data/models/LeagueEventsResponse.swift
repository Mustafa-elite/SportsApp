// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let leagueEventsResponse = try? JSONDecoder().decode(LeagueEventsResponse.self, from: jsonData)

import Foundation

// MARK: - LeagueEventsResponse
struct LeagueEventsResponse: Codable {
    let success: Int
    let result: [EventDTO]
}

// MARK: - Result
struct EventDTO: Codable {
    let eventKey: Int?
    let eventDate: String?
    let eventDateStart: String?
    let eventDateStop: String?
    let eventTime: String?
    let eventFirstPlayer: String?
    let firstPlayerKey: Int?
    let eventSecondPlayer: String?
    let secondPlayerKey: Int?
    let eventFirstPlayerLogo: String?
    let eventSecondPlayerLogo: String?
    
    let eventHomeTeam: String?
    let homeTeamKey: Int?
    let eventAwayTeam: String?
    let awayTeamKey: Int?
    let homeTeamLogo: String?
    let awayTeamLogo: String?

    let eventFinalResult: String?
    let eventStatus: String?
    
    // Coding keys
    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventDateStart = "event_date_start"
        case eventDateStop = "event_date_stop"
        case eventTime = "event_time"
        case eventFirstPlayer = "event_first_player"
        case firstPlayerKey = "first_player_key"
        case eventSecondPlayer = "event_second_player"
        case secondPlayerKey = "second_player_key"
        case eventFirstPlayerLogo = "event_first_player_logo"
        case eventSecondPlayerLogo = "event_second_player_logo"
        
   
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case homeTeamLogo = "home_team_logo"
        case awayTeamLogo = "away_team_logo"
        case eventFinalResult = "event_final_result"
        case eventStatus = "event_status"
    }
}
