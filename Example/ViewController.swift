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
    
    let client = Codic.Client(accessKey: "fxaVjZhq2WFK")
    //    let client = Codic.Client(accessKey: "test")
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let request = client.fetchUserDictionaries()
        request.fold(
            resolve: { dictionaries in
                for dictionary in dictionaries {
                    println(dictionary.description)
                }
            },
            reject: { error in
                println(error)
            }
        )
        
        
        request.resume()
    }
}

