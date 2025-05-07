//
//  String+Extension.swift
//  HealthNJ
//
//  Created by 郑恒 on 2023/2/1.
//  Copyright © 2023 sunnyhealth. All rights reserved.
//

import Foundation

public extension String {
    
    var isNotEmpty: Bool {!isEmpty}    
    
    func toDate(_ format: String = "yyyy.MM.dd") -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self) ?? Date()
    }
    
}

public extension String {
    /// 转为数组对象，如果可以的话
    var jsonArray: [Any]? {
        if let data = self.data(using: String.Encoding.utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [Any]
            }
            catch {
                return nil
            }
        }
        else {
            return nil
        }
    }
}

// 处理打印unicode
public extension String {
    
    var deunicodeDescription : String {
        return self.description.stringByReplaceUnicode
    }
    
    var stringByReplaceUnicode : String {
        let tempStr1 = self.replacingOccurrences(of: "\\u", with: "\\U")
        let tempStr2 = tempStr1.replacingOccurrences(of: "\"", with: "\\\"")
        let tempStr3 = "\"".appending(tempStr2).appending("\"")
        let tempData = tempStr3.data(using: String.Encoding.utf8)
        var returnStr:String = ""
        do {
            returnStr = try PropertyListSerialization.propertyList(from: tempData!, options: [.mutableContainers], format: nil) as! String
        } catch {
            print(error)
        }
        return returnStr.replacingOccurrences(of: "\\n", with: "\n")
    }
    
    var descriptionCN : String {
        if let data = self.data(using: .utf8, allowLossyConversion: true),
            let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers),
            let jsonData = try? JSONSerialization.data(withJSONObject: json, options: .prettyPrinted),
            let pretty = String(data: jsonData, encoding: .utf8) {
            return pretty
        }
        return self
    }
}
