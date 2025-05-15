//
//  TeamCell.swift
//  SportsProject
//
//  Created by JETS Mobile Lab on 11/05/2025.
//

import UIKit

class TeamCell: UICollectionViewCell {

    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func configure(withTeam:TeamDTO ){
        teamName.text = withTeam.teamName
        if let logoURL = URL(string: withTeam.teamLogo ?? "NONE") {
            teamImageView.kf.setImage(with: logoURL)
        }
    }

}
