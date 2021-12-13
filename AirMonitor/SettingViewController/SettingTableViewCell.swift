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
    
}

extension SettingTableViewCell {
    func setContentWithData(cellType: SettingPageTableType) {
        infoLabel.text = cellType.text
    }
    
}
