import Foundation
import Alamofire


class RemoteDataSourceImpl : RemoteDataSource {
    
    func getLeagueEvents(sport: Sports, leagueId: Int, from: Date, to: Date, onSuccess: @escaping ([EventDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        
        
        
    }
    
    func getTeamsByLeagueId(sport: Sports, leagueId: Int, onSuccess: @escaping ([TeamDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        
    }
    
    func getTeamById(sport: Sports, teamId: Int, onSuccess: @escaping ([TeamDTO]) -> Void, onFailure: @escaping (String) -> Void) {
        
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
}
