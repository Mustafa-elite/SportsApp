import UIKit
import Kingfisher
import Reachability

class LeaguesTableViewController: UITableViewController {
    
    var selectedSport: Sports!
    var presenter: LeaguesPresetner!
    var leagues: [LeagueView]!
    private let reachability = try! Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("selected sport = \(self.selectedSport.rawValue)")
        self.leagues = []
        
        if reachability.connection == .unavailable {
            self.showNoInternetAlert()
        } else {
            self.presenter = LeaguesPresetner(view: self, repo: RepositoryImpl(remoteDataSource: RemoteDataSourceImpl(), localDataSource: LocalDataSourceImpl.shared))
            self.presenter.loadLeaguesBySport(sport: self.selectedSport)
        }
    }

    
    func showNoInternetAlert() {
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your internet connection and try again.", preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
            alert.addAction(okAction)
            self.present(alert, animated: true, completion: nil)
        }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int { return 1 }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return self.leagues.count }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "league_cell_id", for: indexPath) as! LeagueTableViewCell
        let currentLeague = self.leagues[indexPath.row]
        
        // Configure the cell...
        cell.lbLeagueName.text = currentLeague.name
        if currentLeague.logoUrl == "NONE" {
            switch selectedSport {
            case .FOOTBALL :
                cell.ivLeague.image = UIImage(named: "football")
            case .some(.BASKETBALL):
                cell.ivLeague.image = UIImage(named: "basketball")
            case .some(.TENNIS):
                cell.ivLeague.image = UIImage(named: "tennis")
            case .some(.CRICKET):
                cell.ivLeague.image = UIImage(named: "cricket")
            case .none:
                cell.ivLeague.image = UIImage(named: "broken")
            }
        } else {
            cell.ivLeague.kf.setImage(with: URL(string: currentLeague.logoUrl))
        }
        
        cell.ivLeague.layer.cornerRadius = cell.ivLeague.frame.size.height / 2
        cell.ivLeague.clipsToBounds = true
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = self.leagues[indexPath.row]
        print("\(selectedItem)")
//        presenter.addToFavorite(league: selectedItem)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "league_details_screen") as? LeagueDetailsViewController else {
            return
        }

        let repos: Repository = RepositoryImpl(remoteDataSource: RemoteDataSourceImpl(), localDataSource: LocalDataSourceImpl.shared)
        let selectedSport: Sports = self.selectedSport
        let leagueId: Int = selectedItem.id

        let presenter = LeagueDetailsPresenterImpl(view: vc, repo: repos, sport: selectedSport, leagueId: leagueId)
            vc.presenter = presenter

            navigationController?.pushViewController(vc, animated: true)

    }
}


extension LeaguesTableViewController : LeaguesView {
    func setLeagues(leagues: [LeagueView]) {
        self.leagues = leagues
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setError(errorMsg: String) {
        print("ERROR: \(errorMsg)")
    }
    
}
