//
//  ShareViewController.swift
//  ImageShareExtension
//
//  Created by sulayman on 24/7/18.
//  Copyright © 2018 sulayman. All rights reserved.
//

import UIKit
import Social

class ShareViewController: SLComposeServiceViewController {

    override func isContentValid() -> Bool {
        // Do validation of contentText and/or NSExtensionContext attachments here
        return true
    }

    override func didSelectPost() {
        // This is called after the user selects Post. Do the upload of contentText and/or NSExtensionContext attachments.
    
        // Inform the host that we're done, so it un-blocks its UI. Note: Alternatively you could call super's -didSelectPost, which will similarly complete the extension context.
        if let item = self.extensionContext?.inputItems[0] as? NSExtensionItem{
            for ele in item.attachments!{
                let itemProvider = ele as! NSItemProvider
                
                if itemProvider.hasItemConformingToTypeIdentifier("public.jpeg"){
                    NSLog("itemprovider: %@", itemProvider)
                    itemProvider.loadItem(forTypeIdentifier: "public.jpeg", options: nil, completionHandler: { (item, error) in
                        
                        var imgData: Data!
                        if let url = item as? URL{
                            imgData = try! Data(contentsOf: url)
                        }
                        
                        if let img = item as? UIImage{
                            imgData = UIImagePNGRepresentation(img)
                        }
                        
                        let dict: [String : Any] = ["imgData" :  imgData, "name" : self.contentText]
                        let userDefault = UserDefaults.standard
                        userDefault.addSuite(named: "group.mlbd.shareImage")
                        userDefault.set(dict, forKey: "img")
                        userDefault.synchronize()
                    })
                }
            }
        }
        
        self.extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
        
        let appName = "kuno"
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

    override func configurationItems() -> [Any]! {
        // To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
        return []
    }
    

}
