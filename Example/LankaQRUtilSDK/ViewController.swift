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
        if (lankaQRReader.parseQR(qrString: "0002010102112632002816728000581200000000100000055204581253031445502015802LK5909Vits Food6007Colombo61050080062580032537c0a88562e4a599cab63d1992f0dac05181600766683296-000563042AB7")) {
            let tagValueDict = lankaQRReader.getTagValueDict()
            let subTagValueDict62 = lankaQRReader.getSubTagValueDict62()
            let subTagValueDict84 = lankaQRReader.getSubTagValueDict84()
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

