import UIKit
import Kingfisher

class TeamMemberCell: UITableViewCell {

    @IBOutlet weak var memberImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        memberImageView.layer.cornerRadius = memberImageView.frame.height / 2
        memberImageView.clipsToBounds = true
    }
    func configure(name: String, imageUrl: String?) {
        nameLabel.text = name
        if let imageUrl = imageUrl, let url = URL(string: imageUrl) {
            memberImageView.kf.setImage(with: url, placeholder: UIImage(systemName: "person"))
        } else {
            memberImageView.image = UIImage(systemName: "person")
        }
    }

}
