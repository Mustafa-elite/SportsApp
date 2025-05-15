//
//  TeamDetailsViewController.swift
//  SportsProject
//
//  Created by Mustafa on 13/05/2025.
//

import UIKit
import Kingfisher
class TeamDetailsViewController: UIViewController, TeamDetailsView {

    // MARK: - IBOutlets

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

        // Register custom cell from XIB or storyboard
        let nib = UINib(nibName: "TeamMemberCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TeamMemberCell")

        presenter.viewDidLoad()
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

