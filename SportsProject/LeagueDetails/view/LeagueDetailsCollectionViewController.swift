//
//  LeagueDetailsCollectionViewController.swift
//  SportsProject
//
//  Created by JETS Mobile Lab on 11/05/2025.
//
import UIKit
class LeagueDetailsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!

    var presenter: LeagueDetailsPresenter!
    
    var upcomingEvents: [EventDTO] = []
    var latestEvents: [EventDTO] = []
    var teams: [TeamDTO] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        presenter.viewDidLoad()
    }

    private func setupCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(UINib(nibName: "UpcomingEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingEventsCollectionViewCell")
        collectionView.register(UINib(nibName: "LatestEventsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "LatestEventsCollectionViewCell")
        collectionView.register(UINib(nibName: "TeamsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TeamsCollectionViewCell")
    }
}

extension LeagueDetailsViewController: LeagueDetailsView {
    func showLoading() {
        
    }
    
    func hideLoading() {
        
    }
    
    func showError(_ message: String) {
        
    }
    
    func displayUpcomingEvents(_ events: [EventDTO]) {
        self.upcomingEvents = events
        collectionView.reloadSections(IndexSet(integer: 0))
    }

    func displayLatestEvents(_ events: [EventDTO]) {
        self.latestEvents = events
        collectionView.reloadSections(IndexSet(integer: 1))
    }

    func displayTeams(_ teams: [TeamDTO]) {
        self.teams = teams
        collectionView.reloadSections(IndexSet(integer: 2))
    }
}

extension LeagueDetailsViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // each section is a single horizontal/vertical scrollable cell
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEventsCollectionViewCell", for: indexPath) as! UpcomingEventsCollectionViewCell
            cell.configure(with: upcomingEvents)
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LatestEventsCollectionViewCell", for: indexPath) as! LatestEventsCollectionViewCell
            cell.configure(with: latestEvents)
            return cell
        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TeamsCollectionViewCell", for: indexPath) as! TeamsCollectionViewCell
            cell.configure(with: teams)
            cell.delegate = self

            return cell
        default:
            fatalError("Unexpected section")
        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let screenHeight = UIScreen.main.bounds.height

        switch indexPath.section {
        case 0:
            return CGSize(width: width, height: screenHeight * 0.20)
        case 1:
            return CGSize(width: width, height: screenHeight * 0.40)
        case 2:
            return CGSize(width: width, height: screenHeight * 0.30)
        default:
            return CGSize(width: width, height: screenHeight * 0.10)
        }
    }


}
extension LeagueDetailsViewController: TeamsCollectionViewCellDelegate {
    func didSelectTeam(_ team: TeamDTO) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let teamDetailsVC = storyboard.instantiateViewController(withIdentifier: "team_details_screen") as? TeamDetailsViewController {
            print("team clicked")
            let repos: Repository = RepositoryImpl(remote: RemoteDataSourceImpl())
            let teamPresenter = TeamDetailsPresenterImpl(view: teamDetailsVC, repo: repos, sport: presenter.getSport(), teamId: team.teamKey, leagueId: presenter.getLeagueId())
            
            teamDetailsVC.presenter = teamPresenter
            
            navigationController?.pushViewController(teamDetailsVC, animated: true)
        }
    }
}


