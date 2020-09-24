//
//  LankaQRReader.swift
//  LankaQRUtilSDK
//
//  Created by Kasun Rangana M W on 9/24/20.
//

import Foundation

public class LankaQRReader {
    
    public init() {}
    
    public func parseData(qrString: String) -> Bool {
        return (qrString.count > 4) ? true : false
    }
    
}
