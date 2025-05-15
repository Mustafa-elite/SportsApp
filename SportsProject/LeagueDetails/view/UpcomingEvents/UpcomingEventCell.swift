//
//  UpcomingEventCell.swift
//  SportsProject
//
//  Created by JETS Mobile Lab on 11/05/2025.
//

import UIKit

class UpcomingEventCell: UICollectionViewCell {

    @IBOutlet weak var matchDateAndTime: UILabel!
    @IBOutlet weak var team2Image: UIImageView!
    @IBOutlet weak var team1Image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with event: EventDTO) {
        let eventDateTime = "\(event.eventDate ?? "")   \(event.eventTime ?? "")"
        matchDateAndTime.text = eventDateTime

        if let homeLogo = event.homeTeamLogo, let homeLogoURL = URL(string: homeLogo) {
            team1Image.kf.setImage(with: homeLogoURL, placeholder: UIImage(named: "teamlogo"))
        } else {
            team1Image.image = UIImage(named: "teamlogo")
        }

        if let awayLogo = event.awayTeamLogo, let awayLogoURL = URL(string: awayLogo) {
            team2Image.kf.setImage(with: awayLogoURL, placeholder: UIImage(named: "teamlogo"))
        } else {
            team2Image.image = UIImage(named: "teamlogo")
        }
    }


}
