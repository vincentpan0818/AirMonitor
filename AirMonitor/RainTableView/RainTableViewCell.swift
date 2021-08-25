//
//  RainTableViewCell.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/8/6.
//

import UIKit

class RainTableViewCell: UITableViewCell {
    
    static let id = "RainCell"
    
    @IBOutlet weak var countyLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var rainLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
