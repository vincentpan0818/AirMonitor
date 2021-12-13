//
//  AQIViewController.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/7/21.
//

import UIKit
import CoreLocation

class AQIViewController: UIViewController {

    @IBOutlet weak var aqiTableView: UITableView!
    
    var myLocationManager: CLLocationManager!
    var aqiResult: [AQIResultRecordsModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "AQI指數"
        self.navigationController?.navigationBar.tintColor = .black
        
        aqiTableView.dataSource = self
        aqiTableView.delegate = self
        
        let sortBarBtnItem = UIBarButtonItem(title: "排序", style: .plain, target: self, action: #selector(didtapSort))
        self.navigationItem.rightBarButtonItem = sortBarBtnItem
        for (index, item) in aqiResult.enumerated(){
            if let aqi = item.aqi, aqi == "" {
                aqiResult[index].aqi = "0"
            }
        }
        self.aqiTableView.reloadData()
        LocationMannger.shared.askPermission()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.tintColor = .black
        self.navigationController?.navigationBar.barTintColor = .orange
        self.tabBarController?.tabBar.barTintColor = .orange
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.barTintColor = .white
        self.tabBarController?.tabBar.barTintColor = .white
    }
    
    
    @objc func didtapSort() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "依照AQI指數排序", style: .default, handler: { action in
            print("開始依照AQI排序")
            self.sortAQI()
            
        }))
        alert.addAction(UIAlertAction(title: "依照所在位置距離排序", style: .default, handler: { action in
            print("開始依照所在位置距離排序")
            self.checkDistanceAndSort()
            
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .destructive, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func sortAQI() {
        aqiResult.sort { aqiResult1, aqiResult2 in
            if let aqiR1 = Int(aqiResult1.aqi ?? ""), let aqiR2 = Int(aqiResult2.aqi ?? "") {
                return aqiR1 > aqiR2
            } else {
                return false
            }
        }
        DispatchQueue.main.async {
            self.aqiTableView.reloadData()
        }
    }
    
    func checkDistanceAndSort() {
        if let userCoordinate = LocationMannger.shared.userCoordinate {
            let currentUserLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
            for i in 0..<aqiResult.count {
                if let targetLon = aqiResult[i].longitude,
                   let targetLat = aqiResult[i].latitude,
                   let siteName = aqiResult[i].siteName {
                    guard targetLon != "" && targetLat != "", let lon = Double(targetLon), let lat = Double(targetLat) else {
                        print("沒有經緯度")
                        return
                    }
                    let targetLocation = CLLocation(latitude: lat, longitude: lon)
                    let distanceInMeter = currentUserLocation.distance(from: targetLocation)
                    print("使用者距離\(siteName),index:\(i) \(distanceInMeter / 1000)km")
                    aqiResult[i].distence = distanceInMeter
                }
            }
            aqiResult.sort { distance1, distance2 in
                return distance1.distence < distance2.distence
            }
            DispatchQueue.main.async {
                self.aqiTableView.reloadData()
            }
        } else {
            print("沒有經緯度")
        }
    }

}


extension AQIViewController: UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return aqiResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AQITableViewCell.id , for: indexPath) as! AQITableViewCell
        cell.countyLabel.text = aqiResult[indexPath.row].county
        cell.siteNameLabel.text = aqiResult[indexPath.row].siteName
        cell.statusLabel.text = aqiResult[indexPath.row].status
        cell.aqiLabel.text = aqiResult[indexPath.row].aqi
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
