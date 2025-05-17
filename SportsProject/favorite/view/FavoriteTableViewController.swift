import UIKit
import Reachability

class FavoriteTableViewController: UITableViewController {

    var presenter: FavoritePresenter!
    var leagues: [LeagueView]!
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    private let reachability = try! Reachability()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.leagues = []
        self.presenter = FavoritePresenter(repo: RepositoryImpl(remoteDataSource: RemoteDataSourceImpl(), localDataSource: LocalDataSourceImpl.shared), view: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.presenter.loadFavoriteLeagues()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.leagues.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "league_cell_id", for: indexPath) as! LeagueTableViewCell
        
        let currentLeague = self.leagues[indexPath.row]

        // Configure the cell...
        cell.lbLeagueName.text = currentLeague.name
        if currentLeague.logoUrl == "NONE" {
            switch currentLeague.sportId {
            case Sports.FOOTBALL.rawValue :
                cell.ivLeague.image = UIImage(named: "football")
            case Sports.BASKETBALL.rawValue:
                cell.ivLeague.image = UIImage(named: "basketball")
            case Sports.TENNIS.rawValue:
                cell.ivLeague.image = UIImage(named: "tennis")
            case Sports.CRICKET.rawValue:
                cell.ivLeague.image = UIImage(named: "cricket")
            case "NONE":
                cell.ivLeague.image = UIImage(named: "broken")
            default:
                cell.ivLeague.image = UIImage(named: "broken")
            }
        } else {
            cell.ivLeague.kf.setImage(with: URL(string: currentLeague.logoUrl))
        }
        
        cell.ivLeague.layer.cornerRadius = cell.ivLeague.frame.size.height / 2
        cell.ivLeague.clipsToBounds = true
        
        return cell
    }
    


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        let selectedItem = self.leagues[indexPath.row]
        if editingStyle == .delete {
            
            let alert  = UIAlertController(title: "Confirmation", message: "you are about to remove \(selectedItem.name) from favorite", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let deleteAction = UIAlertAction(title: "Remove", style: .destructive) { [weak self] _ in
                self?.presenter.deleteLeague(league: selectedItem)
                self?.leagues.remove(at: indexPath.row)
                self?.tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            alert.addAction(cancelAction)
            alert.addAction(deleteAction)
            
            self.present(alert, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = self.leagues[indexPath.row]
        
        if reachability.connection == .unavailable {
            self.showNoInternetAlert()
            self.tableView.deselectRow(at: indexPath, animated: true)
        } else {
            self.goToLeagueDetails(leagueView: selectedItem)
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
    
    func goToLeagueDetails(leagueView: LeagueView) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let vc = storyboard.instantiateViewController(withIdentifier: "league_details_screen") as? LeagueDetailsViewController else {
            return
        }
        let repos: Repository = RepositoryImpl(remoteDataSource: RemoteDataSourceImpl(), localDataSource: LocalDataSourceImpl.shared)
        let presenter = LeagueDetailsPresenterImpl(view: vc, repo: repos, leagueView: leagueView)
            vc.presenter = presenter
            navigationController?.pushViewController(vc, animated: true)
    }
    
}


extension FavoriteTableViewController: LeaguesView {
    func setLeagues(leagues: [LeagueView]) {
        self.leagues = leagues
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func setError(errorMsg: String) {
        print("error: \(errorMsg)")
    }
    
    
}
