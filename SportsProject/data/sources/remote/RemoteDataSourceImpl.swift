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
        var parameters: [String: Any]?
        
        if sport == .FOOTBALL {
            parameters =  [
                "met": "Fixtures",
                "leagueId": leagueId,
                "from": fromDate,
                "to": toDate,
                "APIkey": apiKey
            ]
        } else {
            parameters =  [
                "met": "Fixtures",
                "leagueid": leagueId,
                "from": fromDate,
                "to": toDate,
                "APIkey": apiKey
            ]
        }
        
        if let urlObject = URL(string: url),
           let fullURL = try? URLEncoding.default.encode(URLRequest(url: urlObject), with: parameters).url?.absoluteString {
            print(" Requesting: \(fullURL)")
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
            "leagueId": leagueId,
            "APIkey": apiKey
        ]
        
        
        if let urlObject = URL(string: url),
           let fullURL = try? URLEncoding.default.encode(URLRequest(url: urlObject), with: parameters).url?.absoluteString {
            print(" Requesting: \(fullURL)")
        }
//        AF.request(url, parameters: parameters).responseDecodable(of:
//            TeamResponse.self) { response in
//            switch response.result {
//            case .success(let response):
//                onSuccess(response.result)
//            case .failure(let error):
//
//                    print("failure in alamo")
//                onFailure(error.localizedDescription)
//            }
//        }
        AF.request(url, parameters: parameters).responseData { response in
            switch response.result {
            case .success(let data):
                if let json = String(data: data, encoding: .utf8) {
//                    print("Raw JSON: \(json)")
                }
                do {
                    let decoded = try JSONDecoder().decode(TeamResponse.self, from: data)
                    onSuccess(decoded.result)
                } catch {
                    print(" Decoding error: \(error)")
                    onFailure("Decoding failed")
                }
            case .failure(let error):
                print(" Network error: \(error)")
                onFailure(error.localizedDescription)
            }
        }
    }
 
    
    func getLeaguesBySport(sport: Sports, onSuccess: @escaping ([LeagueDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport.rawValue)/"
        let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String ?? "NOTFOUND"
        let paramters = ["met": "Leagues", "APIkey": apiKey]
        
        AF.request(url, parameters: paramters, encoding: URLEncoding.default)
            .responseDecodable(of: LeagueResponse.self) { data in
                switch data.result {
                case .success(let response):
                    print("success")
                    onSuccess(response.result)

                case .failure(let error):
                    print("failed")
                    onFailure(error.localizedDescription)
                }
            }
        
//        AF.request(url, parameters: paramters, encoding: URLEncoding.default)
//            .responseData(completionHandler: { data in
//                switch data.result {
//                case .success(let res):
//                    if let jsonString = String(data: res, encoding: .utf8) {
//                                    print("✅ Raw JSON response: \n\(jsonString)")
//                                }
//                case .failure( let error):
//                    print("Error: \(error.localizedDescription)")
//                }
//            })
    }
    
    func getTeamById(sport: Sports,leagueId:Int, teamId: Int, onSuccess: @escaping ([TeamDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        let url = "https://apiv2.allsportsapi.com/\(sport.rawValue)/"
        let parameters: [String: Any] = [
            "met": "Teams",
            "leagueId": leagueId,
            "teamId": teamId,
            "APIkey": apiKey
        ]
        
        
        if let urlObject = URL(string: url),
           let fullURL = try? URLEncoding.default.encode(URLRequest(url: urlObject), with: parameters).url?.absoluteString {
            print(" Requesting: \(fullURL)")
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
}
