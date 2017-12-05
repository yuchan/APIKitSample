//
//  AreaClass.swift
//  APIKitSample
//
//  Created by Yusuke Ohashi on 2017/11/13.
//  Copyright © 2017 Yusuke Ohashi. All rights reserved.
//

import Foundation
import APIKit

class AreaClass {
    enum ClassType {
        case large, middle, small, detail, none
    }
    
    var type: ClassType = .large
    var areas: [AreaClass] = [AreaClass]()
    var codes: [String] = [String]()
    let code: String
    let name: String
    
    init(type: ClassType, object: Any) throws {
        var codeKey: String
        var nameKey: String
        
        switch type {
        case .large:
            codeKey = "largeClassCode"
            nameKey = "largeClassName"
        case .middle:
            codeKey = "middleClassCode"
            nameKey = "middleClassName"
        case .small:
            codeKey = "smallClassCode"
            nameKey = "smallClassName"
        case .detail:
            codeKey = "detailClassCode"
            nameKey = "detailClassName"
        case .none:
            codeKey = ""
            nameKey = ""
        }
        
        guard let dictionary = object as? [[String: Any]] else {
            throw ResponseError.unexpectedObject(object)
        }
        
        code = dictionary[0][codeKey] as! String
        name = dictionary[0][nameKey] as! String
        
        var childClass: ClassType
        
        if type == .large {
            childClass = .middle
        } else if type == .middle {
            childClass = .small
        } else if type == .small {
            childClass = .detail
        } else {
            childClass = .none
        }
        
        if childClass != .none, dictionary.count > 1 {
            areas = Area.generateAreas(type: childClass, parentCode: code, object: dictionary[1])
        }
    }
}
