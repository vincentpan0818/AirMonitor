//
//  LocationManger.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/7/22.
//

import UIKit
import CoreLocation


class LocationMannger: NSObject {
    
    static let shared = LocationMannger()
    
    private var locationManger = CLLocationManager()
    
    var userCoordinate: CLLocationCoordinate2D? = nil
    var locationAuthorizationStatus: CLAuthorizationStatus = .notDetermined
    
    private override init() {
        super.init()
        locationManger.delegate = self
        locationManger.distanceFilter = kCLLocationAccuracyNearestTenMeters
        locationManger.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func askPermission(){
        
        if #available(iOS 14.0, *){
            locationAuthorizationStatus = locationManger.authorizationStatus
        }else{
            locationAuthorizationStatus = CLLocationManager.authorizationStatus()
        }
        switch locationAuthorizationStatus{
        case .notDetermined:
            //還沒決定
            locationManger.requestWhenInUseAuthorization()
            locationManger.startUpdatingLocation()
        case .restricted, .denied:
            //沒有權限
            break
        case .authorizedAlways, .authorizedWhenInUse:
            //允許過權限
            locationManger.startUpdatingLocation()
        @unknown default:
            break
        }
    }
}

//MARK: CLLocationManagerDelegate

extension LocationMannger: CLLocationManagerDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard userCoordinate == nil else{
            return
        }
        userCoordinate = manager.location?.coordinate
        manager.stopUpdatingLocation()
        if let lat = userCoordinate?.latitude , let lon = userCoordinate?.longitude{
            print("User lat: \(lat)") //緯度
            print("User lon: \(lon)") //經度
        }
    }
    
    //舊的,ios 14以上-棄用
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        locationAuthorizationStatus = status
        
        if status == .authorizedAlways || status == .authorizedWhenInUse{
            
        }else if status == .denied || status == .restricted{
            
        }else{
            
        }
    }
    
    //新的,ios 14以上
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        if #available(iOS 14.0, *){
            let accuracyAuthorization = manager.accuracyAuthorization
            switch accuracyAuthorization{
            case .fullAccuracy:
                break
            case .reducedAccuracy:
                break
            default:
                break
            }
        }else{
            
        }
    }
    
}
