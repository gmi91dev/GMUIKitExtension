// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public final class Logger: LogPrintable {
    private init() {}
}

/// 只在debug中打印(打印完立即换行)
public func DPrint(_ item: @autoclosure () -> Any) {
    #if DEBUG
    print(item())
    #endif
}

/// 打印所有实例变量列表
public func PrintIvarList(classString: String) {
    #if DEBUG
    print("\n\n ********** \(classString)  IvarList ****************\n")
    
    var count:UInt32 = 0
    let list = class_copyIvarList(NSClassFromString(classString), &count)
    for i in 0 ..< Int(count) {
        let ivar = list![i]
        let name = ivar_getName(ivar)
        let type = ivar_getTypeEncoding(ivar)
        print( String(cString: name!),"-----",String(cString: type!),"\n")
    }
    #endif
}

/// 打印属性列表
public func PrintPropertyList(classString: String) {
    #if DEBUG
    print("\n\n ********** \(classString)  PropertyList ****************\n")
    var count:UInt32 = 0
    let list = class_copyPropertyList(NSClassFromString(classString), &count)
    for i in 0 ..< Int(count) {
        let property = list![i]
        let name = property_getName(property)
        let type = property_getAttributes(property)
        print( String(cString: name),"------",String(cString: type!),"\n")
    }
    #endif
}

public func PrintObject(_ item: Any?) {
    #if DEBUG
    if let de = deunicodeObject(item) {
        print(de)
    }else {
        print(item ?? "nil")
    }
    #endif
}

public func PrintJSON(_ item: String?) {
    #if DEBUG
    if let value = item {
        print(value.descriptionCN)
    }else {
        print(item ?? "nil")
    }
    #endif
}

/// 只在debug中打印(打印完立即换行)
private func deunicodeObject(_ item: Any?) -> String? {
    if let dic = item as? [String: Any] {
        return dic.descriptionCN
    }
    if let arr = item as? [Any] {
        return arr.descriptionCN
    }
    if let str = item as? String {
        return str.descriptionCN
    }
    return nil
}

protocol LogPrintable {}
extension LogPrintable {
    
    /// 用于定位代码位置的打印，仅在debug模式下可用
    static func debugLogger(_ item: Any? = nil, line: Any = #line, function: Any = #function, filepath: Any = #file) {
        #if DEBUG
        print("************************** \(type(of: self)) **************************")
        print(filepath)
        let time = Date().toString("yyyy-MM-dd HH:mm:ss")
        if let tmp = item {
            print(["\(time) [\(type(of: self))](line: \(line)) -> \(function):", tmp], separator: "\n", terminator: "\n")
        }else {
            print("\(time) [\(type(of: self))](line: \(line)) -> \(function):", separator: "\n", terminator: "\n")
        }
        print(filepath)
        print("************************** \(time) **************************")
        #else
        #endif
    }
    
}

extension Date {
    
    /// 日期转字符串
    func toString(_ dateFormatter: String = "yyyy-MM-dd") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatter
        return formatter.string(from: self)
    }
    
    /// 获取时间字符串
    func time(_ dateFormatter: String = "HH:mm") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormatter
        return formatter.string(from: self)
    }
    
}






