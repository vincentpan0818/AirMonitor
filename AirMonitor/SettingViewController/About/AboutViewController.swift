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
    
    

    
    func version(){
        
        let bundle = Bundle(identifier: "com.vincent.AirMonitor")!
        let infoDictionary = bundle.infoDictionary!
        let version = infoDictionary["CFBundleVersion"] as! String
        let shortVersion = infoDictionary["CFBundleShortVersionString"] as! String
        versionLabel.text = "App version: \(shortVersion) build \(version)"
        //let label = versionLabel.text!
        
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
