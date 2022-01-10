//
//  RainViewController.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/8/6.
//

import UIKit

class RainViewController: UIViewController {
    
    @IBOutlet weak var rainTableView: UITableView!
    
    var rainResult: [RainResultRecordsModel] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "酸雨指數"
        
        rainTableView.dataSource = self
        rainTableView.delegate = self
        
        let sortBarBtnItem = UIBarButtonItem(title: "排序", style: .plain, target: self, action: #selector(didtapSort))
        self.navigationItem.rightBarButtonItem = sortBarBtnItem
        self.rainTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let currentMode = UITraitCollection.current.userInterfaceStyle
        if currentMode == .light {
            self.navigationController?.navigationBar.tintColor = .black
            self.navigationController?.navigationBar.barTintColor = .orange
            self.tabBarController?.tabBar.barTintColor = .orange
        } else {
            self.navigationController?.navigationBar.tintColor = .white
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if overrideUserInterfaceStyle == .light {
            self.navigationController?.navigationBar.barTintColor = .white
            self.tabBarController?.tabBar.barTintColor = .white
        }

    }
    
    @objc func didtapSort() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "依照酸雨指數排序", style: .default, handler: { action in
            print("開始依照酸雨指數排序")
            self.sortRain()
            self.rainTableView.reloadData()
        }))
        alert.addAction(UIAlertAction(title: "依照站點排序", style: .default, handler: { action in
            print("開始依照站點排序")
            self.sortCountry()
            self.rainTableView.reloadData()
            
        }))
        alert.addAction(UIAlertAction(title: "取消", style: .destructive, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func sortRain() {
        rainResult.sort { rainResult1, rainResult2 in
            if let result1 = Float(rainResult1.concentration), let result2 = Float(rainResult2.concentration) {
                return result1 > result2
            } else {
                return false
            }
        }
    }
    
    func sortCountry() {
        rainResult.sort { countyResult1, countyResult2 in
            if let result1 = Int(countyResult1.siteId), let result2 = Int(countyResult2.siteId) {
                return result1 < result2
            } else {
                return false
            }
        }
    }

}

extension RainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rainResult.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RainTableViewCell.id , for: indexPath) as! RainTableViewCell
        cell.countyLabel.text = rainResult[indexPath.row].county
        cell.siteLabel.text = rainResult[indexPath.row].siteName
        cell.rainLabel.text = rainResult[indexPath.row].concentration
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
        
}
