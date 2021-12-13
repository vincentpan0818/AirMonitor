//
//  AboutViewController.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/8/7.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "版本號"
        self.navigationController?.navigationBar.tintColor = .black
        version()
        backgroundColor()
    }
    
    func version() {
        
        let bundle = Bundle(identifier: "com.vincent.AirMonitor")!
        let infoDictionary = bundle.infoDictionary!
        let version = infoDictionary["CFBundleVersion"] as! String
        let shortVersion = infoDictionary["CFBundleShortVersionString"] as! String
        versionLabel.text = "App version: \(shortVersion) build \(version)"
    }
    
    func backgroundColor() {
         let gradientLayer = CAGradientLayer()
         gradientLayer.frame = view.bounds
         gradientLayer.colors = [UIColor.white.cgColor, UIColor.orange.cgColor]
         view.layer.insertSublayer(gradientLayer, at: 0)
    }

}
