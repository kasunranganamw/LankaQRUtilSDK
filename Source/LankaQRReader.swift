//
//  LankaQRReader.swift
//  LankaQRUtilSDK
//
//  Created by Kasun Rangana M W on 9/24/20.
//

import Foundation
import MPQRCoreSDK

@objc public class LankaQRReader: NSObject {
    
    var originalQRString: String?
    var modifiedQRString: String?
    var tagValueDict: NSMutableDictionary?
    var subTagValueDict: NSMutableDictionary?
    var pushPaymentData: PushPaymentData?
    var modifiedPushPaymentData: PushPaymentData?
    var isLogRequired: Bool
    var isError: Bool
    
    override public init() {
        originalQRString = ""
        modifiedQRString = ""
        tagValueDict = NSMutableDictionary()
        subTagValueDict = NSMutableDictionary()
        pushPaymentData = PushPaymentData()
        modifiedPushPaymentData = PushPaymentData()
        isLogRequired = false
        isError = false
    }
    
    @objc public func getTagValueDict() -> NSMutableDictionary? {
        return tagValueDict
    }
    
    @objc public func getOriginalQRString() -> String? {
        return originalQRString
    }
    
    @objc public func getModifiedQRString() -> String? {
        return modifiedQRString
    }
    
    @objc public func setLogging(logRequired: Bool) {
        isLogRequired = logRequired
    }
    
    @objc public func parseQR(qrString: String) -> PushPaymentData? {
        originalQRString = qrString
        if (isLogRequired) {
            print("-------------------- ORIGINAL STRING --------------------\n", originalQRString!)
        }
        
        let mpqrPushPaymentData: PushPaymentData
        let mpqrResult: String
        do {
            try mpqrPushPaymentData = MPQRParser.parseWithoutTagValidationAndCRC(originalQRString!)
            try mpqrResult = modifiedPushPaymentData!.generatePushPaymentString()
            if (isLogRequired) {
                print("-------------------- MPQR PUSH PAYMENT DATA --------------------\n", mpqrResult)
            }
            return mpqrPushPaymentData
        } catch {
            if (isLogRequired) {
                print("-------------------- ", error, " --------------------\n-------------------- Generating New Push Payment Data --------------------\n")
            }
            generatePushPaymentData()
            if (isError) {
                return nil
            } else {
                return modifiedPushPaymentData
            }
        }
    }
    
    func generatePushPaymentData() {
        self.parseData(code: originalQRString!)
        
//        if let dict = tagValueDict {
//            for (key, value) in dict {
//                setPushPaymentData(tag: key as! String, value: value as! String)
//            }
//        }
        
        generateModifiedQRString()
        if (isLogRequired) {
            print("-------------------- NEW STRING --------------------\n", modifiedQRString!)
        }
        
        let result: String
        do {
            try modifiedPushPaymentData = MPQRParser.parseWithoutTagValidationAndCRC(modifiedQRString!)
            try result = modifiedPushPaymentData!.generatePushPaymentString()
            if (isLogRequired) {
                print("-------------------- NEW PUSH PAYMENT DATA --------------------\n", result)
            }
        } catch {
            if (isLogRequired) {
                print(error)
            }
        }
    }
    
    func parseData(code: String) {
        let full = code
        var rest = ""
        
        if (full.count < 4) {
            isError = true
            return
        }
        let tag = (full as NSString).substring(to: 2)
        rest = (full as NSString).substring(from: 2)
        
        if (rest.count < 4) {
            isError = true
            return
        }
        let length = (rest as NSString).substring(to: 2)
        rest = (rest as NSString).substring(from: 2)
        
        
        let len = Int(length) ?? 0
        
        if (len == 0 || rest.count < len) {
            isError = true
            return
        }
        let value = (rest as NSString).substring(to: Int(length) ?? 0)
        rest = (rest as NSString).substring(from: Int(length) ?? 0)

        tagValueDict?[tag] = value

        if rest.count > 0 {
            self.parseData(code: rest)
        }
    }
    
