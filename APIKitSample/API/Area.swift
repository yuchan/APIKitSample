//
//  Area.swift
//  APIKitSample
//
//  Created by Yusuke Ohashi on 2017/11/13.
//  Copyright © 2017 Yusuke Ohashi. All rights reserved.
//

import Foundation
import APIKit

class Area {
    var areas: [AreaClass]?
    
    init(object: Any) throws {
        guard let dictionary = object as? [String: Any],
            let rateDictionary = dictionary["areaClasses"] as? [String: Any] else {
                throw ResponseError.unexpectedObject(object)
        }
        
        areas = Area.generateAreas(type: .large, parentCode: "", object: rateDictionary)
    }
    
    static func generateAreas(type: AreaClass.ClassType, parentCode: String, object: [String: Any]) -> [AreaClass] {
        var classesKey: String
        var classKey: String
        
        switch type {
        case .large:
            classesKey = "largeClasses"
            classKey = "largeClass"
        case .middle:
            classesKey = "middleClasses"
            classKey = "middleClass"
        case .small:
            classesKey = "smallClasses"
            classKey = "smallClass"
        case .detail:
            classesKey = "detailClasses"
            classKey = "detailClass"
        default:
            classesKey = ""
            classKey = ""
        }
        
        var classes: [AreaClass] = [AreaClass]()
        
        guard let largeClasses = object[classesKey] as? [[String: Any]] else {
            return classes
        }
        
        for klass in largeClasses {
            var dict = [[String: Any]]()
            if type != .detail {
                guard let d = klass[classKey] as? [[String: Any]] else {
                    continue
                }
                dict = d
            } else {
                guard let d = klass[classKey] as? [String: Any] else {
                    continue
                }
                dict = [d]
            }
            
            do {
                let ac: AreaClass = try AreaClass(type: type, object: dict)
                ac.codes.append(parentCode)
                classes.append(ac)
            } catch {
                continue
            }
        }
        
        return classes
    }
}
