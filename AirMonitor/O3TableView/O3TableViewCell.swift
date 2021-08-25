//
//  O3TableViewCell.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/8/6.
//

import UIKit

class O3TableViewCell: UITableViewCell {

    static let id = "O3Cell"
        
    @IBOutlet weak var countyLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var o3Label: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
