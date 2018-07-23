//
//  ViewController.swift
//  RNDiOSExtension
//
//  Created by sulayman on 23/7/18.
//  Copyright © 2018 sulayman. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
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

