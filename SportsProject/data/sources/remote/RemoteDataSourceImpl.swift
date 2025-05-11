import Foundation

import Alamofire

class RemoteDataSourceImpl : RemoteDataSource {
    
    
    private var apiKey: String {
        return Bundle.main.infoDictionary?["API_KEY"] as? String ?? ""
    }
    
    func getLeagueEvents(sport: Sports, leagueId: Int, from: Date, to: Date, onSuccess: @escaping ([EventDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let fromDate = dateFormatter.string(from: from)
        let toDate = dateFormatter.string(from: to)
        
        let url = "https://apiv2.allsportsapi.com/\(sport.rawValue)/"
        let parameters: [String: Any] = [
            "met": "Fixtures",
            "leagueid": leagueId,
            "from": fromDate,
            "to": toDate,
            "APIkey": apiKey
        ]
        if let urlObject = URL(string: url),
           let fullURL = try? URLEncoding.default.encode(URLRequest(url: urlObject), with: parameters).url?.absoluteString {
            print("🔍 Requesting: \(fullURL)")
        }

        

        AF.request(url, parameters: parameters).responseDecodable(of: LeagueEventsResponse.self) { response in
            switch response.result {
            case .success(let response):
                onSuccess(response.result)
            case .failure(let error):
                print("failure in alamo")
                onFailure(error.localizedDescription)
            }
        }
    }
    
    func getTeamsByLeagueId(sport: Sports, leagueId: Int, onSuccess: @escaping ([TeamDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        
        let url = "https://apiv2.allsportsapi.com/\(sport.rawValue)/"
        let parameters: [String: Any] = [
            "met": "Teams",
            "leagueid": leagueId,
            "APIkey": apiKey
        ]
        
        
        if let urlObject = URL(string: url),
           let fullURL = try? URLEncoding.default.encode(URLRequest(url: urlObject), with: parameters).url?.absoluteString {
            print("🔍 Requesting: \(fullURL)")
        }
        AF.request(url, parameters: parameters).responseDecodable(of:
            TeamResponse.self) { response in
            switch response.result {
            case .success(let response):
                onSuccess(response.result)
            case .failure(let error):
                
                    print("failure in alamo")
                onFailure(error.localizedDescription)
            }
        }
    }
    func getTeamById(sport: Sports, teamId: Int, onSuccess: @escaping ([TeamDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        
    }
    
    func getLeaguesBySport(sport: Sports, onSuccess: @escaping ([LeagueDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        
    }
    
}
