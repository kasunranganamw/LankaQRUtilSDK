//
//  ViewController.swift
//  LankaQRUtilSDK
//
//  Created by kasunranganamw@gmail.com on 09/24/2020.
//  Copyright (c) 2020 kasunranganamw@gmail.com. All rights reserved.
//

import UIKit
import LankaQRUtilSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let lankaQRReader = LankaQRReader()
        if (lankaQRReader.parseData(qrString: "12121212")) {
            print("SUCCESS")
        } else {
            print("FAILED")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

