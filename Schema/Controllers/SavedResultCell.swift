//
//  SavedResultCell.swift
//  YSQ
//
//  Created by itay gervash on 18/02/2020.
//  Copyright © 2020 Lazy Bear Apps. All rights reserved.
//

import UIKit

class SavedResultCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    func setData(with result: SavedResult) {
        
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MMM d, yyyy"
        nameLabel.text = result.name
        dateLabel.text = dateFormatter.string(from: result.date ?? Date())
    }
    
}
