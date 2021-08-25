//
//  PM25CollectionViewCell.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/7/15.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
}
extension CollectionViewCell{
    func setContentWithData(cellType: HomePageCollectionType){
        label.text = cellType.text
    }
}
