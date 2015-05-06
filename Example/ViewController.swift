//
//  ViewController.swift
//  Example
//
//  Created by to4iki on 5/5/15.
//  Copyright (c) 2015 to4iki. All rights reserved.
//

import UIKit
import Codic

class ViewController: UIViewController {
    
    // your api access_key
    let client = Codic.Client(accessKey: SecretsPlist.getValue(.CodicAccessKey))
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let request = client.lookup("term")
        request.onComplete(
            resolve: {
                for result in $0 {
                    println(result.description)
                }
            },
            reject: {
                println($0.description)
            }
        )
        request.resume()
    }
}

struct SecretsPlist {
    
    enum Key: String {
        case CodicAccessKey = "CodicAccessKey"
    }
    
    static func getValue(key: Key) -> String {
        let secretsURL = NSBundle.mainBundle().URLForResource("secrets", withExtension: "plist")!
        let secrets = NSDictionary(contentsOfURL: secretsURL)!
        return secrets[key.rawValue] as! String
    }
}