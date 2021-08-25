//
//  AQITableViewCell.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/7/21.
//

import UIKit

class AQITableViewCell: UITableViewCell {
    
    static let id = "AQIcell"
    @IBOutlet weak var countyLabel: UILabel!
    @IBOutlet weak var siteNameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var aqiLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
