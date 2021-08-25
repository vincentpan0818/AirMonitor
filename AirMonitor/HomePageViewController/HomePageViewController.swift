//
//  ViewController.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/7/14.
//

import UIKit

enum HomePageCollectionType: CaseIterable{
    case pm25
    case AQI
    case rain
    case o3
    
    var text: String{
        switch self{
        case .pm25:
            return "PM2.5"
        case .AQI:
            return "AQI指數"
        case .rain:
            return "酸雨指數"
        case .o3:
            return "臭氧(O3)指數"
        }
    }
}

class HomePageViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    //let collectionArray = ["PM2.5", "AQI指數"]
    var pm25Result: [PM25ResultRecordsModel] = []
    var aqiResult: [AQIResultRecordsModel] = []
    var rainResult: [RainResultRecordsModel] = []
    var o3Result: [O3ResultRecordsModel] = []
    
    let collectionTypeArray: [HomePageCollectionType] = HomePageCollectionType.allCases
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "首頁"
        self.tabBarController?.tabBar.tintColor = .black
                
        collectionView.dataSource = self
        collectionView.delegate = self
    }

}


extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    //MARK:UICollectionViewDataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return collectionTypeArray.count
    }
    
    //MARK:UICollectionViewDelegate
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CollectionViewCell
        
        cell.setContentWithData(cellType: collectionTypeArray[indexPath.row])
        return cell
    }
    
    //MARK:UICollectionViewDelegateFlowLayout
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        
        let width = (view.frame.width - 54) / 2
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    //MARK:select cell
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let currentType = collectionTypeArray[indexPath.row]
        
        switch currentType{
        case .pm25:
            routeToPM25Page()
        case .AQI:
            routeToAQIPage()
        case .rain:
            routeToRainPage()
        case .o3:
            routeToO3Page()
        }
    }
    
}

//MARK: Route Action
extension HomePageViewController{
    //參數可以自訂帶
    func routeToPM25Page(){
        
        let urlString: String =  "https://data.epa.gov.tw/api/v1/aqx_p_322?api_key=ac1c105b-1b2a-4970-bca9-53d83d3dcb95"
        guard let url = URL(string: urlString) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, reponse, error in
            if let error = error{
                print("error: \(error)")
                self.errorHandle()
                return
            }
            
            if let loadData = data{
                do{
                    let okData = try JSONDecoder().decode(PM25ResultModel.self, from: loadData)
                    print("\(okData)")
                    self.pm25optionalBinding(data: okData)
                }catch{
                    print("\(error)")
                }
            }
        }
        task.resume()
    }
    
    
    func pm25optionalBinding(data: PM25ResultModel){
        
        if let singleDataArray = data.records{
            self.pm25Result = singleDataArray
            
            DispatchQueue.main.async { [weak self] in
                let pm25VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "PM25VC") as! PM25ViewController
                pm25VC.pm25Result = self?.pm25Result ?? []
                self?.navigationController?.pushViewController(pm25VC, animated: true)
            }
        }
    }
    
    
    func routeToAQIPage(){
        
        let urlString: String =  "https://data.epa.gov.tw/api/v1/aqx_p_432?api_key=ac1c105b-1b2a-4970-bca9-53d83d3dcb95"
        guard let url = URL(string: urlString) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, reponse, error in
            if let error = error{
                print("error: \(error)")
                self.errorHandle()
                return
            }
            
            if let loadData = data{
                do{
                    let okData = try JSONDecoder().decode(AQIResultModel.self, from: loadData)
                    print("\(okData)")
                    self.aqioptionalBinding(data: okData)
                }catch{
                    print("\(error)")
                }
            }
        }
        task.resume()
    }
    
    func aqioptionalBinding(data: AQIResultModel){
        
        if let singleDataArray = data.records{
            self.aqiResult = singleDataArray
            
            DispatchQueue.main.async { [weak self] in
                let AQIVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "AQIVC") as! AQIViewController
                AQIVC.aqiResult = self?.aqiResult ?? []
                self?.navigationController?.pushViewController(AQIVC, animated: true)
            }
        }
    }
    
    func routeToRainPage(){
        
        let urlString: String =  "https://data.epa.gov.tw/api/v1/aqx_p_314?api_key=ac1c105b-1b2a-4970-bca9-53d83d3dcb95"
        guard let url = URL(string: urlString) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, reponse, error in
            if let error = error{
                print("error: \(error)")
                self.errorHandle()
                return
            }
            
            if let loadData = data{
                do{
                    let okData = try JSONDecoder().decode(RainResultModel.self, from: loadData)
                    print("\(okData)")
                    self.rainoptionalBinding(data: okData)
                }catch{
                    print("\(error)")
                }
            }
        }
        task.resume()
    }
    
    func rainoptionalBinding(data: RainResultModel){
        
        if let singleDataArray = data.records{
            self.rainResult = singleDataArray
            
            DispatchQueue.main.async { [weak self] in
                let rainVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "RainVC") as! RainViewController
                rainVC.rainResult = self?.rainResult ?? []
                self?.navigationController?.pushViewController(rainVC, animated: true)
            }
        }
    }

    
    func routeToO3Page(){
        
        let urlString: String =  "https://data.epa.gov.tw/api/v1/aqx_p_432?api_key=ac1c105b-1b2a-4970-bca9-53d83d3dcb95"
        guard let url = URL(string: urlString) else{
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, reponse, error in
            if let error = error{
                print("error: \(error)")
                self.errorHandle()
                return
            }
            
            if let loadData = data{
                do{
                    let okData = try JSONDecoder().decode(O3ResultModel.self, from: loadData)
                    print("\(okData)")
                    self.o3optionalBinding(data: okData)
                }catch{
                    print("\(error)")
                }
            }
        }
        task.resume()
    }
    
    func o3optionalBinding(data: O3ResultModel){
        
        if let singleDataArray = data.records{
            self.o3Result = singleDataArray
            
            DispatchQueue.main.async { [weak self] in
                let O3VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "O3VC") as! O3ViewController
                O3VC.o3Result = self?.o3Result ?? []
                self?.navigationController?.pushViewController(O3VC, animated: true)
            }
        }
    }
    
    func errorHandle(){
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "下載失敗請稍後再試", style: .default, handler: { action in
            print("下載失敗")
        }))
        alert.addAction(UIAlertAction(title: "確定", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }

}
