//
//  SettingTableViewCell.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/8/6.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var settingImageView: UIImageView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension SettingTableViewCell{
    
    func setContentWithData(cellType: SettingPageTableType){
        infoLabel.text = cellType.text
    }
}

