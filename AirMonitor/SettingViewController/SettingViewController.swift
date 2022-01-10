//
//  SettingViewController.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/8/6.
//

import UIKit

enum SettingPageTableType: CaseIterable {
    case pm25
    case aqi
    case rain
    case o3
    case appStore
    case privacy
    case contact
    case about
    
    var text: String {
        switch self {
        case .pm25:
            return "PM25"
        case .aqi:
            return "AQI指數"
        case .rain:
            return "酸雨指數"
        case .o3:
            return "臭氧(O3)指數"
        case .appStore:
            return "App Store評論"
        case .privacy:
            return "隱私權政策"
        case .contact:
            return "聯絡開發者"
        case .about:
            return "版本號"
        }
    }
}

class SettingViewController: UIViewController {

    @IBOutlet weak var settingTableView: UITableView!
    
    let settingTypeArray: [SettingPageTableType] = SettingPageTableType.allCases
    
    var gradientLayer: CAGradientLayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "設定"
        self.tabBarController?.tabBar.tintColor = .black
                
        settingTableView.delegate = self
        settingTableView.dataSource = self
        
        let nib = UINib(nibName: "SettingTableViewCell", bundle: nil)
        settingTableView.register(nib, forCellReuseIdentifier: "settingCell")
                
        let currentMode = UITraitCollection.current.userInterfaceStyle
        if currentMode == .light {
            self.navigationController?.navigationBar.backgroundColor = .white
            createGradientLayer()
            tableViewColor()
        }
    }
    
    func createGradientLayer() {
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.gray.cgColor, UIColor.orange.cgColor]
        gradientLayer.frame = self.view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func tableViewColor() {
        let backgroundView = UIView()
        gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.white.cgColor, UIColor.orange.cgColor]
        gradientLayer.frame = self.settingTableView.frame
        backgroundView.layer.addSublayer(gradientLayer)
        settingTableView.backgroundView = backgroundView
    }

}

extension SettingViewController: UITableViewDataSource,UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingTypeArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingCell" , for: indexPath) as! SettingTableViewCell
        
        cell.setContentWithData(cellType: settingTypeArray[indexPath.row])
        cell.backgroundColor = UIColor.white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 0.5
        cell.layer.cornerRadius = 20
        cell.layer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height)
        cell.clipsToBounds = true
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentType = settingTypeArray[indexPath.row]
        switch currentType {
        case .pm25:
            routeToPM25()
        case .aqi:
            routeToAqi()
        case .rain:
            routeToRain()
        case .o3:
            routeToO3()
        case .appStore:
            routeToAppStore()
        case .privacy:
            routeToPrivacy()
        case .contact:
            routeToContact()
        case .about:
            routeToAbout()
        }
    }
    
}

//MARK: Route Action
extension SettingViewController {
    func routeToPM25() {
        if let url = URL(string: "https://zh.wikipedia.org/wiki/%E6%87%B8%E6%B5%AE%E7%B2%92%E5%AD%90") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func routeToAqi() {
        if let url = URL(string: "https://zh.wikipedia.org/wiki/%E7%A9%BA%E6%B0%A3%E5%93%81%E8%B3%AA%E6%8C%87%E6%A8%99") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func routeToRain() {
        if let url = URL(string: "https://zh.wikipedia.org/wiki/%E9%85%B8%E9%9B%A8") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func routeToO3() {
        if let url = URL(string: "https://zh.wikipedia.org/wiki/%E8%87%AD%E6%B0%A7") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func routeToAppStore() {
        let url = URL(string: "itms-apps://itunes.apple.com/app/id1580204319")
        // 注意: 跳轉之前, 可以使用 canOpenURL: 判斷是否可以跳轉
        if !UIApplication.shared.canOpenURL(url!) {
            // 不能跳轉就不要往下執行了
            return
        }
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url!, options: [:]) { (success) in
                if (success) {
                    print("10以後可以跳轉url")
                } else {
                    print("10以後不能完成跳轉")
                }
            }
        } else {
            // Fallback on earlier versions
            let success = UIApplication.shared.openURL(url!)
            if (success) {
                print("10以下可以跳轉")
            } else {
                print("10以下不能完成跳轉")
            }
        }
    }
    
    func routeToPrivacy() {
        if let url = URL(string: "https://vincentpan0818.wixsite.com/website/about") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
    func routeToContact() {
        DispatchQueue.main.async{ [weak self] in
            let contactVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "contactVC") as! ContactViewController
            self?.navigationController?.pushViewController(contactVC, animated: true)
        }
    }
    
    func routeToAbout() {
        DispatchQueue.main.async{ [weak self] in
            let aboutVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "aboutVC") as! AboutViewController
            self?.navigationController?.pushViewController(aboutVC, animated: true)
        }
    }
    
}
