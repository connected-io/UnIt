import Foundation
import UIKit

class FirstCollectionViewCell: UICollectionViewCell {
    let provinces = ["Ontario", "Quebec", "British Columbia", "Newfoundland", "Manitoba", "Alberta", "Saskatchewan", "New Brunwick", "Yukon", "Northwest Territories", "Nova Scotia", "Prince Edward Island", "Nunavut"]
    
    @IBOutlet weak var secondCollectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        secondCollectionView.dataSource = self
    }
}

extension FirstCollectionViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return provinces.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCollectionViewCell", for: indexPath) as! SecondCollectionViewCell
        collectionViewCell.label.text = provinces[indexPath.row]
        return collectionViewCell
    }
}
