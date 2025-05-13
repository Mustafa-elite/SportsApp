import UIKit

class LeagueTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var lbLeagueName: UILabel!
    
    @IBOutlet weak var ivLeague: UIImageView!
    
    
    
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
