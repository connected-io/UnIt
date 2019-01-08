//
//  LabelCollectionViewCell.swift
//  pieceofcake
//
//  Created by cl-dev on 2019-01-07.
//  Copyright © 2019 cl-dev. All rights reserved.
//

import UIKit

class LabelCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(with text: String) {
        titleLabel.text = text
    }

}
