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
    
    let client = Codic.Client(accessKey: "your api access_key")
    
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

