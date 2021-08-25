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
//    var isAllReadyInFavorite: Bool = false
    
    @IBOutlet weak var starBtn: UIButton!
    
    
    var pm25Favorite: [PM25ResultRecordsModel] = []
//    var row: Int = 0
//    var siteId: String = ""
    
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var siteLabel: UILabel!
    @IBOutlet weak var pm25Label: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
//extension PM25TableViewCell{
//
//    func setFavoriteButton(isHas: Bool){
//        starBtn.setImage(isHas ? UIImage(systemName: "star.fill") : UIImage(systemName: "star"), for: .normal)
//    }
//
//    func addToFavorite(siteId: String, row: Int){
//        print("Add to Favorite--> id: \(siteId), row: \(row)")
//        let filterArray = pm25Favorite.filter {
//            $0.siteId == siteId
//        }
//        CoreDataHelper.shared.inster(siteId: filterArray[0].siteId, county: filterArray[0].county, siteName: filterArray[0].siteName, concentration: filterArray[0].concentration)
//    }
//
//
//
//    @IBAction func starAction(_ sender: Any) {
//
//        delegate?.pm25TableCellDidTapStar(self)
//        //isAllReadyInFavorite = !isAllReadyInFavorite
//        if !self.isAllReadyInFavorite{
//            //starBtn.setImage(UIImage(systemName: "star.fill"), for: .normal)
//            self.isAllReadyInFavorite = true
//            self.setFavoriteButton(isHas: self.isAllReadyInFavorite)
//            self.addToFavorite(siteId: siteId, row: row)
//
//
//        }else{
//            //starBtn.setImage(UIImage(systemName: "star"), for: .normal)
//            self.isAllReadyInFavorite = false
//            self.setFavoriteButton(isHas: self.isAllReadyInFavorite)
//
//            }
//        }
//    }

