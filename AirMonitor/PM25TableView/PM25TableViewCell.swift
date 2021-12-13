//
//  PM25TableViewCell.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/7/15.
//
import Foundation
import UIKit

protocol PM25TableViewCellDelegate: AnyObject {
    func pm25TableCellDidTapStar(_ sender: PM25TableViewCell)
}

class PM25TableViewCell: UITableViewCell {
    
    static let id = "PM25cell"
    
    weak var delegate: PM25TableViewCellDelegate?
    
    var pm25Favorite: [PM25ResultRecordsModel] = []
    
    @IBOutlet weak var starBtn: UIButton!
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var pm25Label: UILabel!
    
}
