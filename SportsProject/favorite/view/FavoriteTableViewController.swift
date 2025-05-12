import UIKit

class FavoriteTableViewController: UITableViewController {

    var presenter: FavoritePresenter!
    var leagues: [LeagueView]!
    let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext

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
        if editingStyle == .delete {
            
            let selectedItem = self.leagues[indexPath.row]
            presenter.deleteLeague(league: selectedItem)
            self.leagues.remove(at: indexPath.row)
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
