//
//  TeamsResponse.swift
//  SportsProject
//
//  Created by Mustafa on 09/05/2025.
//
import Foundation

// MARK: - TeamResponse
struct TeamResponse: Codable {
    let success: Int
    let result: [TeamResult]
}

// MARK: - TeamResult
struct TeamResult: Codable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String
    let players: [Player]
    let coaches: [Coach]

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players, coaches
    }
}

// MARK: - Coach
struct Coach: Codable {
    let coachName: String
    let coachCountry, coachAge: JSONNull?

    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
        case coachCountry = "coach_country"
        case coachAge = "coach_age"
    }
}

// MARK: - Player
struct Player: Codable {
    let playerKey: Int
    let playerImage: String?
    let playerName, playerNumber: String
    let playerCountry: JSONNull?
    let playerType: PlayerType
    let playerAge, playerMatchPlayed, playerGoals, playerYellowCards: String
    let playerRedCards: String
    let playerInjured: PlayerInjured
    let playerSubstituteOut, playerSubstitutesOnBench, playerAssists: String
    let playerBirthdate: String?
    let playerIsCaptain, playerShotsTotal, playerGoalsConceded, playerFoulsCommitted: String
    let playerTackles, playerBlocks, playerCrossesTotal, playerInterceptions: String
    let playerClearances, playerDispossesed, playerSaves, playerInsideBoxSaves: String
    let playerDuelsTotal, playerDuelsWon, playerDribbleAttempts, playerDribbleSucc: String
    let playerPenComm, playerPenWon, playerPenScored, playerPenMissed: String
    let playerPasses, playerPassesAccuracy, playerKeyPasses, playerWoodworks: String
    let playerRating: String

    enum CodingKeys: String, CodingKey {
        case playerKey = "player_key"
        case playerImage = "player_image"
        case playerName = "player_name"
        case playerNumber = "player_number"
        case playerCountry = "player_country"
        case playerType = "player_type"
        case playerAge = "player_age"
        case playerMatchPlayed = "player_match_played"
        case playerGoals = "player_goals"
        case playerYellowCards = "player_yellow_cards"
        case playerRedCards = "player_red_cards"
        case playerInjured = "player_injured"
        case playerSubstituteOut = "player_substitute_out"
        case playerSubstitutesOnBench = "player_substitutes_on_bench"
        case playerAssists = "player_assists"
        case playerBirthdate = "player_birthdate"
        case playerIsCaptain = "player_is_captain"
        case playerShotsTotal = "player_shots_total"
        case playerGoalsConceded = "player_goals_conceded"
        case playerFoulsCommitted = "player_fouls_committed"
        case playerTackles = "player_tackles"
        case playerBlocks = "player_blocks"
        case playerCrossesTotal = "player_crosses_total"
        case playerInterceptions = "player_interceptions"
        case playerClearances = "player_clearances"
        case playerDispossesed = "player_dispossesed"
        case playerSaves = "player_saves"
        case playerInsideBoxSaves = "player_inside_box_saves"
        case playerDuelsTotal = "player_duels_total"
        case playerDuelsWon = "player_duels_won"
        case playerDribbleAttempts = "player_dribble_attempts"
        case playerDribbleSucc = "player_dribble_succ"
        case playerPenComm = "player_pen_comm"
        case playerPenWon = "player_pen_won"
        case playerPenScored = "player_pen_scored"
        case playerPenMissed = "player_pen_missed"
        case playerPasses = "player_passes"
        case playerPassesAccuracy = "player_passes_accuracy"
        case playerKeyPasses = "player_key_passes"
        case playerWoodworks = "player_woordworks"
        case playerRating = "player_rating"
    }
}

enum PlayerInjured: String, Codable {
    case no = "No"
}

enum PlayerType: String, Codable {
    case defenders = "Defenders"
    case forwards = "Forwards"
    case goalkeepers = "Goalkeepers"
    case midfielders = "Midfielders"
}

// MARK: - JSONNull Helper
class JSONNull: Codable, Hashable {
    static func == (lhs: JSONNull, rhs: JSONNull) -> Bool { true }
    func hash(into hasher: inout Hasher) { hasher.combine(0) }

    init() {}

    required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Expected null value"
            ))
        }
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
