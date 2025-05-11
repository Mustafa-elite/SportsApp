//
//  SportsChooserCollectionViewController.swift
//  SportsProject
//
//  Created by Macos on 11/05/2025.
//

import UIKit

private let reuseIdentifier = "chooser_option_cell"

class SportsChooserCollectionViewController: UICollectionViewController {
    
    let options: [ChooserOption] = [
        ChooserOption(imageUrl: "football", title: "Football", value: "football"),
        ChooserOption(imageUrl: "basketball", title: "Basketball", value: "basketball"),
        ChooserOption(imageUrl: "tennis", title: "Tennis", value: "tennis"),
        ChooserOption(imageUrl: "cricket", title: "Cricket", value: "cricket"),
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "goToLeaguesScreen" {
            
            let dest = segue.destination as! LeaguesTableViewController
            let index = self.collectionView.indexPathsForSelectedItems?.first ?? IndexPath(row: 0, section: 0)
            let option = self.options[index.row]
            dest.selectedSport = Sports(rawValue: option.value)
            
        }
        
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.options.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChooserOptionCollectionViewCell
        
        let currentOption = self.options[indexPath.row]
    
        // Configure the cell
        cell.ivOption.image = UIImage(named: currentOption.imageUrl)
        cell.lbOption.text = currentOption.title
    
        return cell
    }

}


extension SportsChooserCollectionViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width / 2)
        let height = (UIScreen.main.bounds.height / 3)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }

}
