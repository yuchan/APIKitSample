//
//  AreaRequest.swift
//  APIKitSample
//
//  Created by Yusuke Ohashi on 2017/11/10.
//  Copyright © 2017 Yusuke Ohashi. All rights reserved.
//

import UIKit
import APIKit

struct AreaRequest: Request {
    var baseURL: URL {
        return URL(string: "https://app.rakuten.co.jp")!
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var path: String {
        return "/services/api/Travel/GetAreaClass/20131024"
    }
    
    var parameters: Any? {
        return [
            "format": "json",
            "applicationId": 1055589361237552135
        ]
    }
    
    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Area {
        return try Area(object: object)
    }
    
    typealias Response = Area
}
