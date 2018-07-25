//
//  ViewController.swift
//  RNDiOSExtension
//
//  Created by sulayman on 23/7/18.
//  Copyright © 2018 sulayman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
//        let userDefault = UserDefaults.standard
//        userDefault.addSuite(named: "group.mlbd.shareImage")
        if  let userDefault =  UserDefaults.init(suiteName: "group.mlbd.shareImage") {
            print("userdefault found")

        if let dict = userDefault.value(forKey: "img") as? NSDictionary {
            print("dict found")

            let data = dict.value(forKey: "imgData") as! Data
            let str = dict.value(forKey: "name") as! String
            
            self.imageView.image = UIImage.init(data: data)
            
            userDefault.removeObject(forKey: "img")
            userDefault.synchronize()
        } else {
            print("no dictionary found")
        }
        } else {
            print("no user default found or created")

        }
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func startInstagram(_ sender: UIButton) {
        
        
        let appName = "launch-OfficeLens"
        let appScheme = "\(appName)://app"
        let appUrl = URL(string: appScheme)
        

        if UIApplication.shared.canOpenURL(appUrl! as URL)
        {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(appUrl!)
            } else {
                // Fallback on earlier versions
            }

        } else {
            print("App not installed")
        }
        
    }
    
}

