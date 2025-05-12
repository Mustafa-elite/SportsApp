import UIKit
import Kingfisher

class LeaguesTableViewController: UITableViewController {
    
    var selectedSport: Sports!
    var presenter: LeaguesPresetner!
    var leagues: [LeagueView]!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("selected sport = \(self.selectedSport.rawValue)")
        self.leagues = []
        self.presenter = LeaguesPresetner(view: self, repo: RepositoryImpl(remoteDataSource: RemoteDataSourceImpl()))
        
        self.presenter.loadLeaguesBySport(sport: self.selectedSport)
        
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

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
