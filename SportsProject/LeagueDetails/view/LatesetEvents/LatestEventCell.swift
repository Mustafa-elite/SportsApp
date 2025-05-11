//
//  LatestEventCell.swift
//  SportsProject
//
//  Created by JETS Mobile Lab on 11/05/2025.
//

import UIKit
import Kingfisher
class LatestEventCell: UICollectionViewCell {
    @IBOutlet weak var team2Image: UIImageView!
    
    @IBOutlet weak var matchDateAndTime: UILabel!
    @IBOutlet weak var matchResult: UILabel!
    @IBOutlet weak var team1Image: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(with event: EventDTO) {
        let eventDateTime = "\(event.eventDate)   \(event.eventTime)"
        matchDateAndTime.text = eventDateTime

        matchResult.text = "\(event.eventFinalResult)"

        if let homeLogoURL = URL(string: event.homeTeamLogo) {
            team1Image.kf.setImage(with: homeLogoURL)
        }

        if let awayLogoURL = URL(string: event.awayTeamLogo) {
            team2Image.kf.setImage(with: awayLogoURL)
        }
    }

}
