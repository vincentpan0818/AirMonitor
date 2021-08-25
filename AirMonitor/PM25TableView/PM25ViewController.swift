//
//  PM25ViewController.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/7/15.
//

import UIKit
import CoreData

class PM25ViewController: UIViewController {
    
    @IBOutlet weak var pm25TableView: UITableView!
    
    var pm25Result: [PM25ResultRecordsModel] = []
    //var isAllReadyInFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "PM2.5"
        
        
        pm25TableView.dataSource = self
        pm25TableView.delegate = self
        let sortBarBtnItem = UIBarButtonItem(title: "排序", style: .plain, target: self, action: #selector(didtapSort))
        self.navigationItem.rightBarButtonItem = sortBarBtnItem
        self.pm25TableView.reloadData()
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
        alert.addAction(UIAlertAction(title: "依照PM2.5排序", style: .default, handler: { action in
            print("開始依照PM2.5排序")
            self.sortPM25()
            self.pm25TableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "依照站點排序", style: .default, handler: { action in
            print("開始依照站點排序")
            self.sortCountry()
            self.pm25TableView.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .destructive, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func sortPM25(){
        
        pm25Result.sort { pm25result1, pm25result2 in
            if let result1 = Int(pm25result1.concentration), let result2 = Int(pm25result2.concentration){
                return result1 > result2
            }else{
                return false
            }
        }
        
    }
    
    func sortCountry(){
        
        pm25Result.sort { countryresult1, countryresult2 in
            if let result1 = Int(countryresult1.siteId), let result2 = Int(countryresult2.siteId){
                return result1 < result2
            }else{
                return false
            }
        }
    }
    

}
extension PM25ViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pm25Result.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: PM25TableViewCell.id , for: indexPath) as! PM25TableViewCell
        cell.countryLabel.text = pm25Result[indexPath.row].county
        cell.siteLabel.text = pm25Result[indexPath.row].siteName
        cell.pm25Label.text = pm25Result[indexPath.row].concentration
//        cell.siteId = pm25Result[indexPath.row].siteId
//        cell.row = indexPath.row
//        cell.delegate = self
        
        return cell
    }
        
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
//    func pm25TableCellDidTapStar(_ sender: PM25TableViewCell) {
//
//        if !self.isAllReadyInFavorite{
//            print("did Taped FavoriteButton")
//            self.isAllReadyInFavorite = true
//
//        }else{
//            print("did Taped deteleButton")
//            self.isAllReadyInFavorite = false
//        }
//    }
        
}
