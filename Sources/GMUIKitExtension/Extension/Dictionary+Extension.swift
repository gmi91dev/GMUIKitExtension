//
//  Dictionary+Extension.swift
//  Neat and orderly
//
//  Created by gmi91 on 2023/2/15.
//

import Foundation

public extension Dictionary {
    /// 转json字符串
    func toJsonString() -> String {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: self, options: .fragmentsAllowed)
            let jsonStr = String(data: jsonData, encoding: .utf8)
            return jsonStr ?? ""
        }catch {
            return ""
        }
    }
}

// 处理打印unicode
public extension Dictionary {
    
    var deunicodeDescription : String {
        return self.description.stringByReplaceUnicode
    }
    
    var descriptionCN : String {
        if let jsonData = try? JSONSerialization.data(withJSONObject: self, options: .prettyPrinted),
            let pretty = String(data: jsonData, encoding: .utf8) {
            return pretty
        }
        return self.description
    }
}
