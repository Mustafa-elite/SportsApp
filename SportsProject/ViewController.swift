//
//  ViewController.swift
//  SportsProject
//
//  Created by Mustafa on 09/05/2025.
//

import UIKit
import Reachability
import Alamofire

class ViewController: UIViewController {

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//        print("test git")
//        print("additional git test")
//    }
    
    var reachability: Reachability?
     
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String ?? "NOT FOUND"
            print("apiKey = \(apiKey)")
     
            setupReachability()
     
            AF.request("https://apiv2.allsportsapi.com/football/?&met=Teams&teamId=4283&APIkey=\(apiKey)").response { response in
                switch response.result {
                case .success(let data):
                    if let data = data {
                        print("Data: \(data)")
                    }
                case .failure(let error):
                    print("Error: \(error)")
                }
            }
        }
     
        func setupReachability() {
            do {
                reachability = try Reachability()
                reachability?.whenReachable = { reachability in
                    if reachability.connection == .wifi {
                        print("Connected via WiFi")
                    } else {
                        print("Connected via Cellular")
                    }
                }
                reachability?.whenUnreachable = { _ in
                    print("No network connection")
                }
     
                try reachability?.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        }
     
        deinit {
            reachability?.stopNotifier()
        }

    @IBAction func testButton(_ sender: Any) {

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
            guard let vc = storyboard.instantiateViewController(withIdentifier: "league_details_screen") as? LeagueDetailsViewController else {
                return
            }

        let repos: Repository = RepositoryImpl(remoteDataSource: RemoteDataSourceImpl(), localDataSource: LocalDataSourceImpl.shared)
        let selectedSport: Sports = .FOOTBALL
            let leagueId: Int = 177

//        let presenter = LeagueDetailsPresenterImpl(view: vc, repo: repos, sport: selectedSport, leagueId: leagueId)
//            vc.presenter = presenter

            navigationController?.pushViewController(vc, animated: true)
    }
    
}

