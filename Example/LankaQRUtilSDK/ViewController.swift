//
//  ViewController.swift
//  LankaQRUtilSDK
//
//  Created by kasunranganamw@gmail.com on 09/24/2020.
//  Copyright (c) 2020 kasunranganamw@gmail.com. All rights reserved.
//

import UIKit
import LankaQRUtilSDK
import MPQRCoreSDK

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // SWIFT
        let lankaQRReader = LankaQRReader()
        lankaQRReader.setLogging(logRequired: true)
//        let pushPaymentData = lankaQRReader.parseQR(qrString: "0002010102112632002816728000581200000000100000055204581253031445502015802LK5909Vits Food6007Colombo61050080062580032537c0a88562e4a599cab63d1992f0dac05181600766683296-000563042AB7") // Sample QR String
        
//        let pushPaymentData = lankaQRReader.parseQR(qrString: "0002010102112632002816861001000000000000022202225204939953031445802LK5911ABC Grocery6003cbc62130509LOLC_IPAY85310012IPAY_INS_REF0111Q00000147556304AC66") // Sample QR String
        
        let pushPaymentData = lankaQRReader.parseQR(qrString: "000201010212263200281601000000050001999900503292520499995303144540450005802LK5911With Amount6007Colombo61050020062190503***0708400232926304760C") // Sample QR String
        
        if ((pushPaymentData) != nil) {
            var result: String?
            do {
                try result = pushPaymentData?.generatePushPaymentString()
                print("-------------------- RESULT IN SWIFT EXAMPLE --------------------\n", result!)
            } catch {

            }
        } else {
            print("INVALID QR")
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

//        Moving to Objective-C
//        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "FirstView")
//        self.present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

