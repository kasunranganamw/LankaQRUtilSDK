//
//  LankaQRReader.swift
//  LankaQRUtilSDK
//
//  Created by Kasun Rangana M W on 9/24/20.
//

import Foundation

public class LankaQRReader {
    
    public init() {}
    
    var tagArr: NSMutableArray?
    var valueArr: NSMutableArray?
    var tagValueDict: NSMutableDictionary?
    var subTagValueDict62: NSMutableDictionary?
    var subTagValueDict84: NSMutableDictionary?
    
    public func parseQR(qrString: String) -> Bool {
        tagArr = NSMutableArray()
        valueArr = NSMutableArray()
        tagValueDict = NSMutableDictionary()
        subTagValueDict62 = NSMutableDictionary()
        subTagValueDict84 = NSMutableDictionary()
        
        self.parseData(code: qrString)
        let subTlv62 = tagValueDict?["62"] as? String
        if (subTlv62?.count ?? 0) > 0 {
            parseSubData(code: subTlv62!, subTagValueDict: subTagValueDict62)
        }
        let subTlv84 = tagValueDict?["84"] as? String
        if (subTlv84?.count ?? 0) > 0 {
            parseSubData(code: subTlv84!, subTagValueDict: subTagValueDict84)
        }
        
        return (tagValueDict?.count ?? 0 > 0) ? true : false
    }
    
    
    func parseData(code: String) {
        let full = code
        var rest = ""

        let tag = (full as NSString).substring(to: 2)
        rest = (full as NSString).substring(from: 2)

        let length = (rest as NSString).substring(to: 2)
        rest = (rest as NSString).substring(from: 2)

        let value = (rest as NSString).substring(to: Int(length) ?? 0)
        rest = (rest as NSString).substring(from: Int(length) ?? 0)

        tagValueDict?[tag] = value as AnyObject

        if rest.count > 0 {
            self.parseData(code: rest)
        }
    }
    
    func parseSubData(code: String, subTagValueDict: NSMutableDictionary?) {
        let subTagValueDict = subTagValueDict
        
        let full = code
        var rest = ""

        let tag = (full as NSString).substring(to: 2)
        //    _tagArr = [_tagArr arrayByAddingObject:tag];
        rest = (full as NSString).substring(from: 2)

        let length = (rest as NSString).substring(to: 2)
        rest = (rest as NSString).substring(from: 2)

        let value = (rest as NSString).substring(to: Int(length) ?? 0)
        //    _valueArr = [_valueArr arrayByAddingObject:value];
        rest = (rest as NSString).substring(from: Int(length) ?? 0)

        subTagValueDict?[tag] = value as AnyObject

        if rest.count > 0 {
            parseSubData(code: rest, subTagValueDict: subTagValueDict)
        }
    }
    
    public func getTagValueDict() -> NSMutableDictionary? {
        return tagValueDict
    }
    
    public func getSubTagValueDict62() -> NSMutableDictionary? {
        return subTagValueDict62
    }
    
    public func getSubTagValueDict84() -> NSMutableDictionary? {
        return subTagValueDict84
    }
}
