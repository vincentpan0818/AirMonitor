//
//  ContactViewController.swift
//  AirMonitor
//
//  Created by 潘奕儒 on 2021/8/7.
//

import UIKit

class ContactViewController: UIViewController {

    @IBOutlet weak var emailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "聯絡開發者"
        emailLabel.text = "Email: vincentpan0818@gmail.com"
        let currentMode = UITraitCollection.current.userInterfaceStyle
        if currentMode == .light {
            self.navigationController?.navigationBar.tintColor = .black
            self.navigationController?.navigationBar.backgroundColor = .clear
            backgroundColor()
        } else {
            self.navigationController?.navigationBar.tintColor = .white
        }
    }
    
    func backgroundColor() {
         let gradientLayer = CAGradientLayer()
         gradientLayer.frame = view.bounds
         gradientLayer.colors = [UIColor.white.cgColor, UIColor.orange.cgColor]
         view.layer.insertSublayer(gradientLayer, at: 0)
    }

}
