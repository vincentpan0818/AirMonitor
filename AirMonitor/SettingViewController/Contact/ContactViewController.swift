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
        self.navigationController?.navigationBar.tintColor = .black
        
        emailLabel.text = "Email: vincentpan0818@gmail.com"
        
        
        backgroundColor()
        // Do any additional setup after loading the view.
    }
    
    func backgroundColor() {
         let gradientLayer = CAGradientLayer()
         gradientLayer.frame = view.bounds
         gradientLayer.colors = [UIColor.white.cgColor, UIColor.orange.cgColor]
         view.layer.insertSublayer(gradientLayer, at: 0)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