    // incomplete, need to add all tags here
    func setPushPaymentData(tag: String, value: String) {
        switch tag {
        case "00":
            pushPaymentData?.payloadFormatIndicator = value
            break
        case "01":
            pushPaymentData?.pointOfInitiationMethod = value
            break
        case "26":
            setSubTagDict(rootTag: tag, code: value)
            let maiData = MAIData()
            maiData.setRootTag(tag)
            maiData.AID = getSubTagValue(rootTag: tag, tag: "00")
            do {
                try pushPaymentData?.setDynamicMAIDTag(maiData)
            } catch {
                if (isLogRequired) {
                    print(error)
                }
            }
            break
        case "52":
            pushPaymentData?.merchantCategoryCode = value
            break
        case "53":
            pushPaymentData?.transactionCurrencyCode = value
            break
        case "55":
            pushPaymentData?.tipOrConvenienceIndicator = value
            break
        case "58":
            pushPaymentData?.countryCode = value
            break
        case "59":
            pushPaymentData?.merchantName = value
            break
        case "60":
            pushPaymentData?.merchantCity = value
            break
        case "61":
            pushPaymentData?.postalCode = value
            break
        case "62":
            setSubTagDict(rootTag: tag, code: value)
            let additionalData = AdditionalData()
            // tag 00 is received here for LankaQR but no 00 subtag defined
            additionalData.setRootTag(tag)
            additionalData.referenceId = getSubTagValue(rootTag: tag, tag: "05")
            pushPaymentData?.additionalData = additionalData
            break
        case "63":
//            pushPaymentData?.crc = value  // CRC value is automatically calculated
            break
        default:
            break
        }
    }
    
    func setSubTagDict(rootTag: String, code: String) {
        let full = code
        var rest = ""

        let tag = (full as NSString).substring(to: 2)
        rest = (full as NSString).substring(from: 2)

        let length = (rest as NSString).substring(to: 2)
        rest = (rest as NSString).substring(from: 2)

        let value = (rest as NSString).substring(to: Int(length) ?? 0)
        rest = (rest as NSString).substring(from: Int(length) ?? 0)
        
        let currentTagValueDict = NSMutableDictionary()
        currentTagValueDict[tag] = value
        subTagValueDict![rootTag] = currentTagValueDict
        
        if rest.count > 0 {
            setSubTagDict(rootTag:rootTag, code: rest)
        }
    }
    
    public func getSubTagValue(rootTag: String, tag: String) -> String {
        var result = ""
        var rootTagDict: NSMutableDictionary?
        
        // find dictionary for rootTag
        if let dict = subTagValueDict {
            for (key, value) in dict {
                if (rootTag == key as! String) {
                    rootTagDict = value as? NSMutableDictionary
                    break
                }
            }
        }
        
        // find value in selected dictionary
        if let dict = rootTagDict {
            for (key, value) in dict {
                if (tag == key as! String) {
                    result = value as! String
                    break
                }
            }
        }
        return result
    }
    
    func generateModifiedQRString() {
        let sortedDict = getSortedDict(inputDict: tagValueDict)
        for (key, value) in sortedDict {
            if (String(key) == "62") {
                let subTagDict62 = subTagValueDict!["62"] as! NSMutableDictionary?
                let sortedDict = getSortedDict(inputDict: subTagDict62)
                
                var subTag62String = ""
                for (key, value) in sortedDict {
                    let keyString = zeroPadLength(value: String(key))
                    if (keyString != "00") {
                        subTag62String += keyString
                        subTag62String += zeroPadLength(value: String(value.count))
                        subTag62String += value
                    }
                }
                if (subTag62String.count > 0) {
                    modifiedQRString? += "62"
                    modifiedQRString? += zeroPadLength(value: String(subTag62String.count))
                    modifiedQRString? += subTag62String
                }
            } else {
                modifiedQRString? += zeroPadLength(value: String(key))
                modifiedQRString? += zeroPadLength(value: String(value.count))
                modifiedQRString? += value
            }
        }
    }
    
    func zeroPadLength(value: String) -> String {
        var result = value
        if (value.count < 2) {
            result = "0" + result
        }
        return result
    }
    
    // Sort inputted dictionary with keys alphabetically.
    func getSortedDict(inputDict: NSMutableDictionary?) -> [(key: Int, value: String)] {
        var resultDict = [Int: String]()
        if let dict = inputDict {
            for (key, value) in dict {
                let keyStr = Int(key as! String)
                resultDict[keyStr!] = value as? String
            }
        }
        let sorted = resultDict.sorted(by: { $0.key < $1.key })
        return sorted
    }
}
