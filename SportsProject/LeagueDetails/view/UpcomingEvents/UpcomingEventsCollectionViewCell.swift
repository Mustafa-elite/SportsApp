//
//  UpcomingEventsCollectionViewCell.swift
//  SportsProject
//
//  Created by JETS Mobile Lab on 11/05/2025.
//

import UIKit

class UpcomingEventsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var events: [EventDTO] = []

   func configure(with events: [EventDTO]) {
       self.events = events
       collectionView.reloadData()
   }
    override func layoutSubviews() {
        super.layoutSubviews()

        // Safe to access outlets here
        collectionView.delegate = self
        collectionView.dataSource = self

        collectionView.register(UINib(nibName: "UpcomingEventCell", bundle: nil), forCellWithReuseIdentifier: "UpcomingEventCell")

        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
    }

}

extension UpcomingEventsCollectionViewCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingEventCell", for: indexPath) as? UpcomingEventCell else {
            return UICollectionViewCell()
        }
        cell.configure(with: events[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = collectionView.bounds.height * 0.9
        let width = collectionView.bounds.width * 0.9

        return CGSize(width: width, height: height)
    }

}
