//
//  O3ViewController.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/8/6.
//

import UIKit
import CoreLocation

class O3ViewController: UIViewController {
    
    @IBOutlet weak var o3TableView: UITableView!
    
    var o3Result: [O3ResultRecordsModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "臭氧(O3)指數"
        self.navigationController?.navigationBar.tintColor = .black
        
        
        o3TableView.dataSource = self
        o3TableView.delegate = self
        
                
        let sortBarBtnItem = UIBarButtonItem(title: "排序", style: .plain, target: self, action: #selector(didtapSort))
        self.navigationItem.rightBarButtonItem = sortBarBtnItem
        
        for (index, item) in o3Result.enumerated(){
            if let o3 = item.o3, o3 == ""{
                o3Result[index].o3 = "0"
            }
        }
        
        self.o3TableView.reloadData()
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

    @objc func didtapSort(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "依照臭氧(O3)指數排序", style: .default, handler: { action in
            print("開始依照臭氧(O3)指數排序")
            self.sortO3()
            
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
    
    func sortO3(){
        
        o3Result.sort { o3Result1, o3Result2 in
            if let aqiR1 = Float(o3Result1.o3 ?? ""), let aqiR2 = Float(o3Result2.o3 ?? ""){
                return aqiR1 > aqiR2
            }else{
                return false
            }
        }
        DispatchQueue.main.async{
            self.o3TableView.reloadData()
        }
        
    }
    
    func checkDistanceAndSort(){
        
        if let userCoordinate = LocationMannger.shared.userCoordinate{
            
            let currentUserLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
            
            for i in 0..<o3Result.count{
                
                if let targetLon = o3Result[i].longitude,
                   let targetLat = o3Result[i].latitude,
                   let siteName = o3Result[i].siteName{
                    guard targetLon != "" && targetLat != "", let lon = Double(targetLon), let lat = Double(targetLat) else{
                        print("沒有經緯度")
                        return
                    }
                    let targetLocation = CLLocation(latitude: lat, longitude: lon)
                    let distanceInMeter = currentUserLocation.distance(from: targetLocation)
                    print("使用者距離\(siteName),index:\(i) \(distanceInMeter / 1000)km")
                    o3Result[i].distence = distanceInMeter
                }
            }
            o3Result.sort { distance1, distance2 in
                return distance1.distence < distance2.distence
            }
            DispatchQueue.main.async {
                self.o3TableView.reloadData()
            }
            
        }else{
            print("沒有經緯度")
        }
    }
    

}


extension O3ViewController: UITableViewDataSource,UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return o3Result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: O3TableViewCell.id , for: indexPath) as! O3TableViewCell
        
        cell.countyLabel.text = o3Result[indexPath.row].county
        cell.siteLabel.text = o3Result[indexPath.row].siteName
        cell.o3Label.text = o3Result[indexPath.row].o3
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //點擊
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
}

