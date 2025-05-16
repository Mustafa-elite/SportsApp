// MARK: - TeamResponse
struct TeamResponse: Codable {
    let success: Int
    let result: [TeamDTO]
}

// MARK: - TeamDTO (Minimal)
struct TeamDTO: Codable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String?
    let players: [Player]
    let coaches: [Coach]

    enum CodingKeys: String, CodingKey {
        case teamKey = "team_key"
        case teamName = "team_name"
        case teamLogo = "team_logo"
        case players, coaches
    }
}

// MARK: - Player (Minimal)
struct Player: Codable {
    let playerName: String?
    let playerImage: String?

    enum CodingKeys: String, CodingKey {
        case playerName = "player_name"
        case playerImage = "player_image"
    }
}

// MARK: - Coach (Minimal)
struct Coach: Codable {
    let coachName: String?

    enum CodingKeys: String, CodingKey {
        case coachName = "coach_name"
    }
}
