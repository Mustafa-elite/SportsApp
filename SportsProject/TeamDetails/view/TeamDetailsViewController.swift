//
//  TeamDetailsViewController.swift
//  SportsProject
//
//  Created by Mustafa on 13/05/2025.
//

import UIKit
import Kingfisher
import Reachability
class TeamDetailsViewController: UIViewController, TeamDetailsView {

    private let reachability = try! Reachability()

    
    @IBOutlet weak var teamImageView: UIImageView!
    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Properties

    var presenter: TeamDetailsPresenter!
    private var coaches: [Coach] = []
    private var players: [Player] = []

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()

        let nib = UINib(nibName: "TeamMemberCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TeamMemberCell")
        
        if reachability.connection == .unavailable {
            self.showNoInternetAlert()
        } else {
            
            presenter.viewDidLoad()
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

    // MARK: - TeamDetailsView Protocol

    func displayTeamDetails(_ team: TeamDTO) {
        teamNameLabel.text = team.teamName
        teamImageView.kf.setImage(with: URL(string: team.teamLogo ?? "NONE"), placeholder: UIImage(systemName: "photo"))
        coaches = team.coaches
        players = team.players
        tableView.reloadData()
    }
}
extension TeamDetailsViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2 
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? coaches.count : players.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Coaches" : "Players"
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TeamMemberCell", for: indexPath) as? TeamMemberCell else {
            return UITableViewCell()
        }

        if indexPath.section == 0 {
            let coach = coaches[indexPath.row]
            cell.configure(name: coach.coachName ?? "Not Available", imageUrl: nil)
        } else {
            let player = players[indexPath.row]
            cell.configure(name: player.playerName ?? "Not available", imageUrl: player.playerImage)
        }

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}

